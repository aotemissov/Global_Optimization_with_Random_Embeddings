function Results = solvers_REGO(name_of_function,name_of_solver,Results)
% This function 
% name_of_function - 
% name_of_solver - the name of the optimization solver, e.g. DIRECT, BARON, KNITRO
% Results - a structure array where the data from the experiment is saved

% NOTE: to initiate the `no embedding', REGO and/or X-REGO experiments run main.m file 

global rotation_matrices

tol = 10^(-3);

idx = strfind(name_of_function,'_');
idx = idx(end);
low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed

[dim, min, argmin, bounds] = Extract_function(low_dim_function_name); %get the effective dimension of the function to set maximum budget

D = str2num(name_of_function(idx+1:end)); %get the ambient dimension of the function

diff_d_and_de = [0 1 2 3]; %we vary parameter d-d_e from 0 to 3
list_of_delta = sqrt(dim)*[8.0 2.2 1.3 1.0]; %list of delta's (used in pair, respectively,
%with d=d_e+0,1,2,3), set based on theoretical bounds
N = 100; %given a problem with a certain (fixed) set of parameters, number of times we solve this problem
Q = rotation_matrices.(name_of_function);

for iterate_d = 1:length(diff_d_and_de)
    d = dim + diff_d_and_de(iterate_d);
    delta = list_of_delta(iterate_d);
    
    x0 = zeros(d,1); %initial starting point to be used by BARON
    
    %next we specify lower and upper bounds for y since we are optimizing over Y = [-delta,delta]^d
    lb = -delta*ones(d,1);
    ub =  delta*ones(d,1);
    
    %we will keep track of the number of instances where y^* is inside Y = [-delta,delta]^d box
    y_in_Y_box = 0;
    
    for i = 1:N
        
        A = randn(D,d);
        B = Q'*A;
        
        %the following lines determine whether there is at least one minimizer y^* that is inside Y box
        %first we rescale argmin so that bounds are a standard box
        [m1, m2] = size(argmin);
        scaled_argmin = zeros(m1,m2);
        for m = 1:m2
            for n = 1:m1
                scaled_argmin(n,m) = (2*argmin(n,m) - bounds(n,2) - bounds(n,1))/(bounds(n,2)-bounds(n,1));
            end
        end
        
        %using linear program now we determine whether there is at least one y^* that satisfies By^* = scaled_argmin and y^* is in Y box
        for k = 1:m2
            [~, ~, exitflag] = linprog(zeros(1,d),[],[],B,scaled_argmin(:,k),lb,ub,[],optimset('Display', 'off'));
            if (exitflag == 1)
                y_in_Y_box = y_in_Y_box + 1;
                break;
            end
        end
        
        switch name_of_solver
            case 'BARON'
                maxtime = 200*dim; %maximum budget time per problem is 200*effective_dimension CPU seconds
                
                fun = @(y) Test_set(A*y,name_of_function);
                
                %the name of the file where BARON will store information during the run:
                filename = randi([1 100000],1,1);
                filename = strcat('B',num2str(filename));
                
                %BARON options:
                opts = struct('maxtime', maxtime, 'epsa', tol, 'nlpsol', 9, 'prlevel', 1, ...
                    'brvarstra', 1, 'brptstra', 1, 'numloc', 0, 'barscratch', filename);
                
                %optimizing with BARON solver:
                [ymin,fmin,~,info] = baron(fun,[],[],[],lb,ub,[],[],[],[],x0,opts);
                
                xmin = A*ymin;
                
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_ymin')) = ymin;
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_xmin')) = xmin;
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_fmin')) = fmin;
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_info')) = info;
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_time')) = info.Total_Time;
                
            case 'DIRECT'
                maxevals = 10000*dim; %maximum budget per problem is 10000*effective_dimension function evaluations
                
                options.testflag  = 1; options.showits  = 1; options.maxevals = maxevals;
                options.maxits = Inf; options.globalmin = min;
                if (min == 0)
                    options.tol = 100*tol;
                else
                    options.tol = (100*tol)/abs(min);
                end
                
                fun.f = @(y) Test_set(A*y,name_of_function);
                
                %optimizing with DIRECT solver and recording CPU time:
                cpu_time_start = cputime;
                [fmin,ymin,hist] = Direct(fun,[lb ub],options);
                cpu_time_finish = cputime - cpu_time_start;
                
                xmin = A*ymin;
                
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_ymin')) = ymin;
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_xmin')) = xmin;
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_fmin')) = fmin;
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_funeval')) = hist(size(hist,1),2);
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_time')) = cpu_time_finish;
                
            case 'KNITRO'
                num_start_points = 20*dim;
                
                options = optimset('Display','on');
                
                %create options file for the function, which will store, for example, info about the number of starting points
                problem_options_file = strcat('knitro_options.opt');
                fileID = fopen(problem_options_file,'w');
                fprintf(fileID, 'ms_enable %i\n', 1);
                fprintf(fileID, 'ms_savetol %1.6f\n', 0.000001);
                fprintf(fileID, 'fstopval %6.6f\n', min+tol); %stop when f_solver < min + tol
                fprintf(fileID, 'ms_maxsolves %i\n', num_start_points); %number of starting points is 20*effective_dimension
                fclose(fileID);
                
                fun = @(y) Test_set(A*y,name_of_function);
                
                cpu_time_start = cputime;
                [ymin,fmin,~,output,~,~,~] = knitromatlab(fun,x0,[],[],[],[],lb,ub,[],[],options,problem_options_file);
                cpu_time_finish = cputime - cpu_time_start;
                
                xmin = A*ymin;
                
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_fmin')) = fmin;
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_ymin')) = ymin;
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_xmin')) = xmin;
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_funeval')) = output.funcCount;
                Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_',num2str(i),'_time')) = cpu_time_finish;
                
                %case YOUR_SOLVER (add your own solver here)
        end
    end
    
    Results.(strcat(name_of_function,'_',num2str(iterate_d-1),'_y_in_Y_box')) = y_in_Y_box/N;
end
end
