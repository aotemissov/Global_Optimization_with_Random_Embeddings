function [y] = Perm_function_orth(xx,Q,D,dim,bounds)

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

outer = 0;

for i = 1:dim
    inner = 0;
    for j = 1:dim
        inner = inner + (j^i+0.5)*((z{j}/j).^i-1);
    end
    outer = outer + inner.^2;
end

y = outer;
end



