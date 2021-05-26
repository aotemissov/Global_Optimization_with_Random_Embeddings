function [value, fflag] = Hartmann3_function_Di_ada(yy,Q,A,D,d,dim,current_x,bounds)

delta = 1;

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
    x{i} = sum + current_x(i);
end

lin_con = 1;
for i = 1:D
    if(abs(x{i}) > delta)
        lin_con = 0;
	break;
    end
end

if (lin_con == 0)
    value = 0;
    fflag = 1;
else
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
    
    alpha = [1.0, 1.2, 3.0, 3.2]';
    A = [3.0, 10, 30;
        0.1, 10, 35;
        3.0, 10, 30;
        0.1, 10, 35];
    P = 10^(-4) * [3689, 1170, 2673;
        4699, 4387, 7470;
        1091, 8732, 5547;
        381, 5743, 8828];
    
    outer = 0;
    for i = 1:4
        inner = 0;
        for j = 1:3
            inner = inner + A(i,j)*(z{j}-P(i,j))^2;
        end
        new = alpha(i) * exp(-inner);
        outer = outer + new;
    end
    
    value = -outer;

    fflag = 0;
end
return;


