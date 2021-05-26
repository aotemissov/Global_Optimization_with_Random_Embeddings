function [y] = Rosenbrock_function_orth(xx,Q,D,dim,bounds)

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

sum = 0;

for i = 1:(dim-1)
	new = 100*(z{i+1}-z{i}^2)^2 + (z{i}-1)^2;
	sum = sum + new;
end

y = sum;

end


