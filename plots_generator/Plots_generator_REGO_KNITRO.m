% The code generates Figure 7 in the paper (arxiv version) Cartis, Otemissov, 
% "A dimensionality reduction technique 
% for unconstrained global optimization of functions with low effective dimensionality"
% which compares REGO vs no embedding with KNITRO solver.

%This file requires tight_sublot function. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Results_REGO = load('Results_REGO_KNITRO.mat'); %this contains the data for REGO
Results_noemb = load('Results_no_embedding_KNITRO(vsREGO).mat'); %this contains the data for no embedding

tol = 10^(-3);

diff_d_and_de = 0:3;

functions.f0 = 'Beale';
functions.f1 = 'Branin';
functions.f2 = 'Brent';
functions.f3 = 'Camel';
functions.f4 = 'Easom';
functions.f5 = 'Goldstein_Price';
functions.f6 = 'Hartmann3';
functions.f7 = 'Hartmann6';
functions.f8 = 'Levy';
functions.f9 = 'Perm';
functions.f10 = 'Rosenbrock';
functions.f11 = 'Shekel5';
functions.f12 = 'Shekel7';
functions.f13 = 'Shekel10';
functions.f14 = 'Shubert';
functions.f15 = 'Styblinski_Tang';
functions.f16 = 'Trid';
functions.f17 = 'Zettl';

list_of_D = [10 100 1000];
number_of_functions = 18;
N = 100;

table_convergence = zeros(5,3);
table_funeval = zeros(5,3);
table_time = zeros(5,3);

%The following code calculates the average convergence frequency, function evaluations, and CPU times for REGO. Averages are over the test set and the 100 problem instances. 

for iterate_D = 1:length(list_of_D)
    D = list_of_D(iterate_D);
    for iterate_d = 1:length(diff_d_and_de)
        sum_conv = 0;
        sum_funeval = 0;
        sum_time = 0;
        for i = 1:number_of_functions
            name_of_low_dim_function = functions.(strcat('f',num2str(i-1)));
            [~, global_min, ~, ~] = Extract_function(name_of_low_dim_function);
            for j = 1:N
                object_name_fmin = strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(j),'_fmin');
                object_name_time = strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(j),'_time');
                object_name_funeval = strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(j),'_funeval');
                
                fmin = Results_REGO.(object_name_fmin);
                time = Results_REGO.(object_name_time);
                funeval = Results_REGO.(object_name_funeval);
                
                if (abs(fmin-global_min)<= tol)
                    sum_conv = sum_conv + 1;
                end
                
                sum_time = sum_time + time;
                sum_funeval = sum_funeval + funeval;
            end
        end
        
        table_convergence(iterate_d,iterate_D) = sum_conv/(number_of_functions*N);
        table_funeval(iterate_d,iterate_D) = sum_funeval/(number_of_functions*N);
        table_time(iterate_d,iterate_D) = sum_time/(number_of_functions*N);
    end
end

%The following code calculates the average convergence frequency, function evaluations, and CPU times for no embedding. Averages are over the test set. 

for iterate_D = 1:length(list_of_D)
    D = list_of_D(iterate_D);
    sum_conv = 0;
    sum_funeval = 0;
    sum_time = 0;
    for i = 1:number_of_functions
        name_of_low_dim_function = functions.(strcat('f',num2str(i-1)));
        [~, global_min, ~, ~] = Extract_function(name_of_low_dim_function);
        
        object_name_fvals = strcat(name_of_low_dim_function,'_',num2str(D),'_fmin');
        object_name_time = strcat(name_of_low_dim_function,'_',num2str(D),'_time');
        object_name_funeval = strcat(name_of_low_dim_function,'_',num2str(D),'_funeval');
        
        fvals = Results_noemb.(object_name_fvals);
        time = Results_noemb.(object_name_time);
        funeval = Results_noemb.(object_name_funeval);
        
        for j = 1:length(fvals)
            sum_time = sum_time + time(j);
            sum_funeval = sum_funeval + funeval(j);
            if (abs(fvals(j)-global_min)<=tol)
                sum_conv = sum_conv + 1;
                break;
            end
        end
    end
    
    table_convergence(5,iterate_D) = sum_conv/(number_of_functions);
    table_funeval(5,iterate_D) = sum_funeval/(number_of_functions);
    table_time(5,iterate_D) = sum_time/(number_of_functions);
end

% The following code generates the figure similar to Figure 7 in the paper. Note that the code
% uses tight_subplot function
          
figure;
D = [1 2 3];

[ha, ~] = tight_subplot(1,3,[.07 0.09],[.12 .05],[.07 .02]);

axes(ha(1)); 
h1 = plot(D,table_convergence(1,:), '--^', 'LineWidth', 1);
hold on;
plot(D,table_convergence(2,:), '--s', 'LineWidth', 1);
plot(D,table_convergence(3,:), '--*', 'LineWidth', 1);
plot(D,table_convergence(4,:), '--d', 'LineWidth', 1);
plot(D,table_convergence(5,:), '-o', 'color', 'black', 'LineWidth', 1);

set(gca, 'XTickLabel', {'10','100','1000'},'fontsize',12);
axis([0.9 3.1 0 1]);
ax = gca;
ax.FontSize = 14;

set(gca,'TickLabelInterpreter', 'latex');
xticks([1 2 3]);
xlabel('$D$', 'FontSize', 12, 'Interpreter', 'latex');
ylabel('average \% of problems attained convergence', 'Interpreter', 'latex');
ylabh = get(gca,'ylabel'); 
set(ylabh,'position',get(ylabh,'position') + [0.05 0 0],'fontsize',13);


axes(ha(2));
h2 = plot(D,table_funeval(1,:), '--^', 'LineWidth', 1);
hold on;
plot(D,table_funeval(2,:), '--s', 'LineWidth', 1);
plot(D,table_funeval(3,:), '--*', 'LineWidth', 1);
plot(D,table_funeval(4,:), '--d', 'LineWidth', 1);
plot(D,table_funeval(5,:), '-o', 'color', 'black', 'LineWidth', 1);

axis([0.9 3.1 1 10^7]);

set(gca,'TickLabelInterpreter', 'latex');
xticks([1 2 3]);
ax = gca;
ax.FontSize = 14;

ylabel('function evaluations', 'Interpreter', 'latex');
set(gca, 'YScale', 'log');

set(gca, 'XTickLabel', {'10','100','1000'});
xlabel('$D$', 'FontSize', 12, 'Interpreter', 'latex');
ylabh1 = get(gca,'ylabel'); 
set(ylabh1,'position',get(ylabh1,'position') + [0.08 0 0],'fontsize',14);

lngd = legend('$d = d_e$', '$d = d_e + 1$', '$d = d_e + 2$', '$d = d_e + 3$', 'no embedding');

set(lngd,  'fontsize', 14, 'interpreter','latex','Location', 'south', 'Units', 'pixels');

axes(ha(3));
h3 = plot(D,table_time(1,:), '--^', 'LineWidth', 1);
hold on;
plot(D,table_time(2,:), '--s', 'LineWidth', 1);
plot(D,table_time(3,:), '--*', 'LineWidth', 1);
plot(D,table_time(4,:), '--d', 'LineWidth', 1);
plot(D,table_time(5,:), '-o', 'color', 'black', 'LineWidth', 1);

axis([0.9 3.1 1 10^4]);

set(gca,'TickLabelInterpreter', 'latex');
xticks([1 2 3]);
ylabel('CPU time in seconds', 'Interpreter', 'latex');
set(gca, 'YScale', 'log');

set(gca, 'XTickLabel', {'10','100','1000'},'fontsize',12);
ax = gca;
ax.FontSize = 14;
xlabel('$D$', 'FontSize', 12, 'Interpreter', 'latex');
ylabh2 = get(gca,'ylabel'); 
set(ylabh2,'position',get(ylabh2,'position') + [0.09 0 0],'fontsize',14);

set(gcf, 'Position', [400, 150, 600, 300]);
