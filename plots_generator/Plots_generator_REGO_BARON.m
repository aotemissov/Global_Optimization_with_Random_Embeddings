% The code generates Figure 6 in the paper (arxiv version) Cartis, Otemissov, 
% "A dimensionality reduction technique 
% for unconstrained global optimization of functions with low effective dimensionality"
% which compares REGO vs no embedding with BARON solver.

%This file requires tight_sublot function. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Results_REGO = load('Results_REGO_BARON.mat'); %this contains the data for REGO
Results_noemb = load('Results_no_embedding_BARON(vsREGO).mat'); %this contains the data for no embedding

tol = 10^(-3);

diff_d_and_de = 0:3;

functions.f0 = 'Beale';
functions.f1 = 'Brent';
functions.f2 = 'Bukin_N6';
functions.f3 = 'Camel';
functions.f4 = 'Goldstein_Price';
functions.f5 = 'Hartmann3';
functions.f6 = 'Hartmann6';
functions.f7 = 'Perm';
functions.f8 = 'Rosenbrock';
functions.f9 = 'Shekel5';
functions.f10 = 'Shekel7';
functions.f11 = 'Shekel10';
functions.f12 = 'Styblinski_Tang';
functions.f13 = 'Trid';
functions.f14 = 'Zettl';

list_of_D = [10 100 1000];
number_of_functions = 15;
N = 100;

table_lb_convergence = zeros(5,3);
table_ub_convergence = zeros(5,3);
table_time = zeros(5,3);

%The following code calculates the average convergence_opt rates, convergence rates, and CPU times for REGO. Averages are over the test set and the 100 problem instances. 

for iterate_D = 1:length(list_of_D)
    D = list_of_D(iterate_D);
    for iterate_d = 1:length(diff_d_and_de)
        sum_lb_conv = 0;
        sum_ub_conv = 0;
        sum_time = 0;
        for i = 1:number_of_functions
            name_of_low_dim_function = functions.(strcat('f',num2str(i-1)));
            [~, global_min, ~, ~] = Extract_function(name_of_low_dim_function);
            for j = 1:N
                object_name_fmin = strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(j),'_fmin');
                object_name_time = strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(j),'_time');
                object_name_info = strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(diff_d_and_de(iterate_d)),'_',num2str(j),'_info');
                
                fmin = Results_REGO.(object_name_fmin);
                time = Results_REGO.(object_name_time);
                info = Results_REGO.(object_name_info);
                
                if (abs(fmin-global_min)<= tol)
                    sum_ub_conv = sum_ub_conv + 1;
                    if (strcmp(info.Model_Status, 'Optimal within tolerances'))
                        sum_lb_conv = sum_lb_conv + 1;
                    end
                end
                
                sum_time = sum_time + time;
            end
        end
        
        table_lb_convergence(iterate_d,iterate_D) = sum_lb_conv/(number_of_functions*N);
        table_ub_convergence(iterate_d,iterate_D) = sum_ub_conv/(number_of_functions*N);
        table_time(iterate_d,iterate_D) = sum_time/(number_of_functions*N);
    end
end

%The following code calculates the average convergence_opt frequency, convergence frequency, and CPU times for no embedding. Averages are over the test set. 

for iterate_D = 1:length(list_of_D)
    D = list_of_D(iterate_D);
    sum_lb_conv = 0;
    sum_ub_conv = 0;
    sum_time = 0;
    for i = 1:number_of_functions
        name_of_low_dim_function = functions.(strcat('f',num2str(i-1)));
        [~, global_min, ~, ~] = Extract_function(name_of_low_dim_function);
        
        object_name_fmin = strcat(name_of_low_dim_function,'_',num2str(D),'_fmin');
        object_name_time = strcat(name_of_low_dim_function,'_',num2str(D),'_time');
        object_name_info = strcat(name_of_low_dim_function,'_',num2str(D),'_info');
        
        fmin = Results_noemb.(object_name_fmin);
        time = Results_noemb.(object_name_time);
        info = Results_noemb.(object_name_info);
        
        if (abs(fmin-global_min)<= tol)
            sum_ub_conv = sum_ub_conv + 1;
            if (strcmp(info.Model_Status, 'Optimal within tolerances'))
                sum_lb_conv = sum_lb_conv + 1;
            end
        end
        
        sum_time = sum_time + time;
    end
    
    table_lb_convergence(5,iterate_D) = sum_lb_conv/(number_of_functions);
    table_ub_convergence(5,iterate_D) = sum_ub_conv/(number_of_functions);
    table_time(5,iterate_D) = sum_time/(number_of_functions);
end


% The following code generates the figure similar to Figure 6 in the paper. Note that the code
% uses tight_subplot function

figure;

D = [1 2 3];

[ha, ~] = tight_subplot(1,3,[.07 0.09],[.12 .05],[.07 .02]);

axes(ha(1)); 
h1 = plot(D,table_lb_convergence(1,:), '--^', 'LineWidth', 1);
hold on;
plot(D,table_lb_convergence(2,:), '--s', 'LineWidth', 1);
plot(D,table_lb_convergence(3,:), '--*', 'LineWidth', 1);
plot(D,table_lb_convergence(4,:), '--d',  'LineWidth', 1);
plot(D,table_lb_convergence(5,:), '-o', 'color', 'k', 'LineWidth', 1);

set(gca, 'XTickLabel', {'10','100','1000'});
axis([0.9 3.1 0 1]);
ax = gca;
ax.FontSize = 14;

set(gca,'TickLabelInterpreter', 'latex');
xticks([1 2 3]);
xlabel('$D$', 'FontSize', 12, 'Interpreter', 'latex');
ylabel('average \% of problems attained convergence$_{opt}$', 'Interpreter', 'latex');
ylabh = get(gca,'ylabel'); 
set(ylabh,'position',get(ylabh,'position') + [0.04 0 0],'fontsize',13);

axes(ha(2));
h2 = plot(D,table_ub_convergence(1,:), '--^', 'LineWidth', 1);
hold on;
plot(D,table_ub_convergence(2,:), '--s', 'LineWidth', 1);
plot(D,table_ub_convergence(3,:), '--*', 'LineWidth', 1);
plot(D,table_ub_convergence(4,:), '--d', 'LineWidth', 1);
plot(D,table_ub_convergence(5,:), '-o', 'color', 'k', 'LineWidth', 1);

axis([0.9 3.1 0 1]);
ax = gca;
ax.FontSize = 14;

set(gca,'TickLabelInterpreter', 'latex');
xticks([1 2 3]);
ylabel('average \% of problems attained convergence', 'Interpreter', 'latex');
set(gca, 'XTickLabel', {'10','100','1000'});
xlabel('$D$', 'FontSize', 12, 'Interpreter', 'latex');
ylabh1 = get(gca,'ylabel'); 
set(ylabh1,'position',get(ylabh1,'position') + [0.05 0 0],'fontsize',13);

lngd = legend('$d = d_e$', '$d = d_e + 1$', '$d = d_e + 2$', '$d = d_e + 3$', 'no embedding');
set(lngd,  'fontsize', 14, 'interpreter','latex','Location', 'south', 'Units', 'pixels');

axes(ha(3));
h3 = plot(D,table_time(1,:), '--^', 'LineWidth', 1);
hold on;
plot(D,table_time(2,:), '--s', 'LineWidth', 1);
plot(D,table_time(3,:), '--*', 'LineWidth', 1);
plot(D,table_time(4,:), '--d', 'LineWidth', 1);
plot(D,table_time(5,:), '-o', 'color', 'black', 'LineWidth', 1);

axis([0.9 3.1 1 10^3]);
ax = gca;
ax.FontSize = 14;

set(gca,'TickLabelInterpreter', 'latex');
xticks([1 2 3]);
set(gca, 'YScale', 'log');

set(gca, 'XTickLabel', {'10','100','1000'});
xlabel('$D$', 'FontSize', 12, 'Interpreter', 'latex');

ylabel('CPU time in seconds', 'Interpreter', 'latex');

ylabh2 = get(gca,'ylabel'); 
set(ylabh2,'position',get(ylabh2,'position') + [0.1 0 0],'fontsize',14);

set(gcf, 'Position', [400, 150, 600, 300]);