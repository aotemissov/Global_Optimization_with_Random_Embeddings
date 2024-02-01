% ------------------------------------------------------------- %
% Goldstein_Price_function_orth(xx,Q,D,dim,bounds)
%
% input:  xx     = input of the function
%         Q      = orthogonal matrix for rotating the function     
%         D      = dimension of the domain of the function
%         dim    = dimension of the effective subspace
%         bounds = bounds of the search domain of the function
% output: y      = output of the function
% ------------------------------------------------------------- %
function y = Goldstein_Price_function_orth(xx,Q,D,dim,bounds)

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

y =(1+(z{1}+z{2}+1).^2.*(19-14.*z{1}+3.*z{1}.^2-14.*z{2}+6.*z{1}.*z{2}+3.*z{2}.^2))...
.*(30+(2.*z{1}-3.*z{2}).^2.*(18-32.*z{1}+12.*z{1}.^2+48.*z{2}-36.*z{1}.*z{2}+27.*z{2}.^2));
