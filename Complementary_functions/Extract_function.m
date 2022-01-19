function [dim, min, argmin, bounds] = Extract_function(name)
% This function extacts information about the low-dimensional counterpart 
% of the high-dimensional function requested.

% name - name of the high-dimensional function about whom information is 
% requested, e.g. 'Branin_100'

% Information such as effective dimension, global minima, global minimizers 
% and search domain are provided upon request

switch name
    case 'Styblinski_Tang'
        dim = 4; % dimension
        min = -39.16599*dim; % global minimum, i.e., f(x^*)
        argmin = -2.903534*ones(dim,1); % global minimizer, i.e., x^*
        bounds = [-5*ones(dim,1) 5*ones(dim,1)]; % bounds where the function is typically optimized over
    case 'Bukin_N6'
        dim = 2;
        min = 0;
        argmin = [-10; 1];
        bounds = [-15 -5; -3 3];
    case 'Rosenbrock'
        dim = 3;
        min = 0;
        argmin = ones(dim,1);
        bounds = [-5*ones(dim,1) 10*ones(dim,1)];
    case 'Zettl'
        dim = 2;
        min = -0.003791;
        argmin = [-0.0299; 0];
        bounds = [-5*ones(dim,1) 5*ones(dim,1)];
    case 'Easom'
        dim = 2;
        min = -1;
        argmin = [pi; pi];
        bounds = [-100*ones(dim,1) 100*ones(dim,1)];
    case 'Trid'
        dim = 5;
        min = -dim*(dim+4)*(dim-1)/6;
        argmin = zeros(dim,1);
        for i = 1:dim
            argmin(i) = i*(dim+1-i);
        end
        bounds = [-dim^2*ones(dim,1) dim^2*ones(dim,1)];
    case 'Beale'
        dim = 2;
        min = 0;
        argmin = [3; 0.5];
        bounds = [-4.5*ones(dim,1) 4.5*ones(dim,1)];
    case 'Levy'
        dim = 4;
        min = 0;
        argmin = ones(dim,1);
        bounds = [-10*ones(dim,1) 10*ones(dim,1)];
    case 'Perm'
        dim = 4;
        min = 0;
        argmin = 1:1:dim;
        argmin = argmin';
        bounds = [-dim*ones(dim,1) dim*ones(dim,1)];
    case 'Brent'
        dim = 2;
        min = 0;
        argmin = [-10; -10];
        bounds = [-10 10; -10 10];
    case 'Branin'
        dim = 2;
        min = 0.397887;
        argmin = [-pi pi 9.42478; 12.275 2.275 2.475];
        bounds = [-5 10; 0 15];
    case 'Goldstein_Price'
        dim = 2;
        min = 3;
        argmin = [0; -1];
        bounds = [-2*ones(dim,1) 2*ones(dim,1)];
    case 'Hartmann3'
        dim = 3;
        min = -3.86278;
        argmin = [0.114614; 0.555649; 0.852547];
        bounds = [0*ones(dim,1) ones(dim,1)];
    case 'Hartmann6'
        dim = 6;
        min = -3.32237;
        argmin = [0.20169; 0.150011; 0.476874; 0.275332; 0.311652; 0.6573];
        bounds = [0*ones(dim,1) ones(dim,1)];
    case 'Shekel5'
        dim = 4;
        min = -10.1532;
        argmin = [4;4;4;4];
        bounds = [0*ones(dim,1) 10*ones(dim,1)];
    case 'Shekel7'
        dim = 4;
        min = -10.4029;
        argmin = [4;4;4;4];
        bounds = [0*ones(dim,1) 10*ones(dim,1)];
    case 'Shekel10'
        dim = 4;
        min = -10.5364;
        argmin = [4;4;4;4];
        bounds = [0*ones(dim,1) 10*ones(dim,1)];
    case 'Shubert'
        dim = 2;
        min = -186.7309;
        argmin = [-7.08350658  4.85805691 -7.08350658 -7.70831382 -1.42512845 -0.80032121 -1.42512844 -7.08350639 -7.70831354  5.48286415  5.48286415  4.85805691 -7.70831354 -0.80032121 -1.42512845  5.48286415  4.85805691 -0.80032121;
            4.85805691 -7.08350658 -7.70831382 -7.08350658 -0.80032121 -1.42512845 -7.08350639 -1.42512844  5.48286415 -7.70831354  4.85805691  5.48286415 -0.80032121 -7.70831354  5.48286415 -1.42512845 -0.80032121  4.85805691];
        bounds = [-10*ones(dim,1) 10*ones(dim,1)];
    case 'Camel'
        dim = 2;
        min = -1.0316;
        argmin = [0.0898 -0.0898; -0.7126 0.7126];
        bounds = [-3 3; -2 2];
end
end
