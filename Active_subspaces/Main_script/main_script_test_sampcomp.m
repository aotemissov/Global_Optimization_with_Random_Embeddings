% ------------------------------------------------------------------------- %
% function main_script_test_sampcomp(Ms, seeds, problems, varagin)
%
% input:  Ds       = a vector of dimension of the domain of the function
%         Ms       = a vector of different number of samples M
%         seeds    = a vector of options of seed
%         problems = a set of test problems selected from the test set with
%                    default effective dimension
%         varargin  = a vector of different value of alpha
% output: .mat file including the results
% ------------------------------------------------------------------------- %
function main_script_test_sampcomp(Ds, Ms, seeds, problems, varargin)

[filepart,~,~] = fileparts(pwd);
loadpath = fullfile(filepart,'Test_set_grad');
addpath(genpath(loadpath));

rng('default')
if any(strcmp(problems, 'aEasom'))
    alphas = varargin{1};
    n_otherp = length(problems) - 1;
    n_aEasom_rec = zeros(length(alphas),length(Ms),length(seeds),length(Ds));
end

n_rec = zeros(n_otherp,length(Ms),length(seeds),length(Ds));

for i_d = 1:length(Ds)
    D = Ds(i_d);
    for i_s = 1:length(seeds)
        seed = seeds(i_s);
        i_np = 1;
        for i_p = 1:length(problems)
            name = problems{i_p};
            rng(seed);
            Q = orth(randn(D));
            [d_e, ~, ~, bounds] = Extract_function_inf1(name);
            if strcmp(name,'aEasom')
                for i_a = 1:length(alphas)
                    alpha = alphas(i_a);
                    for i_m = 1:length(Ms)
                        fun_grad = @(x) aEasom_function_orth_grad(x,Q,D,d_e,bounds,alpha);
                        M = Ms(i_m);
                        X = 2*rand(D,M)-1;
                        C = zeros(D,D);
                        for j = 1:M
                            df = fun_grad(X(:,j));
                            C = C + (df*df')/M;
                        end
                        d = rank(C);
                        n_aEasom_rec(i_a, i_m,i_s,i_d) = d;
                    end
                end
            else
                for i_m = 1:length(Ms)
                    switch name
                        case 'Beale'
                            fun_grad = @(x) Beale_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Branin'
                            fun_grad = @(x) Branin_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Brent'
                            fun_grad = @(x) Brent_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Camel'
                            fun_grad = @(x) Camel_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Goldstein_Price'
                            fun_grad = @(x) Goldstein_Price_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Hartmann3'
                            fun_grad = @(x) Hartmann3_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Hartmann6'
                            fun_grad = @(x) Hartmann6_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Levy'
                            fun_grad = @(x) Levy_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Rosenbrock'
                            fun_grad = @(x) Rosenbrock_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Shekel5'
                            fun_grad = @(x) Shekel5_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Shekel7'
                            fun_grad = @(x) Shekel7_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Shekel10'
                            fun_grad = @(x) Shekel10_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Shubert'
                            fun_grad = @(x) Shubert_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Styblinski_Tang'
                            fun_grad = @(x) Styblinski_Tang_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Trid'
                            fun_grad = @(x) Trid_function_orth_grad(x,Q,D,d_e,bounds);
                        case 'Zettl'
                            fun_grad = @(x) Zettl_function_orth_grad(x,Q,D,d_e,bounds);
                    end

                    M = Ms(i_m);
                    X = 2*rand(D,M)-1;
                    C = zeros(D,D);
                    for j = 1:M
                        df = fun_grad(X(:,j));
                        C = C + (df*df')/M;
                    end
                    d = rank(C);
                    n_rec(i_np, i_m,i_s,i_d) = d;
                end
                i_np = i_np + 1;
            end
        end
    end
end

d_e = zeros(length(problems),1);
for i_p = 1:length(problems)
    name  = problems{i_p};
    [d_e(i_p), ~, ~, ~] = Extract_function_inf1(name);
end

% the probablity of success for each problem
if any(strcmp(problems, 'aEasom'))
    succ_pp_aEasom = zeros(length(alphas),length(Ms),length(Ds));
    changep_aEasom = zeros(length(alphas),length(Ds));
end
succ_pp = zeros(n_otherp,length(Ms),length(Ds));
changep = zeros(n_otherp,length(Ds));
for i_d = 1:length(Ds)
    i_np = 1;
    for i_p = 1:length(problems)
        if strcmp(problems{i_p}, 'aEasom')
            for i_a = 1:length(alphas)
                index_changep_aEasom = 0;
                for i_m = 1:length(Ms)
                    index_aEasom = find(n_aEasom_rec(i_a,i_m,:,i_d) == d_e(i_p));
                    succ_pp_aEasom(i_a,i_m,i_d) = length(index_aEasom)/length(seeds);
                    if succ_pp_aEasom(i_a,i_m,i_d) ~= 1
                        index_changep_aEasom = i_m;
                    end
                end
                index_changep_aEasom = index_changep_aEasom + 1;
                changep_aEasom(i_a,i_d) = Ms(min(index_changep_aEasom,length(Ms)));
            end
        else
            index_changep = 0;
            for i_m = 1:length(Ms)
                index = find(n_rec(i_np,i_m,:,i_d) == d_e(i_p));
                succ_pp(i_np,i_m,i_d) = length(index)/length(seeds);
                if succ_pp(i_np,i_m,i_d) ~= 1
                    index_changep = i_m;
                end
            end
            index_changep = index_changep + 1;
            changep(i_np,i_d) = Ms(min(index_changep,length(Ms)));
            i_np = i_np + 1;
        end
    end
end

% save results

if any(strcmp(problems, 'aEasom'))
    loadpath = fullfile(filepart,strcat('Results/sampcomp_', num2str(length(problems)),'problems_',...
        num2str(length(seeds)),'seeds_',num2str(length(Ms)),'Ms_',num2str(length(alphas)),...
        'alphas.mat'));
    save(loadpath,'succ_pp','succ_pp_aEasom','problems','n_rec','n_aEasom_rec','d_e');
else
    loadpath = fullfile(filepart,strcat('Results/sampcomp_', num2str(length(problems)),'problems_',...
        num2str(length(seeds)),'seeds_',num2str(length(Ms)),'Ms.mat'));
    save(loadpath,'succ_pp','problems','n_rec','d_e');
end

end
