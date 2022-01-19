function [value, fflag] = DIRECT_with_linear_constraints(x,name_of_function)

% This function is used in X-REGO experiments with DIRECT solver.
% The below code is a way of DIRECT to deal with linear constraints
% x - a point of interest
% name_of_function - name of the function f that is being tested

% if the point x is outside X then fflag is set to 1 and the value is set to 0
% if the point x is inside X then fflag is set to 0 (i.e. nothing to worry about)
% and value is set to f(x)

if(max(abs(x)) > 1)
    value = 0;
    fflag = 1;
else
    value = Test_set(x,name_of_function);
    fflag = 0;
end
end
