function Results = solvers_no_emb_vs_XREGO(name_of_function,name_of_solver,Results)

% name_of_function - 
% name_of_solver - 
% Results - 

global rotation_matrices

tol = 10^(-3);
idx = strfind(name_of_function,'_');
idx = idx(end);
low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed

[~, min, ~, ~] = Extract_function(low_dim_function_name); %get the effective dimension of the function to set maximum budget

D = str2num(name_of_function(idx+1:end)); %get the ambient dimension of the function

x0 = zeros(D,1); %initial starting point to be used by BARON

%next we specify lower and upper bounds for x since we are optimizing over X = [-1,1]^D
lb = -ones(D,1);
ub =  ones(D,1);

%no embedding to compare with XREGO 
switch name_of_solver
    case 'BARON'
        maxtime = 1000; %maximum budget time per problem is 200*effective_dimension CPU seconds
        
        UpperBound = Inf(1,10*maxtime);
        LowerBound = -Inf(1,10*maxtime);
        time = zeros(1,10*maxtime);
        ub_convergence = 0;
        lb_convergence = 0;
        
        fun = @(x) Test_set(x,name_of_function);
        
        %the name of the file where BARON will store information during the run:
        filename = randi([1 100000],1,1);
        filename = strcat('B',num2str(filename));
        
        %BARON options:
        opts = struct('maxtime', maxtime, 'epsa', tol, 'prtimefreq', 5, 'barscratch', filename);
        
        data = 'baron_data';
        if exist(data, 'file') == 2
                 delete(data);
        end
        
        diary(data)
        %optimizing with BARON solver:
        [~,fmin,~,info] = baron(fun,[],[],[],lb,ub,[],[],[],[],x0,opts);
        diary off;
        
        c = regexp(fileread(data),'\n','split');
        start_line = find(~cellfun('isempty',regexp(c,'Iteration\s*Open\s*nodes')));
        
        if (isempty(start_line) == 1)
            UpperBound = info.Upper_Bound;
            LowerBound = info.Lower_Bound;
            time = info.Total_Time;
        else
            str = regexp(c,'[a-z]');
            Idx1 = cellfun('isempty',str);
            c = c(Idx1);
            
            str1 = regexp(c,'[0-9]');
            Idx2 = ~cellfun('isempty',str1);
            c = c(Idx2);
            
            split_c = regexp(c,'\s*', 'split');
            
            max_count = length(split_c);
            UpperBound = Inf(1,max_count);
            LowerBound = -Inf(1,max_count);
            time = zeros(1,max_count);
            
            for j = 1:max_count
                v = split_c{j};
                Idx = ~cellfun('isempty',v);
                v = v(Idx);
                l = length(v);
                UpperBound(j) = str2double(v(l));
                LowerBound(j) = str2double(v(l-1));
                time(j) = str2double(v(l-2));
            end
        end
        
        if(abs(fmin - min) <= tol)
            ub_convergence = 1;
            if (strcmp(info.Model_Status, 'Optimal within tolerances'))
                lb_convergence = 1;
            end
        end
        
        %saving results
        Results.(strcat(name_of_function,'_UpperBound')) = UpperBound;
        Results.(strcat(name_of_function,'_LowerBound')) = LowerBound;
        Results.(strcat(name_of_function,'_info')) = info;
        Results.(strcat(name_of_function,'_time')) = info.Total_Time;
        Results.(strcat(name_of_function,'_ubconvergence')) = ub_convergence;
        Results.(strcat(name_of_function,'_lbconvergence')) = lb_convergence;

    case 'DIRECT'
        
        maxevals = 60000;  %maximum function evaluation budget per problem is 10000*effective_dimension
        
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
        [fmin,~,hist] = Direct(fun,[lb ub],options);
        cpu_time_finish = cputime - cpu_time_start;
        
        %saving results
        Results.(strcat(name_of_function,'_fmin')) = fmin;
        Results.(strcat(name_of_function,'_funeval')) = hist(size(hist,1),2);
        Results.(strcat(name_of_function,'_time')) = cpu_time_finish;
        
    case 'KNITRO'
        num_start_points = 100; %number of starting points in a multistat procedure
        
        fun_vals = Inf(1,num_start_points);
        fun_eval = zeros(1,num_start_points);
        time = zeros(1,num_start_points);
        
        options = optimset('Display','on');
        
        %create options file for the function, which will store, for example, info about the number of starting points
        problem_options_file = strcat('knitro_options.opt');
        fileID = fopen(problem_options_file,'w');
        fprintf(fileID, 'ms_enable %i\n', 1);
        fprintf(fileID, 'ms_savetol %1.6f\n', 0.000001);
        fprintf(fileID, 'fstopval %6.6f\n', min+tol); %stop when f_solver < min + tol
        fprintf(fileID, 'ms_maxsolves %i\n', num_start_points); %number of starting points is 100
        fprintf(fileID, 'ms_outsub %i\n', 1);
        fclose(fileID);
        
        %For each starting point, KNITRO will create a log file and print out
        %the results of the local solve from that starting point in that log file
        %if the files from previous runs exist, we delete them
        for j = 1:num_start_points
            data = strcat('knitro_ms_',num2str(j),'.log');
            if exist(data, 'file') == 2
                delete(data);
            end
        end
        
        fun = @(x) Test_set(x,name_of_function);
        
        [~,~,~,~,~,~,~] = knitromatlab(fun,x0,[],[],[],[],lb,ub,[],[],options,problem_options_file)
        
        %extracting the necessary data from the log files
        for j = 1:num_start_points
            data = strcat('knitro_ms_',num2str(j),'.log');
            c = textread(data,'%s','delimiter','\n');
            mask_fun_val = ~cellfun(@isempty,strfind(c,'Final objective value'));
            line = c(mask_fun_val);
            line = char(line);
            fun_vals(j) = sscanf(line, 'Final objective value = %f');
            
            mask_fun_eval = ~cellfun(@isempty,strfind(c,'# of function evaluations'));
            line1 = c(mask_fun_eval);
            line1 = char(line1);
            fun_eval(j) = sscanf(line1, '# of function evaluations = %i');
            
            mask_time = ~cellfun(@isempty,strfind(c,'Total program time (secs)'));
            line2 = c(mask_time);
            line2 = char(line2);
            time(j) = sscanf(line2, 'Total program time (secs) =  %*f (%f CPU time)');
        end
        
        Results.(strcat(name_of_function,'_fvals')) = fun_vals;
        Results.(strcat(name_of_function,'_funeval')) = fun_eval;
        Results.(strcat(name_of_function,'_time')) = time;
        
        %case YOUR_SOLVER (add your own solver here)
end
end
