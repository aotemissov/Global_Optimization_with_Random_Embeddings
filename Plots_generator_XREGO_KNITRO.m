% This code generates Figure 4 in the paper (arxiv version) Cartis, Massart, Otemissov
% "Constrained global optimization of functions with low effective 
% dimensionality using multiple random embeddings" which compares XREGO vs
% no embedding framework using KNITRO solver.

KN_NOemb = load('Results_no_embedding_KNITRO(vsXREGO).mat');
KN_AREGO = load('Results_AREGO_KNITRO.mat');
KN_NREGO = load('Results_NREGO_KNITRO.mat');
KN_LAREGO = load('Results_LAREGO_KNITRO.mat');
KN_LNREGO = load('Results_LNREGO_KNITRO.mat');

tol = 10^(-3);

functions = struct;

functions.f1 = 'Beale';
functions.f2 = 'Branin';
functions.f3 = 'Brent';
functions.f4 = 'Camel';
functions.f5 = 'Easom';
functions.f6 = 'Goldstein_Price';
functions.f7 = 'Hartmann3';
functions.f8 = 'Hartmann6';
functions.f9 = 'Levy';
functions.f10 = 'Perm';
functions.f11 = 'Rosenbrock';
functions.f12 = 'Shekel5';
functions.f13 = 'Shekel7';
functions.f14 = 'Shekel10';
functions.f15 = 'Shubert';
functions.f16 = 'Styblinski_Tang';
functions.f17 = 'Trid';
functions.f18 = 'Zettl';

n_s = 21;
n_p = 18;
%function eval. to solve a problem with a solver
t = zeros(n_p,n_s);
%solved or not solved
s = zeros(n_p,n_s);
vec_D = [10 100 1000];

average_cost = zeros(5,3);

number_of_subspaces = zeros(n_p,n_s-1);
average_subspaces = zeros(4,3);

for q = 1:length(vec_D)
    D = vec_D(q);
    %defining t_{p,s}
    for p = 1:n_p
        name_of_low_dim_function = functions.(strcat('f',num2str(p)));
        [dim, global_min, ~, ~] = Extract_function(name_of_low_dim_function);
        
        %No embedding
        fvals = KN_NOemb.(strcat(name_of_low_dim_function,'_',num2str(D),'_fvals'));
        funeval = KN_NOemb.(strcat(name_of_low_dim_function,'_',num2str(D),'_funeval'));
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
        %KNITRO AREGO ada 1
        N = 1;
        fvals = KN_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
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
        
        %KNITRO AREGO ada 2
        N = 2;
        fvals = KN_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
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
        
        %KNITRO AREGO ada 3
        N = 3;
        fvals = KN_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
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
        
        %KNITRO AREGO ada 4
        N = 4;
        fvals = KN_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
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
        
        %KNITRO AREGO ada 5
        N = 5;
        fvals = KN_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_AREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
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
        
        %KNITRO AREGO nonada 1
        N = 1;
        fvals = KN_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
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
        
        %KNITRO AREGO nonada 2
        N = 2;
        fvals = KN_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
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
        
        %KNITRO AREGO nonada 3
        N = 3;
        fvals = KN_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
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
        
        %KNITRO AREGO nonada 4
        N = 4;
        fvals = KN_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
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
        
        %KNITRO AREGO nonada 5
        N = 5;
        fvals = KN_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_NREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
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
        
        % LOCAL KNITRO AREGO ada 1
        N = 1;
        fvals = KN_LAREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_LAREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,12) = 1;
                break;
            end
        end
        t(p,12) = sum(funeval(1:count));
        number_of_subspaces(p,11) = count;
        
        % LOCAL KNITRO AREGO ada 2
        N = 2;
        fvals = KN_LAREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_LAREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,13) = 1;
                break;
            end
        end
        t(p,13) = sum(funeval(1:count));
        number_of_subspaces(p,12) = count;
        
        % LOCAL KNITRO AREGO ada 3
        N = 3;
        fvals = KN_LAREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_LAREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,14) = 1;
                break;
            end
        end
        t(p,14) = sum(funeval(1:count));
        number_of_subspaces(p,13) = count;
        
        % LOCAL KNITRO AREGO ada 4
        N = 4;
        fvals = KN_LAREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_LAREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,15) = 1;
                break;
            end
        end
        t(p,15) = sum(funeval(1:count));
        number_of_subspaces(p,14) = count;
        
        % LOCAL KNITRO AREGO ada 5
        N = 5;
        fvals = KN_LAREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_LAREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,16) = 1;
                break;
            end
        end
        t(p,16) = sum(funeval(1:count));
        number_of_subspaces(p,15) = count;
        
        % LOCAL KNITRO AREGO nonada(uniform sampling) 1
        N = 1;
        fvals = KN_LNREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_LNREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,17) = 1;
                break;
            end
        end
        t(p,17) = sum(funeval(1:count));
        number_of_subspaces(p,16) = count;
        
        % LOCAL KNITRO AREGO nonada(uniform sampling) 2
        N = 2;
        fvals = KN_LNREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_LNREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,18) = 1;
                break;
            end
        end
        t(p,18) = sum(funeval(1:count));
        number_of_subspaces(p,17) = count;
        
        % LOCAL KNITRO AREGO nonada(uniform sampling) 3
        N = 3;
        fvals = KN_LNREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_LNREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,19) = 1;
                break;
            end
        end
        t(p,19) = sum(funeval(1:count));
        number_of_subspaces(p,18) = count;
        
        % LOCAL KNITRO AREGO nonada(uniform sampling) 4
        N = 4;
        fvals = KN_LNREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_LNREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,20) = 1;
                break;
            end
        end
        t(p,20) = sum(funeval(1:count));
        number_of_subspaces(p,19) = count;
        
        % LOCAL KNITRO AREGO nonada(uniform sampling) 5
        N = 5;
        fvals = KN_LNREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funvals'));
        funeval = KN_LNREGO.(strcat(name_of_low_dim_function,'_',num2str(D),'_',num2str(d),'_',num2str(N),'_funeval'));
        l = length(funeval);
        count = 0;
        for i = 1:l
            count = count + 1;
            if (abs(fvals(i+1)-global_min) <= tol)
                s(p,21) = 1;
                break;
            end
        end
        t(p,21) = sum(funeval(1:count));
        number_of_subspaces(p,20) = count;
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
        average_cost(:,1) = [median(t(:,1)) median(t(:,2:6),'all') median(t(:,7:11),'all') median(t(:,12:16),'all') median(t(:,17:21),'all')]';
        average_subspaces(:,1) = [mean(number_of_subspaces(:,1:5),'all') mean(number_of_subspaces(:,6:10),'all') mean(number_of_subspaces(:,11:15),'all') mean(number_of_subspaces(:,16:20),'all')]';

        r1 = r;
        rM1 = max(r, [], 'all');
    elseif (D == 100)
        average_cost(:,2) = [median(t(:,1)) median(t(:,2:6),'all') median(t(:,7:11),'all') median(t(:,12:16),'all') median(t(:,17:21),'all')]';
        average_subspaces(:,2) = [mean(number_of_subspaces(:,1:5),'all') mean(number_of_subspaces(:,6:10),'all') mean(number_of_subspaces(:,11:15),'all') mean(number_of_subspaces(:,16:20),'all')]';
        
        r2 = r;
        rM2 = max(r, [], 'all');
    elseif (D == 1000)
        average_cost(:,3) = [median(t(:,1)) median(t(:,2:6),'all') median(t(:,7:11),'all') median(t(:,12:16),'all') median(t(:,17:21),'all')]';
        average_subspaces(:,3) = [mean(number_of_subspaces(:,1:5),'all') mean(number_of_subspaces(:,6:10),'all') mean(number_of_subspaces(:,11:15),'all') mean(number_of_subspaces(:,16:20),'all')]';

        r3 = r;
        rM3 = max(r, [], 'all');
    end
end

rM = max(max(rM1,rM2),rM3);
r1(r1==0) = 2*rM;
r2(r2==0) = 2*rM;
r3(r3==0) = 2*rM;

N_divide = 1000;

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

c10 = cell(n_s-1,1);
c100 = cell(n_s-1,1);
c1000 = cell(n_s-1,1);

[ha, pos] = tight_subplot(3,1,[.07 0.03],[.08 .05],[.08 .02]);
axes(ha(1));

for i = 1:5
    c10{i} = semilogx(rho1_reduced{i+1}(1,:),rho1_reduced{i+1}(2,:),'-o' ,'color', 'b','linewidth',1);
    hold on;
end

for i = 1:5
    c10{i+5} = semilogx(rho1_reduced{i+6}(1,:),rho1_reduced{i+6}(2,:),'-x', 'color', 'r','linewidth',1);
end

for i = 1:5
    c10{i+10} = semilogx(rho1_reduced{i+10}(1,:),rho1_reduced{i+10}(2,:),'-d', 'color', 'g','linewidth',1);
end

for i = 1:5
    c10{i+15} = semilogx(rho1_reduced{i+16}(1,:),rho1_reduced{i+16}(2,:),'-*', 'color', [1 0.5 0],'linewidth',1);
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
for i = 1:5
    c100{i+10} = semilogx(rho2_reduced{i+11}(1,:),rho2_reduced{i+11}(2,:),'-d', 'color', 'g','linewidth',1);
end
for i = 1:5
    c100{i+15} = semilogx(rho2_reduced{i+16}(1,:),rho2_reduced{i+16}(2,:),'-*', 'color', [1 0.5 0],'linewidth',1);
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
for i = 1:5
    c1000{i+10} = semilogx(rho3_reduced{i+11}(1,:),rho3_reduced{i+11}(2,:),'-d', 'color', 'g','linewidth',1);
end
for i = 1:5
    c1000{i+15} = semilogx(rho3_reduced{i+16}(1,:),rho3_reduced{i+16}(2,:),'-*', 'color', [1 0.5 0],'linewidth',1);
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

axes(ha(1));
lngd1 = legend([h1 c10{1} c10{6} c10{11} c10{16}],'no-embedding','A-REGO', 'N-REGO', 'LA-REGO', 'LN-REGO');
set(lngd1,  'fontsize', 12, 'interpreter', 'latex', 'Location', 'SouthEast'); 

