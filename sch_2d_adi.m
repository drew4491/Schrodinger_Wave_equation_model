function [x y t psi psire psiim psimod v psiex] = ...
sch_2d_adi(tmax, level, lambda, idtype, idpar, vtype, vpar)
% Inputs
%
% tmax: Maximum integration time
% level: Discretization level
% lambda: dt/dx
% idtype: Selects initial data type
% idpar: Vector of initial data parameters
% vtype: Selects potential type
% vpar: Vector of potential parameters
%
% Outputs
%
% x: Vector of x coordinates [nx]
% y: Vector of y coordinates [ny]
% t: Vector of t coordinates [nt]
% psi: Array of computed psi values [nt x nx x ny]
% psire Array of computed psi_re values [nt x nx x ny]
% psiim Array of computed psi_im values [nt x nx x ny]
% psimod Array of computed sqrt(psi psi*) values [nt x nx x ny]
% v Array of potential values [nx x ny]

   nx = 2^level + 1;
   ny = nx;
   dx = 2^(-level);
   dy = 2^(-level);
   dt = lambda * dx;
   nt = round(tmax / dt) + 1;
   psi = zeros(ny, nx, nt);
   psifake = zeros(ny, nx, nt);
   x = linspace(0.0, 1.0, nx);
   y = linspace(0.0, 1.0, ny);
   v = zeros(ny, nx);
   t = [0 : nt-1] * dt;
 
   if idtype == 0
       mx = idpar(1);
       my = idpar(2);
       psi(:, :, 1) = sin(mx*pi*x) .* sin(my*pi*y.');
   elseif idtype == 1
       x0 = idpar(1);
       y0 = idpar(2);
       deltax = idpar(3);
       deltay = idpar(4);
       px = idpar(5);
       py = idpar(6);
       psi(:, :, 1) = exp(i*px*x).*exp(i*py*y.') .* exp(-((x-x0).^2 / (deltax.^2) + ...
                        (y.'-y0).^2 / (deltay^2)));
   else
      fprintf('diff_1d_cn: Invalid idtype=%d\n', idtype);
      return
   end
   
   if vtype == 0
       v = zeros(ny, nx);
   elseif vtype == 1
       xmin = vpar(1);
       xmax = vpar(2);
       ymin = vpar(3);
       ymax = vpar(4);
       vc = vpar(5);
       for s = 1:nx
           for r = 1:ny
               if x(s) >= xmin && x(s) <= xmax && y(r) >= ymin && y(r) <= ymax 
                   v(r, s) = vc;
               else
                   v(r, s) = 0;
               end
           end
       end
   elseif vtype ==2
       x1 = vpar(1);
       x2 = vpar(2);
       x3 = vpar(3);
       x4 = vpar(4);
       vc = vpar(5);
       j = (ny - 1)./4 +1;
       for e = 1:ny
           if (x1 >= x(e)) || (x2 <= x(e)) &&  (x3 >= x(e)) || (x4 <= x(e))
               v(j, e) = vc;
               v(j+1, e) = vc;
           end
       end    
    else
      fprintf('diff_1d_cn: Invalid idtype=%d\n', idtype);
      return
    end
%%  
   dl1 = zeros(nx,1);
   d1  = zeros(nx,1);
   du1 = zeros(nx,1);
   f1  = zeros(nx,1);

   d1 = (1+((i*dt)/(dx^2))) * ones(nx, 1);
   du1 = ((-i*dt)/(2*dx^2)) * ones(nx, 1);
   dl1 = du1;
       
   % Fix up boundary cases ...
   d1(1) = 1.0;
   du1(2) = 0.0;
   dl1(nx-1) = 0.0;
   d1(nx) = 1.0;
   % Define sparse matrix ...
   A1 = spdiags([dl1 d1 du1], -1:1, ny, ny);
 %%  
   dl2 = zeros(nx,1);
   d2  = zeros(nx,1);
   du2 = zeros(nx,1);
   f2  = zeros(nx,1);
%%   
   
      for n = 1 : nt-1
      % Define RHS of linear system ...
          for o = 2 : ny-1
              
              f1(:) = (1-((i*dt)/(dy^2)) - ((i*dt)/2)*v(o, :)) .* psi(o, :, n)...
                              + ((i*dt)/(2*dy^2)) .* (psi(o-1, :, n) + psi(o+1, :, n));
              f1(1) = 0.0;
              f1(ny) = 0.0;
              % Solve system, thus updating approximation to next time 
              % step ...
              psifake(o, :, n) = A1 \ f1;
              
          end
          
          for z = 2 : nx-1
              
              d2 = (1+((i*dt)/(dy^2)) + (i*dt/2)*v(:, z)) .* ones(nx, 1);
              du2 = ((-i*dt)/(2*dy^2)) .* ones(ny, 1);
              dl2 = du2; 
             
              d2(1) = 1.0;
              du2(2) = 0.0;
              dl2(nx-1) = 0.0;
              d2(nx) = 1.0;
              
              A2 = spdiags([dl2 d2 du2], -1:1, nx, nx);
              
              f2(:) = (1-((i*dt)/(dx^2))).*psifake(:, z, n) + ((i*dt)/(2*dx^2)).*(psifake(:, z+1, n)...
                              + psifake(:, z-1, n));
              f2(1) = 0.0;
              f2(nx) = 0.0;
              % Solve system, thus updating approximation to next time 
              % step ...

              psi(:, z, n+1) = A2 \ f2;
          
          end
      end
      
         psire = real(psi);   
         psiim = imag(psi);
         psimod = abs(psi);   
        
        for n = 1 : nt
            psiex(:, :, n) = exp(-i*(idpar(1)^2+idpar(2)^2)*pi^2*t(n)) .* sin(idpar(1)*pi*x) .* sin(idpar(2)*pi*y.');
        end
        
end
   


    