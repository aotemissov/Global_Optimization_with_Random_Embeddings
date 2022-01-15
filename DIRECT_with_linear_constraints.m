function [value, fflag] = DIRECT_with_linear_constraints(x,name_of_function)
if(max(abs(x)) > 1)
    value = 0;
    fflag = 1;
else
    value = Test_set(x,name_of_function);
    fflag = 0;
end
end