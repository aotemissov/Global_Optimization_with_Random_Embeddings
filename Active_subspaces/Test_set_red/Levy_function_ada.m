% ------------------------------------------------------------- %
% Levy_function_ada(yy,Q,A,D,d,dim,p,bounds)
%
% input:  yy     = optimal solution of reduced problem
%         Q      = orthogonal matrix for rotating the function  
%         A      = reduced matrix A
%         D      = dimension of the domain of the function
%         d      = dimension of the reduced problem
%         dim    = dimension of the effective subspace
%         p      = additional parameter p
%         bounds = bounds of the search domain of the function
% output: y      = output of the function
% ------------------------------------------------------------- %
function [y] = Levy_function_ada(yy,Q,A,D,d,dim,p,bounds)

y = cell(d,1);
for i = 1:d
   y{i} = yy(i);
end
 
x = cell(D,1);
for i = 1:D
    sum = 0;
    for j = 1 : d
       sum = sum + A(i,j)*y{j};
    end
    x{i} = sum + p(i);
end

z = cell(D,1);
 
for i = 1:dim
    sum1 = 0;
     
    for j = 1:D
        sum1 = sum1 + Q(j,i).*x{j};
    end
    z{i} = sum1; 
end

for i = 1:dim
    z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
end

term1 = (sin(pi*(1 + (z{1} - 1)/4)))^2;
term3 = ((1 + (z{dim} - 1)/4)-1)^2 * (1+(sin(2*pi*(1 + (z{dim} - 1)/4)))^2);

sum = 0;
for i = 1:(dim-1)
    new = ((1 + (z{i} - 1)/4)-1)^2 * (1+10*(sin(pi*(1 + (z{i} - 1)/4)+1))^2);
	sum = sum + new;
end

y = term1 + sum + term3;
end

