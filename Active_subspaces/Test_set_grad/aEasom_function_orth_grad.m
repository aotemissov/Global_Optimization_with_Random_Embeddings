% ------------------------------------------------------------- %
% aEasom_function_orth_grad(xx,Q,D,dim,bounds,alpha)
%
% input:  xx     = input of the function
%         Q      = orthogonal matrix for rotating the function     
%         D      = dimension of the domain of the function
%         dim    = dimension of the effective subspace
%         bounds = bounds of the search domain of the function
% output: dy_val = gradient of the function
% ------------------------------------------------------------- %
function dy_val = aEasom_function_orth_grad(xx,Q,D,dim,bounds,alpha)

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

bounds_m = zeros(dim,dim);
for i = 1:dim
    bounds_m(i,i) = (bounds(i,2)-bounds(i,1))/2;
end

syms p q
fact1 = -cos(alpha*(p-pi)+pi)*cos(alpha*(q-pi)+pi);
fact2 = exp(-alpha^2*((p-pi)^2+(q-pi)^2));

y = fact1*fact2;
dy = gradient(y, [p, q]);

p = z{1};
q = z{2};

dy_val = subs(dy);
dy_val = double(dy_val);
dy_val_0 = zeros(D,1);
dy_val_0(1:dim) = bounds_m*dy_val;
dy_val = Q*dy_val_0;
end


