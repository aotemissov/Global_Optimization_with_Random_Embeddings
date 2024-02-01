% ------------------------------------------------------------- %
% Branin_function_orth_grad(yy,Q,D,dim,bounds)
%
% input:  xx     = input of the function
%         Q      = orthogonal matrix for rotating the function     
%         D      = dimension of the domain of the function
%         dim    = dimension of the effective subspace
%         bounds = bounds of the search domain of the function
% output: dy_val = gradient of the function
% ------------------------------------------------------------- %
function dy_val = Branin_function_orth_grad(yy,Q,D,dim,bounds)

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

 bounds_m = zeros(dim,dim);
for i = 1:dim
    bounds_m(i,i) = (bounds(i,2)-bounds(i,1))/2;
end
  
syms p q
term1 = a * (q - b*p^2 + c*p - r)^2;
term2 = s*(1-t)*cos(p);

y = term1 + term2 + s;
dy = gradient(y, [p, q]);

p = z{1};
q = z{2};

dy_val = subs(dy);
dy_val = double(dy_val);
dy_val_0 = zeros(D,1);
dy_val_0(1:dim) = bounds_m*dy_val;
dy_val = Q*dy_val_0;
end

