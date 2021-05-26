function [y] = Bukin_N6_function_orth(xx,Q,D,dim,bounds)

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
 
term1 = 100 * sqrt(abs(z{2} - 0.01*z{1}^2));
term2 = 0.01 * abs(z{1}+10);

y = term1 + term2;

end
