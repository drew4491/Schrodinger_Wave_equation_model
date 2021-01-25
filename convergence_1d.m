% [x6 t6 psi6 psire6 psiim6 psimod6 prob6 v6, psiex6] = ...
%             sch_1d_cn(0.25, 6, 0.1, 0, [3], 0, []);
% [x7 t7 psi7 psire7 psiim7 psimod7 prob7 v7, psiex7] = ...
%             sch_1d_cn(0.25, 7, 0.1, 0, [3], 0, []);
% [x8 t8 psi8 psire8 psiim8 psimod8 prob8 v8, psiex8] = ...
%             sch_1d_cn(0.25, 8, 0.1, 0, [3], 0, []);
% [x9 t9 psi9 psire9 psiim9 psimod9 prob9 v9, psiex9] = ...
%             sch_1d_cn(0.25, 9, 0.1, 0, [3], 0, []);
%          
% [x26 t26 psi26 psire26 psiim26 psimod26 prob26 v26] = ...
%             sch_1d_cn(0.01, 6, 0.01, 1, [0.5, 0.075, 0.0], 0, []);
% [x27 t27 psi27 psire27 psiim27 psimod27 prob27 v27] = ...
%             sch_1d_cn(0.01, 7, 0.01, 1, [0.5, 0.075, 0.0], 0, []);
% [x28 t28 psi28 psire28 psiim28 psimod28 prob28 v28] = ...
%             sch_1d_cn(0.01, 8, 0.01, 1, [0.5, 0.075, 0.0], 0, []);
% [x29 t29 psi29 psire29 psiim29 psimod29 prob29 v29] = ...
%             sch_1d_cn(0.01, 9, 0.01, 1, [0.5, 0.075, 0.0], 0, []);
        
psi7 = psi7(1:2:end, :);
psi7 = psi7(:, 1:2:end); 

psi8 = psi8(1:4:end, :);
psi8 = psi8(:, 1:4:end); 

psi9 = psi9(1:8:end, :);
psi9 = psi9(:, 1:8:end); 

psiex7 = psiex7(1:2:end, :);
psiex7 = psiex7(:, 1:2:end);

psiex8 = psiex8(1:4:end, :);
psiex8 = psiex8(:, 1:4:end);

psiex9 = psiex9(1:8:end, :);
psiex9 = psiex9(:, 1:8:end);

psi27 = psi27(1:2:end, :);
psi27 = psi27(:, 1:2:end); 

psi28 = psi28(1:4:end, :);
psi28 = psi28(:, 1:4:end); 

psi29 = psi29(1:8:end, :);
psi29 = psi29(:, 1:8:end);

%%

psi76 = psi7 - psi6;
test76 = zeros(1, length(t6));
f = 0;
for n = 1 : length(test76)
    
    f = abs(psi76(n, :)).^2;
    test76(n) = sum(f);
end

check76 = sqrt(test76/length(test76));

%%

psi87 = psi8 - psi7;
test87 = zeros(1, length(t6));
f = 0;
for n = 1 : length(test87)
    f = abs(psi87(n, :)).^2;
    test87(n) = sum(f);
end
check87 = sqrt(test87/length(test87));

%%

psi98 = psi9 - psi8;
test98 = zeros(1, length(t6));
f = 0;
for n = 1 : length(test98)
    f = abs(psi98(n, :)).^2;
    test98(n) = sum(f);
end
check98 = sqrt(test98/length(test98));

%%

ex6 = psiex6 - psi6;
testex6 = zeros(1, length(t6));
f = 0;
for n = 1 : length(testex6)
    f = abs(ex6(n, :)).^2;
    testex6(n) = sum(f);
end
exact6 = sqrt(testex6/length(testex6));

%%

ex7 = psiex7 - psi7;
testex7 = zeros(1, length(t6));
f = 0;
for n = 1 : length(testex7)
    f = abs(ex7(n, :)).^2;
    testex7(n) = sum(f);
end
exact7 = sqrt(testex7/length(testex7));

%%

ex8 = psiex8 - psi8;
testex8 = zeros(1, length(t6));
f = 0;
for n = 1 : length(testex8)
    f = abs(ex8(n, :)).^2;
    testex8(n) = sum(f);
end
exact8 = sqrt(testex8/length(testex8));

%%

ex9 = psiex9 - psi9;
testex9 = zeros(1, length(t6));
f = 0;
for n = 1 : length(testex9)
    f = abs(ex9(n, :)).^2;
    testex9(n) = sum(f);
end
exact9 = sqrt(testex9/length(testex9));

%%

psi276 = psi27 - psi26;
test276 = zeros(1, length(t26));
f = 0;
for n = 1 : length(test276)
    
    f = abs(psi276(n, :)).^2;
    test276(n) = sum(f);
end

check276 = sqrt(test276/length(test276));

%%

psi287 = psi28 - psi27;
test287 = zeros(1, length(t26));
f = 0;
for n = 1 : length(test287)
    
    f = abs(psi287(n, :)).^2;
    test287(n) = sum(f);
end

check287 = sqrt(test287/length(test287));

%%

psi298 = psi29 - psi28;
test298 = zeros(1, length(t26));
f = 0;
for n = 1 : length(test298)
    
    f = abs(psi298(n, :)).^2;
    test298(n) = sum(f);
end

check298 = sqrt(test298/length(test298));

%%

figure(1);
plot(t6, check76);
hold on;
plot(t6, check87);
hold on;
plot(t6, check98);
title("Non Scaled Convergence Part 1");
legend("psi7 - psi6", "psi8 - psi7", "psi9 - psi8");


figure(2);
plot(t6, check76);
hold on;
plot(t6, 4*check87);
hold on;
plot(t6, 16*check98);
title("Scaled Convergence Part 1");
legend("psi7 - psi6", "psi8 - psi7", "psi9 - psi8");


figure(3);
plot(t6, exact6);
hold on;
plot(t6, exact7);
hold on;
plot(t6, exact8);
hold on;
plot(t6, exact9);
title("Non Scaled Convergence Psi exact - Psi ");
legend("psiex6 - psi6", "psiex7 - psiex7", "psiex8 - psi8", "psiex9 - psi9");

figure(4);
plot(t6, exact6)
hold on;
plot(t6, 4*exact7);
hold on;
plot(t6, 16*exact8);
hold on;
plot(t6, 64*exact9);
title("Scaled Convergence Psi exact - Psi");
legend("psiex6 - psi6", "psiex7 - psiex7", "psiex8 - psi8", "psiex9 - psi9");


figure(5);
plot(t26, check276);
hold on;
plot(t26, check287);
hold on;
plot(t26, check298);
title("Non Scaled Convergence Part 2");
legend("psi7 - psi6", "psi8 - psi7", "psi9 - psi8");



figure(6);
plot(t26, check276);
hold on;
plot(t26, 4*check287);
hold on;
plot(t26, 16*check298);
title("Scaled Convergence Part 2");
legend("psi7 - psi6", "psi8 - psi7", "psi9 - psi8");
