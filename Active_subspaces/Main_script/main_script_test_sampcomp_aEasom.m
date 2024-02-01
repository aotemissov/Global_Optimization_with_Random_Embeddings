% -------------------------------------------------------------------- %
% function main_script_test_sampcomp_aEasom(Ds, Ms, seeds, alphas)
%
% input:  Ds     = a vector of dimension of the domain of the function
%         Ms     = a vector of different number of samples M
%         seeds  = a vector of different options of seed
%         alphas = a vector of different value of alpha
% output: .mat file including the results
% --------------------------------------------------------------------- %
function main_script_test_sampcomp_aEasom(Ds, Ms, seeds, alphas)

[filepart,~,~] = fileparts(pwd);
loadpath = fullfile(filepart,'Test_set_grad');
addpath(genpath(loadpath));

rng('default')
d_e = 2;
d_rec = zeros(length(alphas),length(seeds),length(Ds));
M_rec = zeros(length(alphas),length(seeds),length(Ds));
for i_d = 1:length(Ds)
    D = Ds(i_d);
    for i_s = 1:length(seeds)
        seed = seeds(i_s);
        for i_a = 1:length(alphas)
            alpha = alphas(i_a);
            rng(seed);
            Q = orth(randn(D));
            bounds = repmat([-100,100],d_e,1);
            d = 0;
            i = 0;
            while (d < d_e && i<length(Ms))
                i = i+1;
                M = Ms(i);
                X = 2*rand(D,M)-1;
                C = zeros(D,D);
                for j = 1:M
                    df = aEasom_function_orth_grad(X(:,j),Q,D,d_e,bounds,alpha);
                    C = C + (df*df')/M;
                end
                d = rank(C);
            end
            d_rec(i_a,i_s,i_d) = d;
            M_rec(i_a,i_s,i_d) = M;

        end
    end
end

% save results
loadpath = fullfile(filepart,strcat('Results/sampcomp_aEasom_',num2str(length(seeds)),'seeds_',...
    num2str(length(Ms)),'Ms_',num2str(length(alphas)),'alphas.mat'));
save(loadpath, 'd_rec','M_rec');

end