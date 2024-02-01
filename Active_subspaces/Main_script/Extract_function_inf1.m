% ------------------------------------------------------------------------ %
% function Extract_function_inf1(name)
%
% Provide information about the test functions.
%
% input:  name       = name of the test function
%         varargin   = set required effective dimension for Rosenbrock, 
%                      Levy or Trid; if you do not set one, the default
%                      dimension  will be used
% output: dim        = dimension of the effective subspace
%         true_min   = true global minimum of the function
%         tru_argmin = true argument of global minimum of the function
%         bounds     = bounds of the search domain of the function
% ------------------------------------------------------------------------ %
function [dim, true_min, true_argmin, bounds] = Extract_function_inf1(name, varargin)

switch name
    case 'Styblinski_Tang'
        dim = 8;
        true_min = -39.1661657*dim;
        true_argmin = -2.903534*ones(dim,1);
        bounds = [-5*ones(dim,1) 5*ones(dim,1)];
    case 'Rosenbrock'
        if isempty(varargin) == 0
            dim = varargin{1};
        else
            dim = 7;
        end
        true_min = 0;
        true_argmin = ones(dim,1);
        bounds = [-5*ones(dim,1) 10*ones(dim,1)];
    case 'Zettl'
        dim = 2;
        true_min = -0.003791;
        true_argmin = [-0.0299; 0];
        bounds = [-5*ones(dim,1) 5*ones(dim,1)];
    case 'aEasom'
        dim = 2;
        true_min = -1;
        true_argmin = [pi; pi];
        bounds = [-100*ones(dim,1) 100*ones(dim,1)];
    case 'Trid'
        if isempty(varargin) == 0
            dim = varargin{1};
        else
            dim = 5;
        end
        true_min = -dim*(dim+4)*(dim-1)/6;
        true_argmin = zeros(dim,1);
        for i = 1:dim
            true_argmin(i) = i*(dim+1-i);
        end
        bounds = [-dim^2*ones(dim,1) dim^2*ones(dim,1)];
    case 'Beale'
        dim = 2;
        true_min = 0;
        true_argmin = [3; 0.5];
        bounds = [-4.5*ones(dim,1) 4.5*ones(dim,1)];
    case 'Levy'
        if isempty(varargin) == 0
            dim = varargin{1};
        else
            dim = 6;
        end
        true_min = 0;
        true_argmin = ones(dim,1);
        bounds = [-10*ones(dim,1) 10*ones(dim,1)];
    case 'Brent'
        dim = 2;
        true_min = 0;
        true_argmin = [-10; -10];
        bounds = [-10 10; -10 10];
    case 'Branin'
        dim = 2;
        true_min = 0.397887;
        true_argmin = [-pi pi 9.42478; 12.275 2.275 2.475];
        bounds = [-5 10; 0 15];
    case 'Goldstein_Price'
        dim = 2;
        true_min = 3;
        true_argmin = [0; -1];
        bounds = [-2*ones(dim,1) 2*ones(dim,1)];
    case 'Hartmann3'
        dim = 3;
        true_min = -3.86278;
        true_argmin = [0.114614; 0.555649; 0.852547];
        bounds = [0*ones(dim,1) ones(dim,1)];
    case 'Hartmann6'
        dim = 6;
        true_min = -3.32237;
        true_argmin = [0.20169; 0.150011; 0.476874; 0.275332; 0.311652; 0.6573];
        bounds = [0*ones(dim,1) ones(dim,1)];
    case 'Shekel5'
        dim = 4;
        true_min = -10.1532;
        true_argmin = [4;4;4;4];
        bounds = [0*ones(dim,1) 10*ones(dim,1)];
    case 'Shekel7'
        dim = 4;
        true_min = -10.4029;
        true_argmin = [4;4;4;4];
        bounds = [0*ones(dim,1) 10*ones(dim,1)];
    case 'Shekel10'
        dim = 4;
        true_min = -10.5364;
        true_argmin = [4;4;4;4];
        bounds = [0*ones(dim,1) 10*ones(dim,1)];
    case 'Shubert'
        dim = 2;
        true_min = -186.7309;
        true_argmin = [-7.08350658  4.85805691 -7.08350658 -7.70831382 -1.42512845 -0.80032121 -1.42512844 -7.08350639 -7.70831354  5.48286415  5.48286415  4.85805691 -7.70831354 -0.80032121 -1.42512845  5.48286415  4.85805691 -0.80032121;
            4.85805691 -7.08350658 -7.70831382 -7.08350658 -0.80032121 -1.42512845 -7.08350639 -1.42512844  5.48286415 -7.70831354  4.85805691  5.48286415 -0.80032121 -7.70831354  5.48286415 -1.42512845 -0.80032121  4.85805691];
        bounds = [-10*ones(dim,1) 10*ones(dim,1)];
    case 'Camel'
        dim = 2;
        true_min = -1.0316;
        true_argmin = [0.0898 -0.0898; -0.7126 0.7126];
        bounds = [-3 3; -2 2];
end
end

