% --------------------------------------------------------------------------------- %
% function main_script_test_global_change_d(D,seed,tol)
%
% The main script for testing ASM-1, REGO-1, A-ASM and A-REGO algorithms on
% the Rosenbrock and Trid functions on different dimension of effective
% subspace.
%
% input:  D        = a dimension of the domain of the function
%         seed     = one option of seed set
%         problems = a set of test problems selected from Rosenbrock, Trid and Levy
%         dims     = a vector of different effective dimensions
% output: .mat file including the results
% ---------------------------------------------------------------------------------- %
function main_script_test_global_change_d(D,seed,problems,dims)

[filepart,~,~] = fileparts(pwd);
loadpath = fullfile(filepart,'Algorithms');
addpath(genpath(loadpath));

n_p = length(dims)*length(problems);
d_e = zeros(1,n_p);
f_opt = zeros(1,n_p);
obj = zeros(4,n_p);
nfuneval = zeros(4,n_p);
d_est = zeros(4,n_p);
t_emb = zeros(4,n_p);
t_A = zeros(4,n_p);

for i_p = 1:n_p
    for i_d = 1:length(dims)
        fprintf(strcat('Problem: ',problems{i_p}, ' with dim=', num2str(dims(i_d)) ,' \n'));

        % extract the information on problem i_p: minimum cost,
        [d_e((i_p-1)*i_d+i_d),f_opt((i_p-1)*i_d+i_d),~,~] = Extract_function_inf1(problems{i_p},dims(i_d));

        % call ASM-1
        [obj(1,(i_p-1)*i_d+i_d), ~, d_est(1,(i_p-1)*i_d+i_d), nfuneval(1,(i_p-1)*i_d+i_d),t_emb(1,(i_p-1)*i_d+i_d),t_A(1,(i_p-1)*i_d+i_d),~] = ASM_1_global(problems{i_p},D,seed,strcat('Results/',problems{i_p},dims(i_d),'_ASM1_D_',num2str(D),'_seed_',num2str(seed),'.mat'),dims(i_d));
        if (obj(1,(i_p-1)*i_d+i_d) > f_opt((i_p-1)*i_d+i_d)+1e-3)
        	  fprintf('ASM-1 did not converge on problem %d \n', i_p);
        end

        % call REGO-1
        [obj(2,(i_p-1)*i_d+i_d), ~, d_est(2,(i_p-1)*i_d+i_d), nfuneval(2,(i_p-1)*i_d+i_d),t_emb(2,(i_p-1)*i_d+i_d),t_A(2,(i_p-1)*i_d+i_d),~] = REGO_1_global(problems{i_p},D,seed,strcat('Results/',problems{i_p},dims(i_d),'_REGO1_D_',num2str(D),'_seed_',num2str(seed),'.mat'),dims(i_d));
        if (obj(2,(i_p-1)*i_d+i_d) > f_opt((i_p-1)*i_d+i_d)+1e-3)
            fprintf('REGO-1 did not converge on problem %d \n', i_p);
        end

        % call A-ASM
        [obj(3,(i_p-1)*i_d+i_d), ~, d_est(3,(i_p-1)*i_d+i_d), nfuneval(3,(i_p-1)*i_d+i_d),t_emb(3,(i_p-1)*i_d+i_d),t_A(3,(i_p-1)*i_d+i_d),~,~] = A_ASM_global(problems{i_p},D,seed,strcat('Results/',problems{i_p},dims(i_d),'_AASM_D_',num2str(D),'_seed_',num2str(seed),'.mat'),dims(i_d));
        if (obj(3,(i_p-1)*i_d+i_d) > f_opt((i_p-1)*i_d+i_d)+1e-3)
            fprintf('A-ASM did not converge on problem %d \n', i_p);
        end

        % call A-REGO adaptive
        [obj(4,(i_p-1)*i_d+i_d), ~, d_est(4,(i_p-1)*i_d+i_d), nfuneval(4,(i_p-1)*i_d+i_d),t_emb(4,(i_p-1)*i_d+i_d),t_A(4,(i_p-1)*i_d+i_d),~,~] = A_REGO_global(problems{i_p},D,seed,strcat('Results/',problems{i_p},dims(i_d),'_AREGO_D_',num2str(D),'_seed_',num2str(seed),'.mat'),dims(i_d));
        if (obj(4,(i_p-1)*i_d+i_d) > f_opt((i_p-1)*i_d+i_d)+1e-3)
            fprintf('A-REGO did not converge on problem %d \n', i_p);
        end
    end

end

loadpath = fullfile(filepart,strcat('Results/Results_global_change_d_seed_',num2str(seed),'_D_',num2str(D),'.mat'));
save(loadpath,'obj','nfuneval','f_opt','d_est','d_e','t_emb','t_A','dims','problems');

end
