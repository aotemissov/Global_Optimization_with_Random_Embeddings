function Results = solvers_no_emb_vs_REGO(name_of_function,name_of_solver,Results)

% name_of_function - 
% name_of_solver - 
% Results - 

global rotation_matrices

tol = 10^(-3);
idx = strfind(name_of_function,'_');
idx = idx(end);
low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed

[dim, min, ~, ~] = Extract_function(low_dim_function_name); %get the effective dimension of the function to set maximum budget

D = str2num(name_of_function(idx+1:end)); %get the ambient dimension of the function

x0 = zeros(D,1); %initial starting point to be used by BARON

%next we specify lower and upper bounds for x since we are optimizing over X = [-1,1]^D
lb = -ones(D,1);
ub =  ones(D,1);

%no embedding to compare with REGO
switch name_of_solver
    case 'BARON'
        maxtime = 200*dim; %maximum budget time per problem is 200*effective_dimension CPU seconds

        fun = @(x) Test_set(x,name_of_function);

        %the name of the file where BARON will store information during the run:
        filename = randi([1 100000],1,1);
        filename = strcat('B',num2str(filename));

        %BARON options:
        opts = struct('maxtime', maxtime, 'epsa', tol, 'nlpsol', 9, 'prlevel', 1, ...
            'brvarstra', 1, 'brptstra', 1, 'numloc', 0, 'barscratch', filename);

        %optimizing with BARON solver:
        [xmin,fmin,~,info] = baron(fun,[],[],[],lb,ub,[],[],[],[],x0,opts);

        %saving results
        Results.(strcat(name_of_function,'_fmin')) = fmin;
        Results.(strcat(name_of_function,'_xmin')) = xmin;
        Results.(strcat(name_of_function,'_info')) = info;
        Results.(strcat(name_of_function,'_time')) = info.Total_Time;

    case 'DIRECT'

        maxevals = 10000*dim;  %maximum function evaluation budget per problem is 10000*effective_dimension

        fun.f = @(x) Test_set(x,name_of_function);

        %DIRECT options:
        options.testflag  = 1; options.showits  = 1; options.maxevals = maxevals;
        options.maxits = Inf; options.globalmin = min;

        %DIRECT uses relative tolerance criterion to determine if the current iterate
        %is close enough to the true solution, but we are using absolute tolerance
        %criterion. The below code makes DIRECT stop when the absolute tolerance
        %criterion is satisfied
        if (min == 0)
            options.tol = 100*tol;
        else
            options.tol = (100*tol)/abs(min);
        end

        %optimizing with DIRECT solver and recording CPU time:
        cpu_time_start = cputime;
        [fmin,xmin,hist] = Direct(fun,[lb ub],options);
        cpu_time_finish = cputime - cpu_time_start;

        %saving results
        Results.(strcat(name_of_function,'_fmin')) = fmin;
        Results.(strcat(name_of_function,'_xmin')) = xmin;
        Results.(strcat(name_of_function,'_funeval')) = hist(size(hist,1),2);
        Results.(strcat(name_of_function,'_time')) = cpu_time_finish;

    case 'KNITRO'
        num_start_points = 20*dim; %number of starting points in a multistat procedure

        options = optimset('Display','off');

        %create options file for the function, which will store, for example, info about the number of starting points
        problem_options_file = strcat('knitro_options.opt');
        fileID = fopen(problem_options_file,'w');
        fprintf(fileID, 'ms_enable %i\n', 1);
        fprintf(fileID, 'ms_savetol %1.6f\n', 0.000001);
        fprintf(fileID, 'fstopval %6.6f\n', min+tol); %stop when f_solver < min + tol
        fprintf(fileID, 'ms_maxsolves %i\n', num_start_points); %number of starting points is 100
        fclose(fileID);

        fun = @(x) Test_set(x,name_of_function);

        cpu_time_start = cputime;
        [xmin,fmin,~,output,~,~,~] = knitromatlab(fun,x0,[],[],[],[],lb,ub,[],[],options,problem_options_file);
        cpu_time_finish = cputime - cpu_time_start;

        Results.(strcat(name,'_',num2str(D),'_fmin')) = fmin;
        Results.(strcat(name,'_',num2str(D),'_xmin')) = xmin;
        Results.(strcat(name,'_',num2str(D),'_funeval')) = output.funcCount;
        Results.(strcat(name,'_',num2str(D),'_time')) = cpu_time_finish;

        %case YOUR_SOLVER (add your own solver here)
end

end
