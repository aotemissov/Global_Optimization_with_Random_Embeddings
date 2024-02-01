% ------------------------------------------------------------- %
% Goldstein_Price_function_orth_grad(xx,Q,D,dim,bounds)
%
% input:  xx     = input of the function
%         Q      = orthogonal matrix for rotating the function     
%         D      = dimension of the domain of the function
%         dim    = dimension of the effective subspace
%         bounds = bounds of the search domain of the function
% output: dy_val = gradient of the function
% ------------------------------------------------------------- %
function dy_val = Goldstein_Price_function_orth_grad(xx,Q,D,dim,bounds)

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
y =(1+(p+q+1).^2.*(19-14.*p+3.*p.^2-14.*q+6.*p.*q+3.*q.^2))...
.*(30+(2.*p-3.*q).^2.*(18-32.*p+12.*p.^2+48.*q-36.*p.*q+27.*q.^2));
dy = gradient(y, [p, q]);

p = z{1};
q = z{2};

dy_val = subs(dy);
dy_val = double(dy_val);
dy_val_0 = zeros(D,1);
dy_val_0(1:dim) = bounds_m*dy_val;
dy_val = Q*dy_val_0;
end
