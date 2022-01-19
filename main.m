function main(framework,name_of_solver,list_of_functions)
%This code is the stating point for running the REGO and XREGO
%experiments. 

%framework - choose the framework you want to test, i.e., 'no embedding_vs_REGO', 'REGO', 'AREGO'
%name_of_solver - choose the solver you want to test with, e.g., DIRECT, BARON, KNITRO
%list_of_functions - a text file that contains a list of functions that the user would like to solve,
%list_of_functions must be a column of strings, e.g., ["Beale_10"; "Hartmann3_100"; ...]

warning('off', 'all');
addpath(genpath('/home/otemissov/matlab/github'));

how_many_functions = size(list_of_functions,1); %number of functions to be solved

global rotation_matrices
rotation_matrices = load('Matrices_Q.mat'); %load matrices Q used to rotate the functions before solving them

Results = struct; %create a structure arrray where we will save our results
switch framework
    case 'no_embedding_vs_REGO'
        for iterate_function = 1:how_many_functions
            name_of_function = list_of_functions(iterate_function,:);
            Results = solvers_no_emb_vs_REGO(char(name_of_function),name_of_solver,Results);
        end
    case 'no_embedding_vs_XREGO'
        for iterate_function = 1:how_many_functions
            name_of_function = list_of_functions(iterate_function,:);
            Results = solvers_no_emb_vs_XREGO(char(name_of_function),name_of_solver,Results);
        end
    case 'REGO'
        for iterate_function = 1:how_many_functions
            name_of_function = list_of_functions(iterate_function,:);
            Results = solvers_REGO(char(name_of_function),name_of_solver,Results);
        end
    case {'AREGO','NREGO','LAREGO','LNREGO'}
        for iterate_function = 1:how_many_functions
            name_of_function = list_of_functions(iterate_function,:);
            Results = solvers_XREGO(char(name_of_function),framework,name_of_solver,Results);
        end
    otherwise
        disp('No such (framework, solver) pair exists. Check for spelling errors.')
end
%save Results in a mat file
file_struct = strcat('Results_',framework,'_',name_of_solver,'.mat');
save(file_struct,'-struct','Results');

end
