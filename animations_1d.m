[x t psi psire psiim psimod prob v] = ...
            sch_1d_cn(0.04, 8, 0.11, 1, [0.3, 0.075, 0], 1, [0.6, 0.8, 1000]);
        
% figure(1);
% plot(x, psimod(1 ,:));
% xlim([0, 1]);
% ylim([-1, 1]);
% drawnow;

pausesecs = 0.01;
avifilename = 'no_potential_1D.avi';
aviframerate = 25;
aviobj = VideoWriter(avifilename);
open(aviobj);

for n = 1: length(t)
      clf;
      hold on;
      xlim([min(x), max(x)]);
      ylim([-1, 1]);
      plot(x,psimod(n,:));
      hold on;
      plot(x,v);
      drawnow;
      writeVideo(aviobj, getframe(gcf));
      pause(pausesecs);
end    
close(aviobj);