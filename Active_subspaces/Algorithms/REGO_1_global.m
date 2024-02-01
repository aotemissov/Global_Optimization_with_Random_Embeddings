% ------------------------------------------------------------------- %
% function REGO_1_global(name,D,seed,matfile)
%
% REGO-1 algorithm
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
% ------------------------------------------------------------------- %
function [f_out,x_out,d_out,nfuneval_out,t_emb_out,t_A_out,Q] = REGO_1_global(name,D,seed,matfile,varargin)

[filepart,~,~] = fileparts(pwd);
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
d = d_e;

tic;
A = randn(D,d);
t_A_rec = toc;
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

f_rec = fmin_red;
t_emb_rec = e;
d_rec = d;
x_rec = A*ymin_red+p;
nfuneval_rec = output_red.funcCount;

fprintf('Dimension is %d, previous cost %4.2e\n',d,f_rec);

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
