% ------------------------------------------------------------- %
% Shekel5_function_orth_grad(yy,Q,D,dim,bounds)
%
% input:  xx     = input of the function
%         Q      = orthogonal matrix for rotating the function     
%         D      = dimension of the domain of the function
%         dim    = dimension of the effective subspace
%         bounds = bounds of the search domain of the function
% output: dy_val = gradient of the function
% ------------------------------------------------------------- %
function dy_val = Shekel5_function_orth_grad(yy,Q,D,dim,bounds)

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

b = 0.1 * [1, 2, 2, 4, 4, 6, 3, 7, 5, 5]';
C = [4, 1, 8, 6, 3, 2, 5, 8, 6, 7;
     4, 1, 8, 6, 7, 9, 5, 1, 2, 3.6;
     4, 1, 8, 6, 3, 2, 3, 8, 6, 7;
     4, 1, 8, 6, 7, 9, 3, 1, 2, 3.6];

syms r1 r2 r3 r4
y = 0;
for i = 1:5
	dy1 = (r1-C(1,i))^2 + (r2-C(2,i))^2 + (r3-C(3,i))^2 + (r4-C(4,i))^2;
	y = y + 1/(dy1+b(i));
end

y = -y;
dy = gradient(y, [r1, r2, r3, r4]);

r1 = z{1};
r2 = z{2};
r3 = z{3};
r4 = z{4};

dy_val = subs(dy);
dy_val = double(dy_val);
dy_val_0 = zeros(D,1);
dy_val_0(1:dim) = bounds_m*dy_val;
dy_val = Q*dy_val_0;
end


