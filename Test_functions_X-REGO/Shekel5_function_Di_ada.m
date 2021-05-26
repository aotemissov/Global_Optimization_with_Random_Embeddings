function [value, fflag] = Shekel5_function_Di_ada(yy,Q,A,D,d,dim,current_x,bounds)

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
    
    b = 0.1 * [1, 2, 2, 4, 4, 6, 3, 7, 5, 5]';
    C = [4, 1, 8, 6, 3, 2, 5, 8, 6, 7;
        4, 1, 8, 6, 7, 9, 5, 1, 2, 3.6;
        4, 1, 8, 6, 3, 2, 3, 8, 6, 7;
        4, 1, 8, 6, 7, 9, 3, 1, 2, 3.6];
    
    outer = 0;
    for i = 1:5
        inner = 0;
        for j = 1:4
            inner = inner + (z{j}-C(j,i))^2;
        end
        outer = outer + 1/(inner+b(i));
    end
    
    value = -outer;

    fflag = 0;
end
return;


