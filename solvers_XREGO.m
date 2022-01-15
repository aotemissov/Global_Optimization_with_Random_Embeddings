function Results = solvers_XREGO(name_of_function,framework,name_of_solver,Results)
global rotation_matrices

tol = 10^(-3);

idx = strfind(name_of_function,'_');
idx = idx(end);
low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed

[dim, min, ~, ~] = Extract_function(low_dim_function_name); %get the effective dimension of the function to set maximum budget

D = str2num(name_of_function(idx+1:end)); %get the ambient dimension of the function

diff_d_and_de = [0 2]; %we test X-REGO for d = d_e + 0 and d = d_e + 2
N = 5; %given a problem with a certain (fixed) set of parameters, number of times we solve this problem

if strcmp(framework,'LAREGO') || strcmp(framework,'LNREGO')
    max_number_of_subspaces = 300; %maximum number of subspaces that one run of X-REGO will draw, for local versions of KNITRO it is set to 300
else
    max_number_of_subspaces = 100; %maximum number of subspaces that one run of X-REGO will draw
end

for iterate_d = 1:length(diff_d_and_de)
    d = dim + diff_d_and_de(iterate_d);
    
    x0 = zeros(d,1); %initial starting point
    
    for i = 1:N
        switch name_of_solver
            case 'BARON'
                UpperBound = Inf(1,max_number_of_subspaces+1); %stores computed upper bounds for the objective function
                LowerBound = -Inf(1,max_number_of_subspaces+1);%stores computed lower bounds for the objective function
                time = zeros(1,max_number_of_subspaces); %keep info about time spent per run
                ub_convergence = 0; %did we converge to the global minimum?
                
                subspace_count_last = max_number_of_subspaces;
                
                current_x = zeros(D,1);
                
                UpperBound(1) = Test_set(current_x,name_of_function); %we are starting at the origin, i.e. p^0 = 0, so initialize first upper bound to be the value of f at the origin
                LowerBound(1) = Test_set(current_x,name_of_function); %we are starting at the origin, i.e. p^0 = 0, so initialize first lower bound to be the value of f at the origin
                
                maxtime = 5; %maximum budget time per run (drawn subspace) is 5 CPU seconds
                
                for subspace_count = 1:max_number_of_subspaces
                    A = randn(D,d);
                    fun = @(y) Test_set(A*y+current_x,name_of_function);
                    
                    %the name of the file where BARON will store information during the run:
                    filename = randi([1 100000],1,1);
                    filename = strcat('B',num2str(filename));
                    opts = struct('maxtime', maxtime, 'epsa', tol, 'prlevel', 0, 'barscratch', filename);
                    
                    [ymin,~,~,info] = baron(fun,A,-ones(D,1) - current_x,ones(D,1) - current_x,[],[],[],[],[],[],x0,opts);
                    
                    switch framework
                        case 'AREGO'
                            if (info.Upper_Bound < UpperBound(subspace_count))
                                UpperBound(subspace_count+1) = info.Upper_Bound;
                                LowerBound(subspace_count+1) = info.Lower_Bound;
                                current_x = A*ymin + current_x;
                            else
                                UpperBound(subspace_count+1) = UpperBound(subspace_count);
                                LowerBound(subspace_count+1) = LowerBound(subspace_count);
                            end
                        case 'NREGO'
                            UpperBound(subspace_count+1) = info.Upper_Bound;
                            LowerBound(subspace_count+1) = info.Lower_Bound;
                    end
                    
                    time(subspace_count) = info.Total_Time;
                    
                    if (abs(UpperBound(subspace_count+1) - min) <= tol)
                        ub_convergence = 1;
                        subspace_count_last = subspace_count;
                        break;
                    end
                end
                
                %if we converged with less than *max_number_of_subspaces* of supspaces,
                %then drop the last elements of UpperBound, LowerBound and time
                UpperBound = UpperBound(1:subspace_count_last+1);
                LowerBound = LowerBound(1:subspace_count_last+1);
                time = time(1:subspace_count_last);
                
                Results.(strcat(name_of_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(i),'_UpperBound')) = UpperBound;
                Results.(strcat(name_of_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(i),'_LowerBound')) = LowerBound;
                Results.(strcat(name_of_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(i),'_time')) = time;
                Results.(strcat(name_of_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(i),'_ubconvergence')) = ub_convergence;
                
            case 'DIRECT'
                fvals = Inf(1,max_number_of_subspaces+1); % to keep best function values of an iteration
                time = zeros(1,max_number_of_subspaces); % keep info about time spent per run
                funevals = zeros(1,max_number_of_subspaces); % keep info about function evaluations spent per run
                subspace_count_last = max_number_of_subspaces;
                
                %DIRECT does not work if lower and upper bounds for y are not given
                lb = -2*sqrt(D)*ones(d,1);
                ub = 2*sqrt(D)*ones(d,1);
                
                current_x = zeros(D,1);
                fvals(1) = Test_set(current_x,name_of_function); %we are starting at the origin, i.e. p^0 = 0, so initialize first fvals to be the value of f at the origin
                
                maxevals = 3000; %maximum budget time per run (drawn subspace) is 3000 function evaluations
                
                options.testflag = 1; options.showits  = 0; options.maxevals = maxevals;
                options.maxits = Inf; options.globalmin = min; options.impcons = 1;
                
                if (min == 0)
                    options.tol = 100*tol;
                else
                    options.tol = tol*100/abs(min);
                end
                
                for subspace_count = 1:max_number_of_subspaces
                    A = randn(D,d);
                    fun.f = @(y) DIRECT_with_linear_constraints(A*y+current_x,name_of_function);
                    
                    cpu_time_start = cputime;
                    [fmin,ymin,hist] = Direct(fun,[lb ub],options);
                    cpu_time_finish = cputime - cpu_time_start;
                    
                    funevals(subspace_count) = hist(size(hist,1),2);
                    time(subspace_count) = cpu_time_finish;
                    
                    switch framework
                        case 'AREGO'
                            if (fmin < fvals(subspace_count))
                                fvals(subspace_count+1) = fmin;
                                current_x = A*ymin + current_x;
                            else
                                fvals(subspace_count+1) = fvals(subspace_count);
                            end
                            
                            
                        case 'NREGO'
                            fvals(subspace_count+1) = fmin;
                    end
                    
                    if (abs(fvals(subspace_count+1) - min) <= tol)
                        subspace_count_last = subspace_count;
                        break;
                    end
                end
                
                %if we converged with less than *max_number_of_subspaces* of supspaces,
                %then drop the last elements of fvals, funevals and time
                fvals = fvals(1:subspace_count_last+1);
                funevals = funevals(1:subspace_count_last);
                time = time(1:subspace_count_last);
                
                Results.(strcat(name_of_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(i),'_funvals')) = fvals;
                Results.(strcat(name_of_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(i),'_time')) = time;
                Results.(strcat(name_of_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(i),'_funeval')) = funevals;
                
            case 'KNITRO'
                options = optimset('Display','on');
                
                switch framework
                    case {'AREGO','NREGO'}
                        num_start_points = 5;
                    case {'LAREGO','LNREGO'}
                        num_start_points = 1;
                end
                
                problem_options_file = strcat('knitro_options.opt');
                fileID = fopen(problem_options_file,'w');
                fprintf(fileID, 'ms_enable %i\n', 1);
                fprintf(fileID, 'ms_savetol %1.6f\n', 0.000001);
                fprintf(fileID, 'fstopval %6.6f\n', min+tol);
                fprintf(fileID, 'ms_maxsolves %i\n', num_start_points);
                fprintf(fileID, 'ms_outsub %i\n', 1);
                fclose(fileID);
                
                fvals = Inf(1,max_number_of_subspaces+1); % to keep best function values of an iteration
                time = zeros(1,max_number_of_subspaces); % keep info about time spent per run
                funevals = zeros(1,max_number_of_subspaces); % keep info about function evaluations spent per run
                subspace_count_last = max_number_of_subspaces;
                
                current_x = zeros(D,1);
                fvals(1) = Test_set(current_x,name_of_function);
                
                for subspace_count = 1:max_number_of_subspaces
                    A = randn(D,d);
                    C = [A; -A];
                    b = ones(2*D,1) + [-current_x; current_x];
                    
                    for k = 1:num_start_points
                        data = strcat('knitro_ms_',num2str(k),'.log');
                        if exist(data, 'file') == 2
                            delete(data);
                        end
                    end
                    
                    fun = @(y) Test_set(A*y+current_x,name_of_function);
                    
                    [ymin,fmin,~,output,~,~,~] = knitromatlab(fun,x0,C,b,[],[],[],[],[],[],options,problem_options_file);
                    
                    for k = 1:num_start_points
                        data = strcat('knitro_ms_',num2str(k),'.log');
                        c = textread(data,'%s','delimiter','\n');
                        
                        mask_time = ~cellfun(@isempty,strfind(c,'Total program time (secs)'));
                        line2 = c(mask_time);
                        line2 = char(line2);
                        time(subspace_count) = time(subspace_count) + sscanf(line2, 'Total program time (secs) =  %*f (%f CPU time)');
                    end
                    
                    switch framework
                        case 'AREGO'
                            if (fmin < fvals(subspace_count))
                                fvals(subspace_count+1) = fmin;
                                current_x = A*ymin + current_x;
                            else
                                fvals(subspace_count+1) = fvals(subspace_count);
                            end
                            
                        case 'NREGO'
                            fvals(subspace_count+1) = fmin;
                            
                        case 'LAREGO'
                            if (fmin < fvals(subspace_count) - 10^(-5))
                                fvals(subspace_count+1) = fmin;
                                current_x = A*ymin + current_x;
                            else
                                current_x = 2*rand(D,1)-1;
                                fvals(subspace_count+1) = fvals(subspace_count);
                            end
                            
                        case 'LNREGO'
                            fvals(subspace_count+1) = fmin;
                            current_x = 2*rand(D,1)-1;
                    end
                    
                    funevals(subspace_count) = output.funcCount;
                    
                    if (abs(fvals(subspace_count+1) - min) <= tol)
                        subspace_count_last = subspace_count;
                        break;
                    end
                end
                
                funevals = funevals(1:subspace_count_last);
                time = time(1:subspace_count_last);
                fvals = fvals(1:subspace_count_last+1);
                
                Results.(strcat(name_of_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(i),'_funvals')) = fvals;
                Results.(strcat(name_of_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(i),'_funeval')) = funevals;
                Results.(strcat(name_of_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(i),'_time')) = time;
                
                %case YOUR_SOLVER (add your own solver here)
        end
    end
end
end
