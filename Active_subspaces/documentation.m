% ------------------------------------------------------------------------- %
% Routine for using the code
%   * set a folder named Results
%   * run the main script .mat file in the Main_script folder
%   * run the corresponding figure .mat file in the Plots folder
% Notice
%   * Functions that could be tested on Knitro for all the algorithms are 
%     {'Beale','Branin','Brent','Camel','Goldstein_Price','Hartmann3',
%     'Hartmann6','Levy','Rosenbrock','Shekel5','Shekel7','Shekel10',
%     'Shubert','Styblinski_Tang','Trid','Zettl'}, which excluding the 
%     aEasom function. If one want to test the  aEasom function, an extra 
%     aEasom_function_ada.m function needs to be written and placed in the 
%     Test_set_red folder.
%   * One could add their own function for testing by first adding the
%     corresponding xxx_function_orth.m, xxx_function_orth_grad.m,
%     xxx_function_ada.m in corresponding folders and information of this
%     function in the Extract_function_inf1.m. Then, adding these functions 
%     in the algorithm you want to test on.
%
% Replicate the results in paper
% Experiment 1
%   * problems = {'Beale','Branin','Brent','Camel','Goldstein_Price',...
%                 'Hartmann3','Hartmann6','Levy','Rosenbrock','Shekel5',...
%                 'Shekel7','Shekel10','Shubert','Styblinski_Tang','Trid',...
%                 'Zettl'};
%   * Ds = [100,1000] (D=100 or D=1000);
%   * seeds = [0,1,2] (seed = 0,1 or 2);
%   * run multiple main_script_test_global(D,seed,problems) with
%     different values of dim and seed
%   * run figure_perfprof(Ds, seeds, problems)
% Experiment 2
%   * problems = {'Rosenbrock','Trid'};
%   * dims = [10,20,50];
%   * D = 100;
%   * seeds = [0,1,2] (seed = 0,1 or 2);
%   * run multiple main_script_test_global_change_d(D,seed,problems,dims) 
%     with different values of dim, D and seed
%   * run figure_change_d(D, seeds, problems,dims)
% Experiment 3
%   * problems = {'Rosenbrock','Hartmann3','aEasom'};
%   * Ds = [100, 1000];
%   * Ms = 1:100;
%   * seeds = [0,1,2,3,4];
%   * alphas = [0.1,0.5,1];
%   * run main_script_test_sampcomp(Ds, Ms, seeds, problems, alphas)
%   * run figure_sampcomp(Ds, Ms, seeds, problems)
%
%   * Ds = [100,1000];
%   * Ms = 1:100
%   * seeds = [0,1,2,3,4];
%   * alphas = 0.1:0.1:1
%   * run main_script_test_sampcomp_aEasom(Ds, Ms, seeds, alphas)
%   * run figure_sampcomp_aEasom(Ds, Ms, seeds, alphas)
% ------------------------------------------------------------------------- %