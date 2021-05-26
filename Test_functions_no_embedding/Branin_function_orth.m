function [y] = Branin_function_orth(yy,Q,D,dim,bounds)

a = 1;
b = 5.1/(4*pi^2);
c = 5/pi;
r = 6;
s = 10;
t = 1/(8*pi);

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
  
term1 = a * (z{2} - b*z{1}^2 + c*z{1} - r)^2;
term2 = s*(1-t)*cos(z{1});

y = term1 + term2 + s;

end

