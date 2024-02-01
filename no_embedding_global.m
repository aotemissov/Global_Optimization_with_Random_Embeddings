% ------------------------------------------------------------------- %
% function no_embedding_global(name,D,seed,matfile)
%
% no embedding algorithm
%
% input:  name         = name of the test function
%         D            = dimension of the domain of the function
%         seed         = The option of seed set
%         matfile      = name of the .mat file to save the results
% output: f_out        = global minimum of the function
%         x_out        = argument of global minimum of the function
%         d_out        = estimted dimension of effective subspace
%         nfuneval_out = total number of function evaluations
%         t_out      = total CPU time
%         Q            = orthogonal matrix for rotating the function
% ------------------------------------------------------------------- %
function [f_out,x_out,nfuneval_out,t_out,Q] = no_embedding_global(name,D,seed,matfile,varargin)

[filepart,~,~] = fileparts(pwd);
loadpath = fullfile(filepart,'Test_set');
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

f_rec = zeros(1,2);
x_rec = cell(1,2);
t_rec = zeros(1,2);
nfuneval_rec = zeros(1,2);

switch name
    case 'Beale'
        fun = @(x) Beale_function_orth(x,Q,D,d_e,bounds);
    case 'Branin'
        fun = @(x) Branin_function_orth(x,Q,D,d_e,bounds);
    case 'Brent'
        fun = @(x) Brent_function_orth(x,Q,D,d_e,bounds);
    case 'Camel'
        fun = @(x) Camel_function_orth(x,Q,D,d_e,bounds);
    case 'Goldstein_Price'
        fun = @(x) Goldstein_Price_function_orth(x,Q,D,d_e,bounds);
    case 'Hartmann3'
        fun = @(x) Hartmann3_function_orth(x,Q,D,d_e,bounds);
    case 'Hartmann6'
        fun = @(x) Hartmann6_function_orth(x,Q,D,d_e,bounds);
    case 'Levy'
        fun = @(x) Levy_function_orth(x,Q,D,d_e,bounds);
    case 'Rosenbrock'
        fun = @(x) Rosenbrock_function_orth(x,Q,D,d_e,bounds);
    case 'Shekel5'
        fun = @(x) Shekel5_function_orth(x,Q,D,d_e,bounds);
    case 'Shekel7'
        fun = @(x) Shekel7_function_orth(x,Q,D,d_e,bounds);
    case 'Shekel10'
        fun = @(x) Shekel10_function_orth(x,Q,D,d_e,bounds);
    case 'Shubert'
        fun = @(x) Shubert_function_orth(x,Q,D,d_e,bounds);
    case 'Styblinski_Tang'
        fun = @(x) Styblinski_Tang_function_orth(x,Q,D,d_e,bounds);
    case 'Trid'
        fun = @(x) Trid_function_orth(x,Q,D,d_e,bounds);
    case 'Zettl'
        fun = @(x) Zettl_function_orth(x,Q,D,d_e,bounds);
end

f_rec(1) = fun(p);
x_rec{1} = p;

file_option =strcat('Option_files/options_global_seed_',num2str(seed),'.opt');
tic;
[xmin_red,fmin_red,~,output_red,~,~,~] = knitro_nlp(fun,p,[],[],[],[],[],[],[],[],options,file_option);
e = toc;

f_rec(2) = fmin_red;
t_rec(2) = e;
x_rec{2} = xmin_red;
nfuneval_rec(2) = output_red.funcCount;

[f_out,indx] = min(f_rec);
x_out = x_rec{indx};
nfuneval_out = sum(nfuneval_rec);
t_out = sum(t_rec);

fprintf('Dimension is %d, previous cost %4.2e\n',D,f_out);

if isempty(varargin) == 0
    name = strcat(name, num2str(d_e));
end

if (exist(matfile,'file') == 2)
    DATA = load(matfile);
    DATA.(strcat(name,'_',num2str(D),'_x')) = x_rec;
    DATA.(strcat(name,'_',num2str(D),'_t')) = t_rec;
    DATA.(strcat(name,'_',num2str(D),'_f')) = f_rec;
    DATA.(strcat(name,'_',num2str(D),'_nfuneval')) = nfuneval_rec;
    DATA.(strcat(name,'_',num2str(D),'_Q')) = Q(:);
    save(matfile, '-struct','DATA','-append');
else
    DATA = struct;
    DATA.(strcat(name,'_',num2str(D),'_x')) = x_rec;
    DATA.(strcat(name,'_',num2str(D),'_t')) = t_rec;
    DATA.(strcat(name,'_',num2str(D),'_f')) = f_rec;
    DATA.(strcat(name,'_',num2str(D),'_nfuneval')) = nfuneval_rec;
    DATA.(strcat(name,'_',num2str(D),'_Q')) = Q(:);
    save(matfile,'-struct','DATA');
end
diary off;

end

