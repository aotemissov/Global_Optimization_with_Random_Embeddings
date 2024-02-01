% ------------------------------------------------------------------- %
% function A_1_global(name,D,seed,matfile)
%
% ASM-1 algorithm
%
% input:  name         = name of the test function
%         D            = dimension of the domain of the function
%         seed         = The option of seed set
%         matfile      = name of the .mat file to save the results
% output: f_out        = global minimum of the function
%         x_out        = argument of global minimum of the function
%         d_out        = estimted dimension of effective subspace
%         nfuneval_out = total number of function evaluations
%         t_emb_out    = total CPU time for Knitro computation
%         t_A_out      = total CPU time for A computation
%         Q            = orthogonal matrix for rotating the function
%         n_emb        = number of embeddings
% ------------------------------------------------------------------- %
function [f_out,x_out,d_out,nfuneval_out,t_emb_out,t_A_out,Q] = ASM_1_global(name,D,seed,matfile,varargin)

[filepart,~,~] = fileparts(pwd);
loadpath = fullfile(filepart,'Test_set_grad');
addpath(genpath(loadpath));
loadpath = fullfile(filepart,'Test_set_red');
addpath(genpath(loadpath));
% The solver used here is Knitro, so one may need to add a path to
% folder where the knitro code is lied
warning('off', 'all');
options = optimset('Display','off');

rng(seed);
p = 2*rand(D,1)-ones(D,1);
Q = orth(randn(D));
if isempty(varargin) == 0
    dim = varargin{1};
    [d_e, ~, ~, bounds] = Extract_function_inf1(name,dim);
else
    [d_e, ~, ~, bounds] = Extract_function_inf1(name);
end

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

% Compute gradient matrix C and set initial value
tic;
df_rec = zeros(D,d_e);
for i = 1:d_e
    x = 2*rand(D,1)-ones(D,1);
    df_rec(:,i) = fun_grad(x);
end
weights = 1/d_e;
C = df_rec * df_rec' * weights;
[W, ~] = svd(C(:,1:d_e));
d_rec = rank(C);
A = W(:,1:d_rec);
t_A_rec = toc;
y0 = zeros(d_rec,1);

switch name
    case 'Beale'
        fun_red = @(y) Beale_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Branin'
        fun_red = @(y) Branin_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Brent'
        fun_red = @(y) Brent_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Camel'
        fun_red = @(y) Camel_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Goldstein_Price'
        fun_red = @(y) Goldstein_Price_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Hartmann3'
        fun_red =  @(y) Hartmann3_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Hartmann6'
        fun_red =  @(y) Hartmann6_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Levy'
        fun_red =  @(y) Levy_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Rosenbrock'
        fun_red =  @(y) Rosenbrock_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Shekel5'
        fun_red =  @(y) Shekel5_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Shekel7'
        fun_red =  @(y) Shekel7_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Shekel10'
        fun_red =  @(y) Shekel10_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Shubert'
        fun_red =  @(y) Shubert_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Styblinski_Tang'
        fun_red =   @(y) Styblinski_Tang_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Trid'
        fun_red =  @(y) Trid_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
    case 'Zettl'
        fun_red =  @(y) Zettl_function_ada(y,Q,A,D,d_rec,d_e,p,bounds);
end

filename = strcat('Option_files/options_global_seed_',num2str(seed),'.opt');
tic;
[ymin_red,f_rec,~,output_red,~,~,~] = knitro_nlp(fun_red,y0,[],[],[],[],[],[],[],[],options,filename);
e = toc;

t_emb_rec = e;
x_rec = A*ymin_red+p;
nfuneval_rec = output_red.funcCount;

fprintf('Dimension is %d, previous cost %4.2e\n',d_rec,f_rec);

f_out = f_rec;
x_out = x_rec;
nfuneval_out = nfuneval_rec;
d_out = d;
t_emb_out = t_emb_rec;
t_A_out = t_A_rec;

if isempty(varargin) == 0
    name = strcat(name, num2str(d_e));
end

if (exist(matfile,'file') == 2)
    DATA = load(matfile);
    DATA.(strcat(name,'_',num2str(D),'_x')) = x_rec;
    DATA.(strcat(name,'_',num2str(D),'_t_emb')) = t_emb_rec;
    DATA.(strcat(name,'_',num2str(D),'_t_A')) = t_A_rec;
    DATA.(strcat(name,'_',num2str(D),'_f')) = f_rec;
    DATA.(strcat(name,'_',num2str(D),'_d')) = d_rec;
    DATA.(strcat(name,'_',num2str(D),'_nfuneval')) = nfuneval_rec;
    DATA.(strcat(name,'_',num2str(D),'_Q')) = Q(:);
    save(matfile, '-struct','DATA','-append');
else
    DATA = struct;
    DATA.(strcat(name,'_',num2str(D),'_x')) = x_rec;
    DATA.(strcat(name,'_',num2str(D),'_t_emb')) = t_emb_rec;
    DATA.(strcat(name,'_',num2str(D),'_t_A')) = t_A_rec;
    DATA.(strcat(name,'_',num2str(D),'_f')) = f_rec;
    DATA.(strcat(name,'_',num2str(D),'_d')) = d_rec;
    DATA.(strcat(name,'_',num2str(D),'_nfuneval')) = nfuneval_rec;
    DATA.(strcat(name,'_',num2str(D),'_Q')) = Q(:);
    save(matfile,'-struct','DATA');
end
diary off;

end
