function [y] = Trid_function_emb_orth(yy,Q,A,D,d,dim,bounds)

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
    x{i} = sum;
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

sum1 = (z{1}-1)^2;
sum2 = 0;

for i = 2:dim
	sum1 = sum1 + (z{i}-1)^2;
	sum2 = sum2 + z{i}*z{i-1};
end

y = sum1 - sum2;

end


