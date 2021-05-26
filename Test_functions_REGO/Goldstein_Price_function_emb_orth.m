function [y] = Golden_Price_function_emb_orth(yy,Q,A,D,d,dim,bounds)

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

y =(1+(z{1}+z{2}+1).^2.*(19-14.*z{1}+3.*z{1}.^2-14.*z{2}+6.*z{1}.*z{2}+3.*z{2}.^2))...
.*(30+(2.*z{1}-3.*z{2}).^2.*(18-32.*z{1}+12.*z{1}.^2+48.*z{2}-36.*z{1}.*z{2}+27.*z{2}.^2));

end


