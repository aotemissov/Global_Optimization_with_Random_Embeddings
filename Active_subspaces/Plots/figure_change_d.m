% --------------------------------------------------------------------------------- %
% function figure_change_d(D, seeds, problems)
%
% input:  D        = a dimension of the domain of the function
%         seeds    = a vector of different options of seed
%         problems = a set of test problems selected from Rosenbrock, Trid and Levy
% output: .fig and .png plots
% ---------------------------------------------------------------------------------- %
function figure_change_d(D, seeds, problems,dims)

[filepart,~,~] = fileparts(pwd);
loadpath = fullfile(filepart,'Results');
addpath(genpath(loadpath));

n_p = length(problems)*length(dims);
f_opt = zeros(1,n_p);
d_e = zeros(1,n_p);
for i_p = 1:length(problems)
    for i_d = 1:length(dims)
        [d_e(1,(i_p-1)*i_d+i_d), f_opt(1,(i_p-1)*i_d+i_d), ~, ~] = Extract_function_inf1(problems{i_p}, dims(i_d));
    end
end

nfuneval_a_total = zeros(n_p,length(seeds));
nfuneval_a_emb = 10^18*ones(n_p,length(seeds));
nfuneval_a_A = zeros(n_p,length(seeds));
t_a_total = zeros(n_p,length(seeds));
t_a_emb = 10^18*ones(n_p,length(seeds));
t_a_A = zeros(n_p,length(seeds));
d_est_a = zeros(n_p,length(seeds));
prob_succ_a = zeros(n_p,1);
nfuneval_r = 10^18*ones(n_p,length(seeds));
t_r_total = zeros(n_p,length(seeds));
t_r_emb = 10^18*ones(n_p,length(seeds));
t_r_A = zeros(n_p,length(seeds));
d_est_r = zeros(n_p,length(seeds));
prob_succ_r = zeros(n_p,1);
nfuneval_a_ada_total = zeros(n_p,length(seeds));
nfuneval_a_ada_emb = 10^18*ones(n_p,length(seeds));
nfuneval_a_ada_A = zeros(n_p,length(seeds));
t_a_ada_total = zeros(n_p,length(seeds));
t_a_ada_emb = 10^18*ones(n_p,length(seeds));
t_a_ada_A = zeros(n_p,length(seeds));
d_est_a_ada = zeros(n_p,length(seeds));
prob_succ_a_ada = zeros(n_p,1);
nfuneval_r_ada = 10^18*ones(n_p,length(seeds));
t_r_ada_total = zeros(n_p,length(seeds));
t_r_ada_emb = 10^18*ones(n_p,length(seeds));
t_r_ada_A = zeros(n_p,length(seeds));
d_est_r_ada = zeros(n_p,length(seeds));
prob_succ_r_ada = zeros(n_p,1);
for i_s = 1:length(seeds)
    seed = seeds(i_s);
    filename = strcat('Results_global_change_d_seed_',num2str(seed),'_D_',num2str(D),'.mat');
    data = load(filename);
    objs = data.(strcat('obj'));
    nfunevals = data.(strcat('nfuneval'));
    d_ests = data.(strcat('d_est'));
    t_embs = data.(strcat('t_emb'));
    t_As = data.(strcat('t_A'));
    % ASM-1
    obj_a = objs(1,:);
    index_succ_a = find((obj_a <= f_opt + 1e-3));
    prob_succ_a_oneseed = zeros(n_p,1);
    prob_succ_a_oneseed(index_succ_a) = 1;
    prob_succ_a = prob_succ_a + prob_succ_a_oneseed/length(seeds);
    d_est_a(:,i_s) = d_ests(1,:);
    nfuneval_a_emb(:,i_s) = nfunevals(1,:);
    nfuneval_a_A(:,i_s) = d_e*(D+1);
    nfuneval_a_total(:,i_s) = nfuneval_a_emb(:,i_s) + nfuneval_a_A(:,i_s);
    t_a_emb(:,i_s) = t_embs(1,:);
    t_a_A(:,i_s) = t_As(1,:);
    t_a_total(:,i_s) = t_a_emb(:,i_s) + t_a_A(:,i_s);
    % REGO-1
    obj_r = objs(2,:);
    index_succ_r = find((obj_r <= f_opt + 1e-3));
    prob_succ_r_oneseed = zeros(n_p,1);
    prob_succ_r_oneseed(index_succ_r) = 1;
    prob_succ_r(:) = prob_succ_r(:) + prob_succ_r_oneseed/length(seeds);
    d_est_r(:,i_s) = d_ests(2,:);
    nfuneval_r(:,i_s) = nfunevals(2,:);
    t_r_emb(:,i_s) = t_embs(2,:);
    t_r_A(:,i_s) = t_As(2,:);
    t_r_total(:,i_s) = t_r_emb(:,i_s) + t_r_A(:,i_s);
    % ASM ada
    obj_a_ada = objs(3,:);
    index_succ_a_ada = find((obj_a_ada <= f_opt + 1e-3));
    prob_succ_a_ada_oneseed = zeros(n_p,1);
    prob_succ_a_ada_oneseed(index_succ_a_ada) = 1;
    prob_succ_a_ada(:) = prob_succ_a_ada(:) + prob_succ_a_ada_oneseed/length(seeds);
    d_est_a_ada(:,i_s) = d_ests(3,:);
    nfuneval_a_ada_emb(:,i_s) = nfunevals(3,:);
    nfuneval_a_ada_A(:,i_s) = d_est_a_ada(:,i_s)*(D+1);
    nfuneval_a_ada_total(:,i_s) = nfuneval_a_ada_emb(:,i_s) + nfuneval_a_ada_A(:,i_s);
    t_a_ada_emb(:,i_s) = t_embs(3,:);
    t_a_ada_A(:,i_s) = t_As(3,:);
    t_a_ada_total(:,i_s) = t_a_ada_emb(:,i_s) + t_a_ada_A(:,i_s);
    % REGO ada
    obj_r_ada = objs(4,:);
    index_succ_r_ada = find((obj_r_ada <= f_opt + 1e-3));
    prob_succ_r_ada_oneseed = zeros(n_p,1);
    prob_succ_r_ada_oneseed(index_succ_r_ada) = 1;
    prob_succ_r_ada(:) = prob_succ_r_ada(:) + prob_succ_r_ada_oneseed/length(seeds);
    d_est_r_ada(:,i_s) = d_ests(4,:);
    nfuneval_r_ada(:,i_s) = nfunevals(4,:);
    t_r_ada_emb(:,i_s) = t_embs(4,:);
    t_r_ada_A(:,i_s) = t_As(4,:);
    t_r_ada_total(:,i_s) = t_r_ada_emb(:,i_s) + t_r_ada_A(:,i_s);
end

nfuneval_a_total_averg = mean(nfuneval_a_total,2);
nfuneval_r_total_averg = mean(nfuneval_r,2);
nfuneval_a_ada_total_averg = mean(nfuneval_a_ada_total,2);
nfuneval_r_ada_total_averg = mean(nfuneval_r_ada,2);

t_a_total_averg = mean(t_a_total,2);
t_r_total_averg = mean(t_r_total,2);
t_a_ada_total_averg = mean(t_a_ada_total,2);
t_r_ada_total_averg = mean(t_r_ada_total,2);


y_nfuneval = zeros(n_p,4);
for i_np = 1:n_p
    y_nfuneval(i_np,:) = [nfuneval_a_total_averg(i_np); nfuneval_r_total_averg(i_np);...
        nfuneval_a_ada_total_averg(i_np); nfuneval_r_ada_total_averg(i_np);];
end

y_t = zeros(n_p,4);
for i_np = 1:n_p
    y_t(i_np,:) = [t_a_total_averg(i_np); t_r_total_averg(i_np);...
        t_a_ada_total_averg(i_np); t_r_ada_total_averg(i_np);];
end

NumStacksPerGroup = 4;
NumGroupsPerAxis = 3;
groupLabels = {'$d_e=10$','$d_e=20$','$d_e=50$'};
groupBins = 1:NumGroupsPerAxis;
MaxGroupWidth = 0.75; % Fraction of 1. If 1, then we have all bars in groups touching
groupOffset = MaxGroupWidth/NumStacksPerGroup;

% performance metric as number of function evaluations
for i_p = 1:length(problems)
    h = [];
    figure(i_p)
    hold on;
    for i=1:NumStacksPerGroup
        Y = y_nfuneval(((i_p-1)*length(dims)+1):((i_p-1)*length(dims)+length(dims)),i);

        % Center the bars:

        internalPosCount = i - ((NumStacksPerGroup+1) / 2);

        % Offset the group draw positions:
        groupDrawPos = (internalPosCount)* groupOffset + groupBins;

        h(i,:) = bar(Y);
        set(h(i,:),'BarWidth',groupOffset);
        set(h(i,:),'XData',groupDrawPos);
        if i == 1
            set(h(i,:),'FaceColor',[0.4660 0.6740 0.1880]);
        elseif i == 2
            set(h(i,:),'FaceColor',[0 0.4470 0.7410]);
        elseif i == 3
            set(h(i,:),'FaceColor',[0.6350 0.0780 0.1840]);
        elseif i == 4
            set(h(i,:),'FaceColor',[0.9290 0.6940 0.1250]);
        end
    end
    hold off;
    grid on; box on;
    ylabel('Number of function evaluations','Interpreter','Latex','FontSize',18)
    set(gca,'XTickMode','manual');
    set(gca,'XTick',1:NumGroupsPerAxis);
    set(gca,'XTickLabelMode','manual');
    set(gca,'XTickLabel',groupLabels, 'TickLabelInterpreter', 'latex','FontSize',18);
    set(gca,'YScale','log')
    legend('ASM-1','REGO-1','A-ASM','A-REGO','Interpreter','Latex','FontSize',16,'location','northwest')
    saveas(i_p,['change_de_',problems{i_p},'_nfuneval.fig'])
    saveas(i_p,['change_de_',problems{i_p},'_nfuneval.png'])
    saveas(i_p,['change_de_',problems{i_p},'_nfuneval.eps'],'epsc')
end

% performance metric as the CPU time
for i_p = 1:length(problems)
    h = [];
    figure(length(problems)+i_p)
    hold on;
    for i=1:NumStacksPerGroup

        Y = y_t(((i_p-1)*length(dims)+1):((i_p-1)*length(dims)+length(dims)),i);

        % Center the bars:

        internalPosCount = i - ((NumStacksPerGroup+1) / 2);

        % Offset the group draw positions:
        groupDrawPos = (internalPosCount)* groupOffset + groupBins;

        h(i,:) = bar(Y);
        set(h(i,:),'BarWidth',groupOffset);
        set(h(i,:),'XData',groupDrawPos);
        if i == 1
            set(h(i,:),'FaceColor',[0.4660 0.6740 0.1880]);
        elseif i == 2
            set(h(i,:),'FaceColor',[0 0.4470 0.7410]);
        elseif i == 3
            set(h(i,:),'FaceColor',[0.6350 0.0780 0.1840]);
        elseif i == 4
            set(h(i,:),'FaceColor',[0.9290 0.6940 0.1250]);
        end
    end
    hold off;
    grid on; box on;
    ylabel('CPU time','Interpreter','Latex','FontSize',18)
    set(gca,'XTickMode','manual');
    set(gca,'XTick',1:NumGroupsPerAxis);
    set(gca,'XTickLabelMode','manual');
    set(gca,'XTickLabel',groupLabels, 'TickLabelInterpreter', 'latex','FontSize',18);
    set(gca,'YScale','log')
    legend('ASM-1','REGO-1','A-ASM','A-REGO','Interpreter','Latex','FontSize',16,'location','northwest')
    saveas(length(problems)+i_p,['change_de_',problems{i_p},'_t.fig'])
    saveas(length(problems)+i_p,['change_de_',problems{i_p},'_t.png'])
    saveas(length(problems)+i_p,['change_de_',problems{i_p},'_t.eps'],'epsc')
end

end