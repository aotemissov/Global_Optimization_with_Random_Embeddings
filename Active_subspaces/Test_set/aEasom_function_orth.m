% ------------------------------------------------------------- %
% aEasom_function_orth(xx,Q,D,dim,bounds,alpha)
%
% input:  xx     = input of the function
%         Q      = orthogonal matrix for rotating the function     
%         D      = dimension of the domain of the function
%         dim    = dimension of the effective subspace
%         bounds = bounds of the search domain of the function
% output: y      = output of the function
% ------------------------------------------------------------- %
function [y] = aEasom_function_orth(xx,Q,D,dim,bounds,alpha)

x = cell(D,1);
for i = 1:D
   x{i} = xx(i);
end

z = cell(dim,1);

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

z{1} = alpha*(z{1}-pi)+pi;
z{2} = alpha*(z{2}-pi)+pi;
fact1 = -cos(z{1})*cos(z{2});
fact2 = exp(-(z{1}-pi)^2-(z{2}-pi)^2);

y = fact1*fact2;

end


