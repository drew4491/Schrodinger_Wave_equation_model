% [xt yt tt psit psiret psiimt psimodt vt] = ...
%     sch_2d_adi(0.0135, 6, 0.03, 1, [0.5, 0.9, 0.12, 0.12, 0, -50], 2, [0.4,0.45,0.55,0.6, 25000]);

% [xt yt tt psit psiret psiimt psimodt vt] = ...
%     sch_2d_adi(0.015, 6, 0.03, 1, [0.5, 0.9, 0.12, 0.12, 0, -20], 1, [0.4, 0.6, 0.4, 0.6, -10000]);
% % 
% [xt yt tt psit psiret psiimt psimodt vt] = ...
%     sch_2d_adi(0.015, 6, 0.03, 1, [0.5, 0.9, 0.12, 0.12, 0, -20], 1, [0.4, 0.6, 0.4, 0.6, 900]);




[X, Y] = meshgrid(xt,yt);

pausesecs = 0.05;
avifilename = 'double_slit.avi';
aviframerate = 25;
aviobj = VideoWriter(avifilename);
aviobj.FrameRate = 10;
open(aviobj);

for n = 1: length(tt)
      surf(X, Y, psimodt(:, :, n));
%       contourf(X, Y, psimodt(:, :, n));
      colormap(hsv);
      zlim([-1, 1]);
      drawnow;
      writeVideo(aviobj, getframe(gcf));
      pause(pausesecs);
      
end    
 close(aviobj);

% for n = 1:length(tt);
%     %surf(X,Y, psimodt(:,:,n));
%     contourf(X,Y, psimodt(:,:,n));
%     zlim([-1, 1]);
%     drawnow;
%     colormap(hsv);
% end

