% ------------------------------------------------------------------------- %
% function A_ASM_global(name,D,seed,matfile)
%
% A-ASM algorithm
%
% input:  name         = name of the test function
%         D            = dimension of the domain of the function
%         seed         = The option of seed set
%         matfile      = name of the .mat file to save the results
%         varargin     = set a required effective dimension for Rosenbrock, 
%                        Levy or Trid; if you do not set one, the default
%                        dimension will be used
% output: f_out        = global minimum of the function
%         x_out        = argument of global minimum of the function
%         d_out        = estimted dimension of effective subspace
%         nfuneval_out = total number of function evaluations
%         t_emb_out    = total CPU time for Knitro computation
%         t_A_out      = total CPU time for A computation
%         Q            = orthogonal matrix for rotating the function
%         n_emb        = number of embeddings
% ------------------------------------------------------------------------- %
function [f_out,x_out,d_out,nfuneval_out,t_emb_out,t_A_out,Q,n_emb] = A_ASM_global(name,D,seed,matfile,varargin)

[filepart,~,~] = fileparts(pwd);
loadpath = fullfile(filepart,'Test_set');
addpath(genpath(loadpath));
loadpath = fullfile(filepart,'Test_set_grad');
addpath(genpath(loadpath));
loadpath = fullfile(filepart,'Test_set_red');
addpath(genpath(loadpath));
% The solver used here is Knitro, so one may need to add a path to
% folder where the knitro code is lied

warning('off', 'all');
options = optimset('Display','off');

rng(seed);
tol = 1e-6;
p = 2*rand(D,1)-ones(D,1);
Q = orth(randn(D));
if isempty(varargin) == 0
    dim = varargin{1};
    [d_e, ~, ~, bounds] = Extract_function_inf1(name,dim);
else
    [d_e, ~, ~, bounds] = Extract_function_inf1(name);
end

maxiter = D;
f_rec = zeros(1,maxiter+1);
x_rec = cell(1,maxiter+1);
t_emb_rec = zeros(1,maxiter+1);
t_A_rec = zeros(1,maxiter+1);
d_rec = zeros(1,maxiter+1);
nfuneval_rec = zeros(1, maxiter+1);

switch name
    case 'Beale'
        fun_grad = @(x) Beale_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Beale_function_orth(x,Q,D,d_e,bounds);
    case 'Branin'
        fun_grad = @(x) Branin_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Branin_function_orth(x,Q,D,d_e,bounds);
    case 'Brent'
        fun_grad = @(x) Brent_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Brent_function_orth(x,Q,D,d_e,bounds);
    case 'Camel'
        fun_grad = @(x) Camel_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Camel_function_orth(x,Q,D,d_e,bounds);
    case 'Goldstein_Price'
        fun_grad = @(x) Goldstein_Price_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Goldstein_Price_function_orth(x,Q,D,d_e,bounds);
    case 'Hartmann3'
        fun_grad = @(x) Hartmann3_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Hartmann3_function_orth(x,Q,D,d_e,bounds);
    case 'Hartmann6'
        fun_grad = @(x) Hartmann6_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Hartmann6_function_orth(x,Q,D,d_e,bounds);
    case 'Levy'
        fun_grad = @(x) Levy_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Levy_function_orth(x,Q,D,d_e,bounds);
    case 'Rosenbrock'
        fun_grad = @(x) Rosenbrock_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Rosenbrock_function_orth(x,Q,D,d_e,bounds);
    case 'Shekel5'
        fun_grad = @(x) Shekel5_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Shekel5_function_orth(x,Q,D,d_e,bounds);
    case 'Shekel7'
        fun_grad = @(x) Shekel7_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Shekel7_function_orth(x,Q,D,d_e,bounds);
    case 'Shekel10'
        fun_grad = @(x) Shekel10_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Shekel10_function_orth(x,Q,D,d_e,bounds);
    case 'Shubert'
        fun_grad = @(x) Shubert_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Shubert_function_orth(x,Q,D,d_e,bounds);
    case 'Styblinski_Tang'
        fun_grad = @(x) Styblinski_Tang_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Styblinski_Tang_function_orth(x,Q,D,d_e,bounds);
    case 'Trid'
        fun_grad = @(x) Trid_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Trid_function_orth(x,Q,D,d_e,bounds);
    case 'Zettl'
        fun_grad = @(x) Zettl_function_orth_grad(x,Q,D,d_e,bounds);
        fun = @(x) Zettl_function_orth(x,Q,D,d_e,bounds);
end

% initialization. For the other vectors (d_rec, t_rec, nfun_rec), this is zero and coincides to the preallocated value.
f_rec(1) = fun(p);
x_rec{1} = p;
iter = 1;
stop = 0;
d = 1;
norm_df = 1;
tic;
x = 2*rand(D,1)-ones(D,1);
A = fun_grad(x);
A = orth(A);
t_A_rec(iter) = toc;

while (~stop && iter < maxiter +1)

    fprintf('Iteration number %d dimension is %d, previous cost %4.2e, norm of gradient %4.2e\n',iter,d,f_rec(iter),norm_df);
    y0 = zeros(d,1);

    switch name
        case 'Beale'
            fun_red = @(y) Beale_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Branin'
            fun_red = @(y) Branin_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Brent'
            fun_red = @(y) Brent_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Camel'
            fun_red = @(y) Camel_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Goldstein_Price'
            fun_red = @(y) Goldstein_Price_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Hartmann3'
            fun_red =  @(y) Hartmann3_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Hartmann6'
            fun_red =  @(y) Hartmann6_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Levy'
            fun_red =  @(y) Levy_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Rosenbrock'
            fun_red =  @(y) Rosenbrock_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Shekel5'
            fun_red =  @(y) Shekel5_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Shekel7'
            fun_red =  @(y) Shekel7_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Shekel10'
            fun_red =  @(y) Shekel10_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Shubert'
            fun_red =  @(y) Shubert_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Styblinski_Tang'
            fun_red =   @(y) Styblinski_Tang_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Trid'
            fun_red =  @(y) Trid_function_ada(y,Q,A,D,d,d_e,p,bounds);
        case 'Zettl'
            fun_red =  @(y) Zettl_function_ada(y,Q,A,D,d,d_e,p,bounds);
    end

    filename = strcat('Option_files/options_global_seed_',num2str(seed),'.opt');
    tic;
    [ymin_red,fmin_red,~,output_red,~,~,~] = knitro_nlp(fun_red,y0,[],[],[],[],[],[],[],[],options,filename);
    e = toc;

    iter = iter+1;
    f_rec(iter) = fmin_red;
    t_emb_rec(iter) = e;
    d_rec(iter) = d;
    x_rec{iter} = A*ymin_red+p;
    nfuneval_rec(iter) = output_red.funcCount;

    p = x_rec{iter};
    d = d+1;

    if stop == 0
        tic;
        iter_critg = 1;
        norm_df = 0;
        while (norm_df < tol && iter_critg < 6 )
            x_new = 2*rand(D,1)-ones(D,1);
            df_new_unorth = fun_grad(x_new);
            df_new = df_new_unorth;
            for iter_critf = 1:size(A,2)
                df_new = df_new - (df_new_unorth'*A(:,iter_critf))*A(:,iter_critf);
            end
            iter_critg = iter_critg + 1;
            norm_df = norm(df_new);
        end
        A = [A df_new/norm(df_new)];
        t_A_rec(iter) = toc;
        if norm_df < tol
            stop = 1;
            fprintf('criterion for gradient generate stops the algorithm\n');
        end
    end
end  % end while (over subspaces)

[f_out,indx] = min(f_rec(1:iter));
x_out = x_rec{indx};
nfuneval_out = sum(nfuneval_rec);
t_emb_out = sum(t_emb_rec);
t_A_out = sum(t_A_rec);
d_out = d_rec(indx);
n_emb = iter-1;

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
    DATA.(strcat(name,'_',num2str(D),'_n_emb')) = n_emb;
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
    DATA.(strcat(name,'_',num2str(D),'_n_emb')) = n_emb;
    save(matfile,'-struct','DATA');
end

diary off;

end
