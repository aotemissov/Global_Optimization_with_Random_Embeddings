% ------------------------------------------------------------- %
% Hartmann6_function_orth_grad(yy,Q,D,dim,bounds)
%
% input:  xx     = input of the function
%         Q      = orthogonal matrix for rotating the function     
%         D      = dimension of the domain of the function
%         dim    = dimension of the effective subspace
%         bounds = bounds of the search domain of the function
% output: dy_val = gradient of the function
% ------------------------------------------------------------- %
function dy_val = Hartmann6_function_orth_grad(yy,Q,D,dim,bounds)

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
A = [10, 3, 17, 3.5, 1.7, 8;
     0.05, 10, 17, 0.1, 8, 14;
     3, 3.5, 1.7, 10, 17, 8;
     17, 8, 0.05, 10, 0.1, 14];
P = 10^(-4) * [1312, 1696, 5569, 124, 8283, 5886;
               2329, 4135, 8307, 3736, 1004, 9991;
               2348, 1451, 3522, 2883, 3047, 6650;
               4047, 8828, 8732, 5743, 1091, 381];

syms r1 r2 r3 r4 r5 r6
outer = 0;
for i = 1:4
	inner = A(i,1)*(r1-P(i,1))^2 + A(i,2)*(r2-P(i,2))^2 + A(i,3)*(r3-P(i,3))^2 ...
     + A(i,4)*(r4-P(i,4))^2 + A(i,5)*(r5-P(i,5))^2 + A(i,6)*(r6-P(i,6))^2;
	new = alpha(i) * exp(-inner);
	outer = outer + new;
end

y = -outer;
dy = gradient(y, [r1, r2, r3, r4, r5, r6]);

r1 = z{1};
r2 = z{2};
r3 = z{3};
r4 = z{4};
r5 = z{5};
r6 = z{6};

dy_val = subs(dy);
dy_val = double(dy_val);
dy_val_0 = zeros(D,1);
dy_val_0(1:dim) = bounds_m*dy_val;
dy_val = Q*dy_val_0;
end


