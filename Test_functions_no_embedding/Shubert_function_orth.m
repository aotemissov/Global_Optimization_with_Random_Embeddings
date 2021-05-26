function [y] = Shubert_function_orth(yy,Q,D,dim,bounds)

y = cell(D,1);
for i = 1:D
   y{i} = yy(i);
end

z = cell(dim,1);
 
for i = 1:dim
    sum1 = 0;
     
    for j = 1:D
        sum1 = sum1 + Q(j,i).*y{j};
    end
    z{i} = sum1; 
end

for i = 1:dim
    z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
end

sum1 = 0;
sum2 = 0;

for i = 1:5
 sum1 = sum1 + i.*cos((i+1).*z{1}+i);
 sum2 = sum2 + i.*cos((i+1).*z{2}+i);
end

y = sum1.*sum2;

end


