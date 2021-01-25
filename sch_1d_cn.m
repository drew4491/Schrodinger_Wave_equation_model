function [x t psi psire psiim psimod prob v, psiex] = ...
            sch_1d_cn(tmax, level, lambda, idtype, idpar, vtype, vpar)
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
% t: Vector of t coordinates [nt]
% psi: Array of computed psi values [nt x nx]
% psire Array of computed psi_re values [nt x nx]
% psiim Array of computed psi_im values [nt x nx]
% psimod Array of computed sqrt(psi psi*) values [nt x nx]
% prob Array of computed running integral values [nt x nx]
% v Array of potential values [nx]

   nx = 2^level + 1;
   dx = 2^(-level);
   dt = lambda * dx;
   nt = round(tmax / dt) + 1;
   psi = zeros(nt, nx);
   psiex = zeros(nt, nx);
   x = linspace(0.0, 1.0, nx);
   t = [0 : nt-1] * dt;
   
   if idtype == 0
       m = idpar(1);
       psi(1, :) = sin(m*pi*x);
   elseif idtype == 1
       x0 = idpar(1);
       delta = idpar(2);
       p = idpar(3);
       psi(1, :) = exp((i*p).*x).*exp(-((x - x0) ./ delta) .^ 2);
   else
      fprintf('diff_1d_cn: Invalid idtype=%d\n', idtype);
      return
   end
 
   v = zeros(1 , nx);

   if vtype == 0
       v = zeros(1, nx);
   elseif vtype == 1
       xmin = vpar(1);
       xmax = vpar(2);
       vc = vpar(3);
       for s = 1 : nx
           if x(s) < xmin
               v(s) = 0;
           elseif (x(s) >= xmin && x(s) <= xmax)
               v(s) = vc;
           else
               v(s) = 0;
           end
       end
   end
   %sparse matrix set up
   
   dl = zeros(nx,1);
   d  = zeros(nx,1);
   du = zeros(nx,1);
   f  = zeros(nx,1);

%set up tri diagonal system

 
   for q = 1 : length(x)
       d(q) = ((i/dt)-(1/dx^2)-(v(q)/2));
   end
   
   du = (1/(2*dx^2)) * ones(nx, 1);
   dl = du;
       
   % Fix up boundary cases ...
   d(1) = 1.0;
   du(2) = 0.0;
   dl(nx-1) = 0.0;
   d(nx) = 1.0;
   % Define sparse matrix ...
   A = spdiags([dl d du], -1:1, nx, nx);

   for n = 1 : nt-1
      % Define RHS of linear system ...
      f(2:nx-1) = (-(1/(2*dx^2)) * (psi(n, 3:nx) + psi(n, 1:nx-2)) ...
                   + psi(n, 2:nx-1) .* (i/dt + 1/dx^2 + ((v(2 : nx-1))/2)));
      f(1) = 0.0;
      f(nx) = 0.0;
      % Solve system, thus updating approximation to next time 
      % step ...
      psi(n+1, :) = A \ f;

   end
   
   for y = 1 : nx - 1
       check(:,y) = 0.5*((abs((psi(:, y)).^2) + abs((psi(:, y+1))).^2) ...
                .*(x(y+1)-x(y)));  
   end
          
   psire = real(psi);   
   psiim = imag(psi);
   psimod = abs(psi);   
   prob = cumsum(check, 2);
   
   for n = 1 : nt
       m = 3;
       psiex(n, :) = (exp(-i*(m^2)*(pi^2)*t(n))).*sin(m*pi*x);
   end
end
