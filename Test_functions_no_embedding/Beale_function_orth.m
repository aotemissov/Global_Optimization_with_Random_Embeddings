function [y] = Beale_function_orth(xx,Q,D,dim,bounds)
 
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

term1 = (1.5 - z{1} + z{1}*z{2})^2;
term2 = (2.25 - z{1} + z{1}*z{2}^2)^2;
term3 = (2.625 - z{1} + z{1}*z{2}^3)^2;

y = term1 + term2 + term3;
end


