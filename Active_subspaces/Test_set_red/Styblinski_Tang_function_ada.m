% ------------------------------------------------------------- %
% Styblinski_Tang_function_ada(yy,Q,A,D,d,dim,p,bounds)
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
function [y] = Styblinski_Tang_function_ada(yy,Q,A,D,d,dim,p,bounds)

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

sum = 0;
for i = 1:dim
	new = z{i}^4 - 16*z{i}^2 + 5*z{i};
	sum = sum + new;
end

y = sum/2;
end


