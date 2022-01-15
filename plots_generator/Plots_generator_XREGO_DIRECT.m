% This code generates Figure 2 in the paper (arxiv version) Cartis, Massart, Otemissov
% "Constrained global optimization of functions with low effective 
% dimensionality using multiple random embeddings" which compares XREGO vs
% no embedding framework using DIRECT solver.

%This file requires tight_sublot function. 

DI_NOemb = load('Results_no_embedding_DIRECT(vsXREGO).mat');
DI_AREGO = load('Results_AREGO_DIRECT.mat');
DI_NREGO = load('Results_NREGO_DIRECT.mat');

tol = 10^(-3);

functions = struct;

functions.f1 = 'Beale';
functions.f2 = 'Branin';
functions.f3 = 'Brent';
functions.f4 = 'Bukin_N6';
functions.f5 = 'Camel';
functions.f6 = 'Easom';
functions.f7 = 'Goldstein_Price';
functions.f8 = 'Hartmann3';
functions.f9 = 'Hartmann6';
functions.f10 = 'Levy';
functions.f11 = 'Perm';
functions.f12 = 'Rosenbrock';
functions.f13 = 'Shekel5';
functions.f14 = 'Shekel7';
functions.f15 = 'Shekel10';
functions.f16 = 'Shubert';
functions.f17 = 'Styblinski_Tang';
functions.f18 = 'Trid';
functions.f19 = 'Zettl';

n_s = 11;
n_p = 19;
t = zeros(n_p,n_s);
s = zeros(n_p,n_s);
vec_D = [10 100 1000];

average_cost = zeros(3,3);

number_of_subspaces = zeros(n_p,n_s-1);
average_subspaces = zeros(2,3);

for q = 1:length(vec_D)
    D = vec_D(q);
    %defining t_{p,s}
    for p = 1:n_p
        name_of_low_dim_function = functions.(strcat('f',num2str(p)));
        [dim, global_min, ~, ~] = Extract_function(name_of_low_dim_function);
        
        %No embedding
        funeval = DI_NOemb.(strcat(name_of_low_dim_function,'_',num2str(D),'_funeval'));
        fvals = DI_NOemb.(strcat(name_of_low_dim_function,'_',num2str(D),'_fmin'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i)-global_min) <= tol)
                s(p,1) = 1;
                break;
            end
        end
        t(p,1) = sum(funeval(1:count));
        
        d = 0;
        %DIRECT AREGO ada
        N = 1;
        funeval = DI_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        fvals = DI_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,2) = 1;
                break;
            end
        end
        t(p,2) = sum(funeval(1:count));
        
        number_of_subspaces(p,1) = count;
        
        %BARON AREGO ada
        N = 2;
        funeval = DI_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        fvals = DI_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,3) = 1;
                break;
            end
        end
        t(p,3) = sum(funeval(1:count));
        
        number_of_subspaces(p,2) = count;
        
        %BARON AREGO ada
        N = 3;
        funeval = DI_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        fvals = DI_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,4) = 1;
                break;
            end
        end
        t(p,4) = sum(funeval(1:count));
        number_of_subspaces(p,3) = count;
        
        %BARON AREGO ada
        N = 4;
        funeval = DI_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        fvals = DI_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,5) = 1;
                break;
            end
        end
        t(p,5) = sum(funeval(1:count));
        number_of_subspaces(p,4) = count;
        
        %BARON AREGO ada
        N = 5;
        funeval = DI_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        fvals = DI_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,6) = 1;
                break;
            end
        end
        t(p,6) = sum(funeval(1:count));
        number_of_subspaces(p,5) = count;
        
        %BARON AREGO nonada
        N = 1;
        funeval = DI_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        fvals = DI_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,7) = 1;
                break;
            end
        end
        t(p,7) = sum(funeval(1:count));
        number_of_subspaces(p,6) = count;
        
        %BARON AREGO nonada
        N = 2;
        funeval = DI_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        fvals = DI_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,8) = 1;
                break;
            end
        end
        t(p,8) = sum(funeval(1:count));
        number_of_subspaces(p,7) = count;
        
        %BARON AREGO nonada
        N = 3;
        funeval = DI_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        fvals = DI_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,9) = 1;
                break;
            end
        end
        t(p,9) = sum(funeval(1:count));
        number_of_subspaces(p,8) = count;
        
        %BARON AREGO nonada
        N = 4;
        funeval = DI_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        fvals = DI_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,10) = 1;
                break;
            end
        end
        t(p,10) = sum(funeval(1:count));
        number_of_subspaces(p,9) = count;
        
        %BARON AREGO nonada
        N = 5;
        funeval = DI_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        fvals = DI_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,11) = 1;
                break;
            end
        end
        t(p,11) = sum(funeval(1:count));
        number_of_subspaces(p,10) = count;
        
    end
    
    r = zeros(n_p,n_s);

    for p = 1:n_p
        t_min = min(t(p,:));
        for i = 1:n_s
            if (s(p,i) == 1)
                r(p,i) = t(p,i)/t_min;
            else
                r(p,i) = 0;
            end
        end
    end
    
    if (D == 10)
        average_cost(:,1) = [median(t(:,1)) median(t(:,2:6),'all') median(t(:,7:11),'all')]';
        average_subspaces(:,1) = [mean(number_of_subspaces(:,1:5),'all') mean(number_of_subspaces(:,6:10),'all')]';
        r1 = r;
        rM1 = max(r, [], 'all');
    elseif (D == 100)
        average_cost(:,2) = [median(t(:,1)) median(t(:,2:6),'all') median(t(:,7:11),'all')]';
        average_subspaces(:,2) = [mean(number_of_subspaces(:,1:5),'all') mean(number_of_subspaces(:,6:10),'all')]';
        r2 = r;
        rM2 = max(r, [], 'all');
    elseif (D == 1000)
        average_cost(:,3) = [median(t(:,1)) median(t(:,2:6),'all') median(t(:,7:11),'all')]';
        average_subspaces(:,3) = [mean(number_of_subspaces(:,1:5),'all') mean(number_of_subspaces(:,6:10),'all')]';
        r3 = r;
        rM3 = max(r, [], 'all');
    end
end

rM = max(max(rM1,rM2),rM3);
r1(r1==0) = 2*rM;
r2(r2==0) = 2*rM;
r3(r3==0) = 2*rM;

N_divide = 100000;

fl = log10(1.5*rM);
tau = [];
for i = 1:fl+1
    tau = [tau linspace(10^(i-1),min(10^i,1.5*rM),N_divide)];
end

rho1 = zeros(n_s,length(tau));
rho2 = zeros(n_s,length(tau));
rho3 = zeros(n_s,length(tau));

for i = 1:n_s
    column1 = r1(:,i);
    column2 = r2(:,i);
    column3 = r3(:,i);
    for j = 1:length(tau)
        rho1(i,j) = sum(column1<=tau(j))/n_p;
        rho2(i,j) = sum(column2<=tau(j))/n_p;
        rho3(i,j) = sum(column3<=tau(j))/n_p;
    end
end

rho1_reduced = cell(n_s,1);
rho2_reduced = cell(n_s,1);
rho3_reduced = cell(n_s,1);

for i = 1:n_s
    new_array = [];
    for k = 0 : n_p
        ind_first = find(rho1(i,:) == k/n_p,1,'first');
        ind_end = find(rho1(i,:) == k/n_p,1,'last');
        if (~isempty(ind_first))
            new_array = [new_array [tau(ind_first) tau(ind_end); rho1(i,ind_first) rho1(i,ind_end)]];
        end
    end
    rho1_reduced{i} = new_array;
end

for i = 1:n_s
    new_array = [];
    for k = 0 : n_p
        ind_first = find(rho2(i,:) == k/n_p,1,'first');
        ind_end = find(rho2(i,:) == k/n_p,1,'last');
        if (~isempty(ind_first))
            new_array = [new_array [tau(ind_first) tau(ind_end); rho2(i,ind_first) rho2(i,ind_end)]];
        end
    end
    rho2_reduced{i} = new_array;
end

for i = 1:n_s
    new_array = [];
    for k = 0 : n_p
        ind_first = find(rho3(i,:) == k/n_p,1,'first');
        ind_end = find(rho3(i,:) == k/n_p,1,'last');
        if (~isempty(ind_first))
            new_array = [new_array [tau(ind_first) tau(ind_end); rho3(i,ind_first) rho3(i,ind_end)]];
        end
    end
    rho3_reduced{i} = new_array;
end

c10 = cell(10,1);
c100 = cell(10,1);
c1000 = cell(10,1);
format bank;

[ha, pos] = tight_subplot(3,1,[.07 0.03],[.08 .05],[.08 .02]);
axes(ha(1));

for i = 1:5
    c10{i} = semilogx(rho1_reduced{i+1}(1,:),rho1_reduced{i+1}(2,:),'-o' ,'color', 'b','linewidth',1);
    hold on;
end

for i = 1:5
    c10{i+5} = semilogx(rho1_reduced{i+6}(1,:),rho1_reduced{i+6}(2,:),'-x', 'color', 'r','linewidth',1);
end
h1 = semilogx(rho1_reduced{1}(1,:),rho1_reduced{1}(2,:),'color','k','linewidth',1.5);

ylabel('$\pi(\alpha)$','interpreter', 'latex');
xlim([1 1.5*rM]);
ylim([0 1]);
    
axes(ha(2));

for i = 1:5
    c100{i} = semilogx(rho2_reduced{i+1}(1,:),rho2_reduced{i+1}(2,:),'-o', 'color', 'b','linewidth',1);
    hold on;
end
for i = 1:5
    c100{i+5} = semilogx(rho2_reduced{i+6}(1,:),rho2_reduced{i+6}(2,:),'-x', 'color', 'r','linewidth',1);
end
h2 = semilogx(rho2_reduced{1}(1,:),rho2_reduced{1}(2,:),'color','k','linewidth',1.5);


ylabel('$\pi(\alpha)$','interpreter', 'latex');
xlim([1 1.5*rM]);
ylim([0 1]);

axes(ha(3));

for i = 1:5
    c1000{i} = semilogx(rho3_reduced{i+1}(1,:),rho3_reduced{i+1}(2,:),'-o', 'color', 'b','linewidth',1);
    hold on;
end
for i = 1:5
    c1000{i+5} = semilogx(rho3_reduced{i+6}(1,:),rho3_reduced{i+6}(2,:),'-x', 'color', 'r','linewidth',1);
end
h3 = semilogx(rho3_reduced{1}(1,:),rho3_reduced{1}(2,:),'color','k','linewidth',1.5);

ylabel('$\pi(\alpha)$','interpreter', 'latex');
xlim([1 1.5*rM]);
ylim([0 1]);

axes(ha(3));
xlabel('$\alpha$', 'FontSize', 12, 'Interpreter', 'latex');
xlabh = get(gca,'xlabel'); 
set(xlabh,'position',get(xlabh,'position') + [0 0.06 0]);
set(gcf, 'Position', [400, 150, 460, 500]);

axes(ha(1));
title('$D = 10$', 'Interpreter', 'latex');
titleh = get(gca,'title'); 
set(titleh,'position',get(titleh,'position') + [0 -0.01 0]);
axes(ha(2));
title('$D = 100$', 'Interpreter', 'latex');
titleh = get(gca,'title'); 
set(titleh,'position',get(titleh,'position') + [0 -0.01 0]);
axes(ha(3));
title('$D = 1000$', 'Interpreter', 'latex');
titleh = get(gca,'title'); 
set(titleh,'position',get(titleh,'position') + [0 -0.01 0]);

axes(ha(3));
lngd1 = legend([h3 c10{1} c10{6}],'no-embedding','A-REGO','N-REGO');
set(lngd1,  'fontsize', 12, 'interpreter', 'latex', 'Location', 'NorthWest'); 
