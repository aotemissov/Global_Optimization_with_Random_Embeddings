function [y] = Test_set(xx,name_of_function)
% this function contains the 
%
global rotation_matrices

switch name_of_function
    case 'Beale_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        term1 = (1.5 - z{1} + z{1}*z{2})^2;
        term2 = (2.25 - z{1} + z{1}*z{2}^2)^2;
        term3 = (2.625 - z{1} + z{1}*z{2}^3)^2;
        
        y = term1 + term2 + term3;
        
    case 'Beale_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        term1 = (1.5 - z{1} + z{1}*z{2})^2;
        term2 = (2.25 - z{1} + z{1}*z{2}^2)^2;
        term3 = (2.625 - z{1} + z{1}*z{2}^3)^2;
        
        y = term1 + term2 + term3;
        
    case 'Beale_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        term1 = (1.5 - z{1} + z{1}*z{2})^2;
        term2 = (2.25 - z{1} + z{1}*z{2}^2)^2;
        term3 = (2.625 - z{1} + z{1}*z{2}^3)^2;
        
        y = term1 + term2 + term3;
        
    case 'Branin_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        
        y = term1 + term2 + s;
        
    case 'Branin_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        
        y = term1 + term2 + s;
        
    case 'Branin_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        
        y = term1 + term2 + s;
        
    case 'Brent_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        y = (z{1}+10)^2+(z{2}+10)^2+exp(-z{1}^2-z{2}^2);
        
    case 'Brent_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        y = (z{1}+10)^2+(z{2}+10)^2+exp(-z{1}^2-z{2}^2);
        
    case 'Brent_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        y = (z{1}+10)^2+(z{2}+10)^2+exp(-z{1}^2-z{2}^2);
        
    case 'Bukin_N6_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        idx = idx(end);
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        term1 = 100 * sqrt(abs(z{2} - 0.01*z{1}^2));
        term2 = 0.01 * abs(z{1}+10);
        
        y = term1 + term2;
        
    case 'Bukin_N6_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        idx = idx(end);
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        term1 = 100 * sqrt(abs(z{2} - 0.01*z{1}^2));
        term2 = 0.01 * abs(z{1}+10);
        
        y = term1 + term2;
        
    case 'Bukin_N6_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        idx = idx(end);
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        term1 = 100 * sqrt(abs(z{2} - 0.01*z{1}^2));
        term2 = 0.01 * abs(z{1}+10);
        
        y = term1 + term2;
        
    case 'Camel_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        y = (4-2.1.*z{1}.^2+z{1}.^4./3).*z{1}.^2+z{1}.*z{2}+(-4+4.*z{2}.^2).*z{2}.^2;
        
    case 'Camel_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        y = (4-2.1.*z{1}.^2+z{1}.^4./3).*z{1}.^2+z{1}.*z{2}+(-4+4.*z{2}.^2).*z{2}.^2;
        
    case 'Camel_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        y = (4-2.1.*z{1}.^2+z{1}.^4./3).*z{1}.^2+z{1}.*z{2}+(-4+4.*z{2}.^2).*z{2}.^2;
        
    case 'Easom_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        fact1 = -cos(z{1})*cos(z{2});
        fact2 = exp(-(z{1}-pi)^2-(z{2}-pi)^2);
        
        y = fact1*fact2;
        
    case 'Easom_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        fact1 = -cos(z{1})*cos(z{2});
        fact2 = exp(-(z{1}-pi)^2-(z{2}-pi)^2);
        
        y = fact1*fact2;
        
    case 'Easom_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        fact1 = -cos(z{1})*cos(z{2});
        fact2 = exp(-(z{1}-pi)^2-(z{2}-pi)^2);
        
        y = fact1*fact2;
        
    case 'Goldstein_Price_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        idx = idx(end);
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        y = (1+(z{1}+z{2}+1).^2.*(19-14.*z{1}+3.*z{1}.^2-14.*z{2}+6.*z{1}.*z{2}+3.*z{2}.^2))...
            .*(30+(2.*z{1}-3.*z{2}).^2.*(18-32.*z{1}+12.*z{1}.^2+48.*z{2}-36.*z{1}.*z{2}+27.*z{2}.^2));
        
    case 'Goldstein_Price_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        idx = idx(end);
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        y = (1+(z{1}+z{2}+1).^2.*(19-14.*z{1}+3.*z{1}.^2-14.*z{2}+6.*z{1}.*z{2}+3.*z{2}.^2))...
            .*(30+(2.*z{1}-3.*z{2}).^2.*(18-32.*z{1}+12.*z{1}.^2+48.*z{2}-36.*z{1}.*z{2}+27.*z{2}.^2));
        
    case 'Goldstein_Price_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        idx = idx(end);
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        y = (1+(z{1}+z{2}+1).^2.*(19-14.*z{1}+3.*z{1}.^2-14.*z{2}+6.*z{1}.*z{2}+3.*z{2}.^2))...
            .*(30+(2.*z{1}-3.*z{2}).^2.*(18-32.*z{1}+12.*z{1}.^2+48.*z{2}-36.*z{1}.*z{2}+27.*z{2}.^2));
        
    case 'Hartmann3_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        
        y = -outer;
        
    case 'Hartmann3_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        
        y = -outer;
        
    case 'Hartmann3_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        
        y = -outer;
        
    case 'Hartmann6_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
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
        
        outer = 0;
        for i = 1:4
            inner = 0;
            for j = 1:6
                inner = inner + A(i,j)*(z{j}-P(i,j))^2;
            end
            new = alpha(i) * exp(-inner);
            outer = outer + new;
        end
        
        y = -outer;
        
    case 'Hartmann6_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
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
        
        outer = 0;
        for i = 1:4
            inner = 0;
            for j = 1:6
                inner = inner + A(i,j)*(z{j}-P(i,j))^2;
            end
            new = alpha(i) * exp(-inner);
            outer = outer + new;
        end
        
        y = -outer;
        
    case 'Hartmann6_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
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
        
        outer = 0;
        for i = 1:4
            inner = 0;
            for j = 1:6
                inner = inner + A(i,j)*(z{j}-P(i,j))^2;
            end
            new = alpha(i) * exp(-inner);
            outer = outer + new;
        end
        
        y = -outer;
        
    case 'Levy_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        term1 = (sin(pi*(1 + (z{1} - 1)/4)))^2;
        term3 = ((1 + (z{4} - 1)/4)-1)^2 * (1+(sin(2*pi*(1 + (z{4} - 1)/4)))^2);
        
        sum = 0;
        
        for i = 1:3
            new = ((1 + (z{i} - 1)/4)-1)^2 * (1+10*(sin(pi*(1 + (z{i} - 1)/4)+1))^2);
            sum = sum + new;
        end
        
        y = term1 + sum + term3;
        
    case 'Levy_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        term1 = (sin(pi*(1 + (z{1} - 1)/4)))^2;
        term3 = ((1 + (z{4} - 1)/4)-1)^2 * (1+(sin(2*pi*(1 + (z{4} - 1)/4)))^2);
        
        sum = 0;
        
        for i = 1:3
            new = ((1 + (z{i} - 1)/4)-1)^2 * (1+10*(sin(pi*(1 + (z{i} - 1)/4)+1))^2);
            sum = sum + new;
        end
        
        y = term1 + sum + term3;
        
    case 'Levy_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        term1 = (sin(pi*(1 + (z{1} - 1)/4)))^2;
        term3 = ((1 + (z{4} - 1)/4)-1)^2 * (1+(sin(2*pi*(1 + (z{4} - 1)/4)))^2);
        
        sum = 0;
        
        for i = 1:3
            new = ((1 + (z{i} - 1)/4)-1)^2 * (1+10*(sin(pi*(1 + (z{i} - 1)/4)+1))^2);
            sum = sum + new;
        end
        
        y = term1 + sum + term3;
        
    case 'Perm_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        outer = 0;
        
        for i = 1:dim
            inner = 0;
            for j = 1:dim
                inner = inner + (j^i+0.5)*((z{j}/j).^i-1);
            end
            outer = outer + inner.^2;
        end
        
        y = outer;
        
    case 'Perm_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        outer = 0;
        
        for i = 1:dim
            inner = 0;
            for j = 1:dim
                inner = inner + (j^i+0.5)*((z{j}/j).^i-1);
            end
            outer = outer + inner.^2;
        end
        
        y = outer;
        
    case 'Perm_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        outer = 0;
        
        for i = 1:dim
            inner = 0;
            for j = 1:dim
                inner = inner + (j^i+0.5)*((z{j}/j).^i-1);
            end
            outer = outer + inner.^2;
        end
        
        y = outer;
        
    case 'Rosenbrock_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        sum = 0;
        
        for i = 1:(dim-1)
            new = 100*(z{i+1}-z{i}^2)^2 + (z{i}-1)^2;
            sum = sum + new;
        end
        
        y = sum;
        
    case 'Rosenbrock_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        sum = 0;
        
        for i = 1:(dim-1)
            new = 100*(z{i+1}-z{i}^2)^2 + (z{i}-1)^2;
            sum = sum + new;
        end
        
        y = sum;
        
    case 'Rosenbrock_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        sum = 0;
        
        for i = 1:(dim-1)
            new = 100*(z{i+1}-z{i}^2)^2 + (z{i}-1)^2;
            sum = sum + new;
        end
        
        y = sum;
        
    case 'Shekel5_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        
        y = -outer;
        
    case 'Shekel5_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        
        y = -outer;
        
    case 'Shekel5_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        
        y = -outer;
        
    case 'Shekel7_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        for i = 1:7
            inner = 0;
            for j = 1:4
                inner = inner + (z{j}-C(j,i))^2;
            end
            outer = outer + 1/(inner+b(i));
        end
        
        y = -outer;
        
    case 'Shekel7_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        for i = 1:7
            inner = 0;
            for j = 1:4
                inner = inner + (z{j}-C(j,i))^2;
            end
            outer = outer + 1/(inner+b(i));
        end
        
        y = -outer;
        
    case 'Shekel7_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        for i = 1:7
            inner = 0;
            for j = 1:4
                inner = inner + (z{j}-C(j,i))^2;
            end
            outer = outer + 1/(inner+b(i));
        end
        
        y = -outer;
        
    case 'Shekel10_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        for i = 1:10
            inner = 0;
            for j = 1:4
                inner = inner + (z{j}-C(j,i))^2;
            end
            outer = outer + 1/(inner+b(i));
        end
        
        y = -outer;
        
    case 'Shekel10_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        for i = 1:10
            inner = 0;
            for j = 1:4
                inner = inner + (z{j}-C(j,i))^2;
            end
            outer = outer + 1/(inner+b(i));
        end
        
        y = -outer;
        
    case 'Shekel10_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
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
        for i = 1:10
            inner = 0;
            for j = 1:4
                inner = inner + (z{j}-C(j,i))^2;
            end
            outer = outer + 1/(inner+b(i));
        end
        
        y = -outer;
        
    case 'Shubert_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        sum1 = 0;
        sum2 = 0;
        
        for i = 1:5
            sum1 = sum1 + i.*cos((i+1).*z{1}+i);
            sum2 = sum2 + i.*cos((i+1).*z{2}+i);
        end
        
        y = sum1.*sum2;
        
    case 'Shubert_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        sum1 = 0;
        sum2 = 0;
        
        for i = 1:5
            sum1 = sum1 + i.*cos((i+1).*z{1}+i);
            sum2 = sum2 + i.*cos((i+1).*z{2}+i);
        end
        
        y = sum1.*sum2;
        
    case 'Shubert_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        sum1 = 0;
        sum2 = 0;
        
        for i = 1:5
            sum1 = sum1 + i.*cos((i+1).*z{1}+i);
            sum2 = sum2 + i.*cos((i+1).*z{2}+i);
        end
        
        y = sum1.*sum2;
        
    case 'Styblinski_Tang_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        idx = idx(end);
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        sum = 0;
        for i = 1:dim
            new = z{i}^4 - 16*z{i}^2 + 5*z{i};
            sum = sum + new;
        end
        
        y = sum/2;
        
    case 'Styblinski_Tang_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        idx = idx(end);
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        sum = 0;
        for i = 1:dim
            new = z{i}^4 - 16*z{i}^2 + 5*z{i};
            sum = sum + new;
        end
        
        y = sum/2;
        
    case 'Styblinski_Tang_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        idx = idx(end);
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        sum = 0;
        for i = 1:dim
            new = z{i}^4 - 16*z{i}^2 + 5*z{i};
            sum = sum + new;
        end
        
        y = sum/2;
        
    case 'Trid_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        sum1 = (z{1}-1)^2;
        sum2 = 0;
        
        for i = 2:dim
            sum1 = sum1 + (z{i}-1)^2;
            sum2 = sum2 + z{i}*z{i-1};
        end
        
        y = sum1 - sum2;
        
    case 'Trid_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        sum1 = (z{1}-1)^2;
        sum2 = 0;
        
        for i = 2:dim
            sum1 = sum1 + (z{i}-1)^2;
            sum2 = sum2 + z{i}*z{i-1};
        end
        
        y = sum1 - sum2;
        
    case 'Trid_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        sum1 = (z{1}-1)^2;
        sum2 = 0;
        
        for i = 2:dim
            sum1 = sum1 + (z{i}-1)^2;
            sum2 = sum2 + z{i}*z{i-1};
        end
        
        y = sum1 - sum2;
        
    case 'Zettl_10'
        D = 10;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        y = (z{1}^2+z{2}^2-2*z{1})^2 + 0.25*z{1};
        
    case 'Zettl_100'
        D = 100;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        y = (z{1}^2+z{2}^2-2*z{1})^2 + 0.25*z{1};
        
    case 'Zettl_1000'
        D = 1000;
        
        idx = strfind(name_of_function,'_');
        low_dim_function_name = name_of_function(1:idx-1); %get the name of the low-dimensional function from which the high-dimensional function was constrructed
        
        [dim, ~, ~, bounds] = Extract_function(low_dim_function_name);
        Q = rotation_matrices.(name_of_function);
        
        x = cell(D,1);
        for i = 1:D
            x{i} = xx(i);
        end
        
        z = cell(dim,1);
        
        for i = 1:dim
            sum = 0;
            
            for j = 1:D
                sum = sum + Q(j,i).*x{j};
            end
            z{i} = sum;
        end
        
        for i = 1:dim
            z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
        end
        
        y = (z{1}^2+z{2}^2-2*z{1})^2 + 0.25*z{1};
        %case 'Another function' (add more test functions here)
end
end
