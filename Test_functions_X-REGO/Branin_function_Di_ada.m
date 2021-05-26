function [value, fflag] = Branin_function_Di_ada(yy,Q,A,D,d,dim,current_x,bounds)

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
    
    a = 1;
    b = 5.1/(4*pi^2);
    c = 5/pi;
    r = 6;
    s = 10;
    t = 1/(8*pi);
    
    term1 = a * (z{2} - b*z{1}^2 + c*z{1} - r)^2;
    term2 = s*(1-t)*cos(z{1});
    
    value = term1 + term2 + s;
    fflag = 0;
%     if (~isnan(f_optimal))
%         
%         if (yy > f_optimal)
%             fflag = 1;
%             value = 0;
%         else
%             fflag = 0;
%             value = yy;
%         end
%     else
%         
%         value = yy;
%         fflag = 0;
%     end
end
return;


