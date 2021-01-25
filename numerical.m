[x t psi psire psiim psimod prob v] = ...
            sch_1d_cn(0.10, 9, 0.01, 1, [0.4, 0.075, 0.0], 1, [0.6, 0.8, v0(k)]);

x1 = 0.6;
x2 = 0.8;     

v0 = linspace(-exp(5), -exp(-2), 251);
q1 = find(abs(x-x1) == min(abs(x-x1)));
q2 = find(abs(x-x2) == min(abs(x-x2)));
Fe = zeros(1, length(v0));

for k = 1 : length(v0)
    x1 = 0.6;
    x2 = 0.8; 
    [x t psi psire psiim psimod prob v] = ...
            sch_1d_cn(0.10, 9, 0.01, 1, [0.4, 0.075, 0.0], 1, [0.6, 0.8, v0(k)]);
    Ptemp = mean(prob);
    Pnorm = Ptemp / Ptemp(end);
    Fe(k) = log((Ptemp(q1) - Ptemp(q2))/(x2-x1));
end

figure(1);
plot(log(v0), (Fe));
title("Well Survey");
xlabel("ln(v_0)");
ylabel("ln Fe");
