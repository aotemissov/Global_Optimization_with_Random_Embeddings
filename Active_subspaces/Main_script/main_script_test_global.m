% ----------------------------------------------------------------------------- %
% function main_script_test_global(D,seed,tol)
%
% The main script for testing ASM-1, REGO-1, A-ASM, A-REGO and no embedding
% algorithms on the functions in the test set excluding Easom.
%
% input:  D        = a dimension of the domain of the function
%         seed     = one option of seed set
%         problems = a set of test problems selected from the test set without 
%                    aEasom with default effective dimension
% output: .mat file including the results
% ----------------------------------------------------------------------------- %
function main_script_test_global(D,seed,problems)

[filepart,~,~] = fileparts(pwd);
loadpath = fullfile(filepart,'Algorithms');
addpath(genpath(loadpath));

obj = zeros(5,length(problems));
nfuneval = zeros(5,length(problems));
d_est = zeros(5,length(problems));
d_e = zeros(1,length(problems));
f_opt = zeros(1,length(problems));
t_emb = zeros(5,length(problems));
t_A = zeros(5,length(problems));

for i_p = 1:length(problems)
    fprintf(strcat('Problem: ',problems{i_p},' \n'));

    % extract the information on problem i_p: minimum cost,
    [d_e(i_p),f_opt(i_p),~,~] = Extract_function_inf1(problems{i_p});

    % call ASM-1
    [obj(1,i_p), ~, d_est(1,i_p), nfuneval(1,i_p),t_emb(1,i_p),t_A(1,i_p),~] = ASM_1_global(problems{i_p},D,seed,strcat('Results/',problems{i_p},'_ASM1_D_',num2str(D),'_seed_',num2str(seed),'.mat'));
    if (obj(1,i_p) > f_opt(i_p)+1e-3)
  	  fprintf('ASM-1 did not converge on problem %d \n', i_p);
    end

    % call REGO-1
    [obj(2,i_p), ~, d_est(2,i_p), nfuneval(2,i_p),t_emb(2,i_p),t_A(2,i_p),~] = REGO_1_global(problems{i_p},D,seed,strcat('Results/',problems{i_p},'_REGO1_D_',num2str(D),'_seed_',num2str(seed),'.mat'));
    if (obj(2,i_p) > f_opt(i_p)+1e-3)
        fprintf('REGO-1 did not converge on problem %d \n', i_p);
    end

    % call A-ASM
    [obj(3,i_p), ~, d_est(3,i_p), nfuneval(3,i_p),t_emb(3,i_p),t_A(3,i_p),~,~] = A_ASM_global(problems{i_p},D,seed,strcat('Results/',problems{i_p},'_AASM_D_',num2str(D),'_seed_',num2str(seed),'.mat'));
    if (obj(3,i_p) > f_opt(i_p)+1e-3)
        fprintf('A-ASM did not converge on problem %d \n', i_p);
    end

    % call A-REGO
    [obj(4,i_p), ~, d_est(4,i_p), nfuneval(4,i_p),t_emb(4,i_p),t_A(4,i_p),~,~] = A_REGO_global(problems{i_p},D,seed,strcat('Results/',problems{i_p},'_AREGO_D_',num2str(D),'_seed_',num2str(seed),'.mat'));
    if (obj(4,i_p) > f_opt(i_p)+1e-3)
        fprintf('A-REGO did not converge on problem %d \n', i_p);
    end

    % call no-embedding
    [obj(5,i_p), ~, nfuneval(5,i_p),t_emb(5,i_p),~] = no_embedding_global(problems{i_p},D,seed,strcat('Results/',problems{i_p},'_D_',num2str(D),'seed',num2str(seed),'.mat'));
    if (obj(5,i_p) > f_opt(i_p)+1e-3)
  	  fprintf('no embedding did not converge on problem %d \n', i_p);
    end

end

loadpath = fullfile(filepart,strcat('Results/Results_global_seed_',num2str(seed),'_D_',num2str(D),'.mat'));
save(loadpath,'obj','nfuneval','f_opt','d_est','d_e','t_emb','t_A','problems');

end
