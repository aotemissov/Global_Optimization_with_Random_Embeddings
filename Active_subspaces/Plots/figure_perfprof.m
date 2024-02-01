% ---------------------------------------------------------- %
% function figure_perfprof(Ds, seeds, problems)
%
% input:  Ds       = a vector of different dimension of the domain of the function
%         seeds    = a vector of different options of seed
%         problems = a set of test problems selected from the test set without 
%                    aEasom with default effective dimension
% output: .fig and .png plots
% ---------------------------------------------------------- %
function figure_perfprof(Ds, seeds, problems)

[filepart,~,~] = fileparts(pwd);
loadpath = fullfile(filepart,'Results');
addpath(genpath(loadpath));
loadpath = fullfile(filepart,'Main_script');
addpath(genpath(loadpath));

f_opt = zeros(1,length(problems));
d_e = zeros(1,length(problems));

for i_p = 1:length(problems)
    [d_e_temp, f_opt_temp, ~, ~] = Extract_function_inf1(problems{i_p});
    f_opt(1,i_p) = f_opt_temp;
    d_e(1,i_p) = d_e_temp;
end

% ASM-1, REGO-1, A-ASM, A-REGO algorithms
nfuneval_a_total = zeros(length(problems),length(Ds),length(seeds));
nfuneval_a = 10^18*ones(length(problems),length(Ds),length(seeds));
nfuneval_a_A = zeros(length(problems),length(Ds),length(seeds));
t_a_total = zeros(length(problems),length(Ds),length(seeds));
t_a_emb = 10^18*ones(length(problems),length(Ds),length(seeds));
t_a_A = zeros(length(problems),length(Ds),length(seeds));
d_est_a = zeros(length(problems),length(Ds),length(seeds));
prob_succ_a = zeros(length(problems),length(Ds));
nfuneval_r = 10^18*ones(length(problems),length(Ds),length(seeds));
t_r_total = zeros(length(problems),length(Ds),length(seeds));
t_r_emb = 10^18*ones(length(problems),length(Ds),length(seeds));
t_r_A = zeros(length(problems),length(Ds),length(seeds));
d_est_r = zeros(length(problems),length(Ds),length(seeds));
prob_succ_r = zeros(length(problems),length(Ds));
nfuneval_a_ada_total = zeros(length(problems),length(Ds),length(seeds));
nfuneval_a_ada = 10^18*ones(length(problems),length(Ds),length(seeds));
nfuneval_a_ada_A = zeros(length(problems),length(Ds),length(seeds));
t_a_ada_total = zeros(length(problems),length(Ds),length(seeds));
t_a_ada_emb = 10^18*ones(length(problems),length(Ds),length(seeds));
t_a_ada_A = zeros(length(problems),length(Ds),length(seeds));
d_est_a_ada = zeros(length(problems),length(Ds),length(seeds));
prob_succ_a_ada = zeros(length(problems),length(Ds));
nfuneval_r_ada = 10^18*ones(length(problems),length(Ds),length(seeds));
t_r_ada_total = zeros(length(problems),length(Ds),length(seeds));
t_r_ada_emb = 10^18*ones(length(problems),length(Ds),length(seeds));
t_r_ada_A = zeros(length(problems),length(Ds),length(seeds));
d_est_r_ada = zeros(length(problems),length(Ds),length(seeds));
prob_succ_r_ada = zeros(length(problems),length(Ds));
for i_d = 1:length(Ds)
    D = Ds(i_d);
    for i_s = 1:length(seeds)
        seed = seeds(i_s);
        filename = strcat('Results_global_seed_',num2str(seed),'_D_',num2str(D),'.mat');
        data = load(filename);
        obj_all = data.(strcat('obj'));
        nfuneval_all = data.(strcat('nfuneval'));
        d_est_all = data.(strcat('d_est'));
        t_all = data.(strcat('t_emb'));
        t_A_all = data.(strcat('t_A'));
        % ASM-1
        obj_a = obj_all(1,:);
        index_succ_a = find((obj_a <= f_opt + 1e-3));
        prob_succ_a_oneseed = zeros(length(problems),1);
        prob_succ_a_oneseed(index_succ_a) = 1;
        prob_succ_a(:,i_d) = prob_succ_a(:,i_d) + prob_succ_a_oneseed/length(seeds);
        d_est_a(:,i_d,i_s) = d_est_all(1,:);
        nfuneval_a(index_succ_a,i_d,i_s) = nfuneval_all(1,index_succ_a);
        nfuneval_a_A(index_succ_a,i_d,i_s) = d_e(index_succ_a)*(D+1);
        nfuneval_a_total(:,i_d,i_s) = nfuneval_a(:,i_d,i_s) + nfuneval_a_A(:,i_d,i_s);
        t_a_emb(index_succ_a,i_d,i_s) = t_all(1,index_succ_a);
        t_a_A(index_succ_a,i_d,i_s) = t_A_all(1,index_succ_a);
        t_a_total(:,i_d,i_s) = t_a_emb(:,i_d,i_s) + t_a_A(:,i_d,i_s);
        % REGO-1
        obj_r = obj_all(2,:);
        index_succ_r = find((obj_r <= f_opt + 1e-3));
        prob_succ_r_oneseed = zeros(length(problems),1);
        prob_succ_r_oneseed(index_succ_r) = 1;
        prob_succ_r(:,i_d) = prob_succ_r(:,i_d) + prob_succ_r_oneseed/length(seeds);
        d_est_r(:,i_d,i_s) = d_est_all(2,:);
        nfuneval_r(index_succ_r,i_d,i_s) = nfuneval_all(2,index_succ_r);
        t_r_emb(index_succ_r,i_d,i_s) = t_all(2,index_succ_r);
        t_r_A(index_succ_r,i_d,i_s) = t_A_all(2,index_succ_r);
        t_r_total(:,i_d,i_s) = t_r_emb(:,i_d,i_s) + t_r_A(:,i_d,i_s);
        % A-ASM
        obj_a_ada = obj_all(3,:);
        index_succ_a_ada = find((obj_a_ada <= f_opt + 1e-3));
        prob_succ_a_ada_oneseed = zeros(length(problems),1);
        prob_succ_a_ada_oneseed(index_succ_a_ada) = 1;
        prob_succ_a_ada(:,i_d) = prob_succ_a_ada(:,i_d) + prob_succ_a_ada_oneseed/length(seeds);
        d_est_a_ada(:,i_d,i_s) = d_est_all(3,:);
        nfuneval_a_ada(index_succ_a_ada,i_d,i_s) = nfuneval_all(3,index_succ_a_ada);
        nfuneval_a_ada_A(index_succ_a_ada,i_d,i_s) = d_est_a_ada(index_succ_a_ada,i_d,i_s)*(D+1);
        nfuneval_a_ada_total(:,i_d,i_s) = nfuneval_a_ada(:,i_d,i_s) + nfuneval_a_ada_A(:,i_d,i_s);
        t_a_ada_emb(index_succ_a_ada,i_d,i_s) = t_all(3,index_succ_a_ada);
        t_a_ada_A(index_succ_a_ada,i_d,i_s) = t_A_all(3,index_succ_a_ada);
        t_a_ada_total(:,i_d,i_s) = t_a_ada_emb(:,i_d,i_s) + t_a_ada_A(:,i_d,i_s);
        % A-REGO
        obj_r_ada = obj_all(4,:);
        index_succ_r_ada = find((obj_r_ada <= f_opt + 1e-3));
        prob_succ_r_ada_oneseed = zeros(length(problems),1);
        prob_succ_r_ada_oneseed(index_succ_r_ada) = 1;
        prob_succ_r_ada(:,i_d) = prob_succ_r_ada(:,i_d) + prob_succ_r_ada_oneseed/length(seeds);
        d_est_r_ada(:,i_d,i_s) = d_est_all(4,:);
        nfuneval_r_ada(index_succ_r_ada,i_d,i_s) = nfuneval_all(4,index_succ_r_ada);
        t_r_ada_emb(index_succ_r_ada,i_d,i_s) = t_all(4,index_succ_r_ada);
        t_r_ada_A(index_succ_r_ada,i_d,i_s) = t_A_all(4,index_succ_r_ada);
        t_r_ada_total(:,i_d,i_s) = t_r_ada_emb(:,i_d,i_s) + t_r_ada_A(:,i_d,i_s);
    end
end

% no embedding algorithm
seed = 0;
nfuneval_noem = 10^18*ones(length(problems),length(Ds));
t_noem = 10^18*ones(length(problems),length(Ds));
obj_noem = zeros(length(problems),length(Ds));
prob_succ_noem = zeros(length(problems),length(Ds));
for i_d = 1:length(Ds)
    D = Ds(i_d);
    filename = strcat('Results_global_seed_',num2str(seed),'_D_',num2str(D),'_noem.mat');
    data = load(filename);
    obj_all = data.(strcat('obj'));
    nfuneval_all = data.(strcat('nfuneval'));
    t_all = data.(strcat('t'));
    obj_noem(:,i_d) = obj_all;
    index_succ_noem = find(obj_all <= f_opt + 1e-3);
    prob_succ_noem(index_succ_noem,i_d) = 1;
    nfuneval_noem(index_succ_noem,i_d) = nfuneval_all(1,index_succ_noem);
    t_noem(index_succ_noem,i_d) = t_all(1,index_succ_noem);
end

% performance profiles with performance metric as number of function evaluations
value_n = 10.^(0:0.01:4);
nfuneval_min = zeros(length(problems),length(Ds),length(seeds));
for i_s = 1:length(seeds)
    for i_d = 1:length(Ds)
        for i_p = 1:length(problems)
            nfuneval_min(i_p,i_d,i_s) = min([nfuneval_a_total(i_p,i_d,i_s),nfuneval_r(i_p,i_d,i_s),nfuneval_noem(i_p,i_d)...
                nfuneval_a_ada_total(i_p,i_d,i_s),nfuneval_r_ada(i_p,i_d,i_s)]);
        end
    end
end
piA_a = zeros(length(value_n),length(Ds),length(seeds));
piA_r = zeros(length(value_n),length(Ds),length(seeds));
piA_a_ada = zeros(length(value_n),length(Ds),length(seeds));
piA_r_ada = zeros(length(value_n),length(Ds),length(seeds));
piA_noem = zeros(length(value_n),length(Ds));
for i_s = 1:length(seeds)
    for i_d = 1:length(Ds)
        for i_v = 1:length(value_n)
            inter_n_value = value_n(i_v) * nfuneval_min(:,i_d,i_s);
            piA_a(i_v,i_d,i_s) = length(find(nfuneval_a_total(:,i_d,i_s) < inter_n_value))/length(problems);
            piA_r(i_v,i_d,i_s) = length(find(nfuneval_r(:,i_d,i_s) < inter_n_value))/length(problems);
            piA_noem(i_v,i_d) = length(find(nfuneval_noem(:,i_d) < inter_n_value))/length(problems);
            piA_a_ada(i_v,i_d,i_s) = length(find(nfuneval_a_ada_total(:,i_d,i_s) < inter_n_value))/length(problems);
            piA_r_ada(i_v,i_d,i_s) = length(find(nfuneval_r_ada(:,i_d,i_s) < inter_n_value))/length(problems);
        end
    end
end

for i_d = 1:length(Ds)
    D = Ds(i_d);
    fig_num = i_d;
    figure(fig_num)
    set(fig_num,'Position',[500 500 1000 400])
    for i_s = 1:length(seeds)
        semilogx(value_n,piA_a(:,i_d,i_s),'LineWidth',2,'Color','[0.4660 0.6740 0.1880]');hold on;
        semilogx(value_n,piA_r(:,i_d,i_s),'LineWidth',2,'Color','[0 0.4470 0.7410]');hold on;
        semilogx(value_n,piA_a_ada(:,i_d,i_s),'LineWidth',2,'Color','[0.6350 0.0780 0.1840]');hold on;
        semilogx(value_n,piA_r_ada(:,i_d,i_s),'LineWidth',2,'Color','[0.9290 0.6940 0.1250]');hold on;
        semilogx(value_n,piA_noem(:,i_d),'LineWidth',2,'Color','k');hold on;
    end
    hold off
    grid on
    title(['$D=$' num2str(D)], 'Fontsize',18,'Interpreter','latex')
    xlabel('Performance ratio $\alpha$', 'Fontsize',18,'Interpreter','latex')
    ylabel('Perf. proba $\pi_A(\alpha)$', 'Fontsize',18,'Interpreter','latex')
    ax = gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    legend('ASM-1 ($M=d_e$)','REGO-1 ($d=d_e$)','A-ASM','A-REGO','no embeddings', 'Fontsize', 16,'location','southeast','Interpreter','latex')
    saveas(fig_num,['perf_nfuneval_D' num2str(D) '.fig'])
    saveas(fig_num,['perf_nfuneval_D' num2str(D) '.png'])
    saveas(fig_num,['perf_nfuneval_D' num2str(D) '.eps'],'epsc')
end

% performance profile with performance metric as CPU time
value_t = 10.^(0:0.01:4);
t_min = zeros(length(problems),length(Ds),length(seeds));
for i_s = 1:length(seeds)
    for i_d = 1:length(Ds)
        for i_p = 1:length(problems)
            t_min(i_p,i_d,i_s) = min([t_a_total(i_p,i_d,i_s),t_r_emb(i_p,i_d,i_s),t_noem(i_p,i_d)...
                t_a_ada_total(i_p,i_d,i_s),t_r_ada_emb(i_p,i_d,i_s)]);
        end
    end
end
piAt_a = zeros(length(value_t),length(Ds),length(seeds));
piAt_r = zeros(length(value_t),length(Ds),length(seeds));
piAt_a_ada = zeros(length(value_t),length(Ds),length(seeds));
piAt_r_ada = zeros(length(value_t),length(Ds),length(seeds));
piAt_noem = zeros(length(value_t),length(Ds));
for i_s = 1:length(seeds)
    for i_d = 1:length(Ds)
        for i_v = 1:length(value_t)
            inter_t_value = value_n(i_v) * t_min(:,i_d,i_s);
            piAt_a(i_v,i_d,i_s) = length(find(t_a_total(:,i_d,i_s) < inter_t_value))/length(problems);
            piAt_r(i_v,i_d,i_s) = length(find(t_r_emb(:,i_d,i_s) < inter_t_value))/length(problems);
            piAt_noem(i_v,i_d) = length(find(t_noem(:,i_d) < inter_t_value))/length(problems);
            piAt_a_ada(i_v,i_d,i_s) = length(find(t_a_ada_total(:,i_d,i_s) < inter_t_value))/length(problems);
            piAt_r_ada(i_v,i_d,i_s) = length(find(t_r_ada_emb(:,i_d,i_s) < inter_t_value))/length(problems);
        end
    end
end

for i_d = 1:length(Ds)
    D = Ds(i_d);
    fig_num = length(Ds)+i_d;
    figure(fig_num)
    set(fig_num,'Position',[500 500 1000 400])
    for i_s = 1:length(seeds)
        semilogx(value_t,piAt_a(:,i_d,i_s),'LineWidth',2,'Color','[0.4660 0.6740 0.1880]');hold on;%[0.4940 0.1840 0.5560],[0.4660 0.6740 0.1880]
        semilogx(value_t,piAt_r(:,i_d,i_s),'LineWidth',2,'Color','[0 0.4470 0.7410]');hold on;
        semilogx(value_t,piAt_a_ada(:,i_d,i_s),'LineWidth',2,'Color','[0.6350 0.0780 0.1840]');hold on;
        semilogx(value_t,piAt_r_ada(:,i_d,i_s),'LineWidth',2,'Color','[0.9290 0.6940 0.1250]');hold on;
        semilogx(value_t,piAt_noem(:,i_d),'LineWidth',2,'Color','k');hold on;
    end
    hold off
    grid on
    title(['$D=$' num2str(D)], 'Fontsize',18,'Interpreter','latex')
    xlabel('Performance ratio $\alpha$', 'Fontsize',18,'Interpreter','latex')
    ylabel('Perf. proba $\pi_A(\alpha)$', 'Fontsize',18,'Interpreter','latex')
    ax = gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    legend('ASM-1 ($M=d_e$)','REGO-1 ($d=d_e$)','A-ASM','A-REGO','no embeddings', 'Fontsize', 16,'location','southeast','Interpreter','latex')
    saveas(fig_num,['perf_t_D' num2str(D) '.fig'])
    saveas(fig_num,['perf_t_D' num2str(D) '.png'])
    saveas(fig_num,['perf_t_D' num2str(D) '.eps'],'epsc')
end
