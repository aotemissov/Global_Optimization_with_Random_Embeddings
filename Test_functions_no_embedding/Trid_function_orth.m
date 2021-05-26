function [y] = Trid_function_orth(xx,Q,D,dim,bounds)

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

sum1 = (z{1}-1)^2;
sum2 = 0;

for i = 2:dim
	sum1 = sum1 + (z{i}-1)^2;
	sum2 = sum2 + z{i}*z{i-1};
end

y = sum1 - sum2;

end


