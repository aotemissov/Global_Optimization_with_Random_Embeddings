% ------------------------------------------------------------- %
% Hartmann3_function_orth_grad(yy,Q,D,dim,bounds)
%
% input:  xx     = input of the function
%         Q      = orthogonal matrix for rotating the function     
%         D      = dimension of the domain of the function
%         dim    = dimension of the effective subspace
%         bounds = bounds of the search domain of the function
% output: dy_val = gradient of the function
% ------------------------------------------------------------- %
function dy_val = Hartmann3_function_orth_grad(yy,Q,D,dim,bounds)

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
 
alpha = [1.0, 1.2, 3.0, 3.2]';
A = [3.0, 10, 30;
     0.1, 10, 35;
     3.0, 10, 30;
     0.1, 10, 35];
P = 10^(-4) * [3689, 1170, 2673;
               4699, 4387, 7470;
               1091, 8732, 5547;
               381, 5743, 8828];

syms r p q
outer = 0;
for i = 1:4
	inner = A(i,1)*(r-P(i,1))^2 + A(i,2)*(p-P(i,2))^2 + A(i,3)*(q-P(i,3))^2;
	new = alpha(i) * exp(-inner);
	outer = outer + new;
end

y = -outer;
dy = gradient(y, [r, p, q]);

r = z{1};
p = z{2};
q = z{3};

dy_val = subs(dy);
dy_val = double(dy_val);
dy_val_0 = zeros(D,1);
dy_val_0(1:dim) = bounds_m*dy_val;
dy_val = Q*dy_val_0;
end

