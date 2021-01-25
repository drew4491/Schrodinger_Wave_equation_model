% [x6 y6 t6 psi6 psire6 psiim6 psimod6 v6 psiex6] = ...
% sch_2d_adi(0.05, 6, 0.05, 0, [2, 3], 0, []);
% 
% [x7 y7 t7 psi7 psire7 psiim7 psimod7 v7 psiex7] = ...
% sch_2d_adi(0.05, 7, 0.05, 0, [2, 3], 0, []);
% 
% [x8 y8 t8 psi8 psire8 psiim8 psimod8 v8 psiex8] = ...
% sch_2d_adi(0.05, 8, 0.05, 0, [2, 3], 0, []);
% 
% [x9 y9 t9 psi9 psire9 psiim9 psimod9 v9 psiex9] = ...
% sch_2d_adi(0.05, 9, 0.05, 0, [2, 3], 0, []);


psi7c = psi7(1:2:end, 1:2:end, 1:2:end);
psi8c = psi8(1:4:end, 1:4:end, 1:4:end);
psi9c = psi9(1:8:end, 1:8:end, 1:8:end);

psiex6c = psiex6;
psiex7c = psiex7(1:2:end, 1:2:end, 1:2:end);
psiex8c = psiex8(1:4:end, 1:4:end, 1:4:end);
psiex9c = psiex9(1:8:end, 1:8:end, 1:8:end);

for n = 1 : length(t6)
psi76c(:, :, n) = psi7c(:, :, n) - psi6(:, :, n);
end

test76 = zeros(1, length(t6));
f = 0;
for n = 1 : length(test76)
    f = abs(psi76c(:, :, n)).^2;
    test76(n) = sum(f(:));
end

check76c = sqrt(test76/(length(x6)*length(y6)));

for n = 1 : length(t6)
psi87c(:, :, n) = psi8c(:, :, n) - psi7c(:, :, n);
end

test87 = zeros(1, length(t6));
f = 0;

for n = 1 : length(test87)
    f = abs(psi87c(:, :, n)).^2;
    test87(n) = sum(f(:));
end

check87c = sqrt(test87/(length(x6)*length(y6))); 

for n = 1 : length(t6)
psi98c(:, :, n) = psi9c(:, :, n) - psi8c(:, :, n);
end

test98 = zeros(1, length(t6));
f = 0;

for n = 1 : length(test98)
    f = abs(psi98c(:, :, n)).^2;
    test98(n) = sum(f(:));
end

check98c = sqrt(test98/(length(x6)*length(y6)));

testex6 = zeros(1, length(t6));
f = 0;

for n = 1 : length(t6)
ex6c(:, :, n) = psiex6c(:, :, n) - psi6(:, :, n);
end

for n = 1 : length(t6)
    f = abs(ex6c(:, :, n)).^2;
    testex6(n) = sum(f(:));
end

exact6c = sqrt(testex6/(length(x6)*length(y6)));

testex7c = zeros(1, length(t6));
f = 0;

for n = 1 : length(t6)
ex7c(:, :, n) = psiex7c(:, :, n) - psi7c(:, :, n);
end

for n = 1 : length(t6)
    f = abs(ex7c(:, :, n)).^2;
    testex7c(n) = sum(f(:));
end

exact7c = sqrt(testex7c/(length(x6)*length(y6)));

testex8c = zeros(1, length(t6));
f = 0;

for n = 1 : length(t6)
ex8c(:, :, n) = psiex8c(:, :, n) - psi8c(:, :, n);
end

for n = 1 : length(t6)
    f = abs(ex8c(:, :, n)).^2;
    testex8c(n) = sum(f(:));
end

exact8c = sqrt(testex8c/(length(x6)*length(y6)));

testex9c = zeros(1, length(t6));
f = 0;

for n = 1 : length(t6)
ex9c(:, :, n) = psiex9c(:, :, n) - psi9c(:, :, n);
end

for n = 1 : length(t6)
    f = abs(ex9c(:, :, n)).^2;
    testex9c(n) = sum(f(:));
end

exact9c = sqrt(testex9c/(length(x6)*length(y6)));

figure(1);
plot(t6, check76c);
hold on;
plot(t6, check87c);
hold on;
plot(t6, check98c);
title("Non Scaled Convergence Part 1");
legend("psi7 - psi6", "psi8 - psi7", "psi9 - psi8");

figure(2);
plot(t6, check76c);
hold on;
plot(t6, 4*check87c);
hold on;
plot(t6, 16*check98c);
title("Scaled Convergence Part 1");
legend("psi7 - psi6", "psi8 - psi7", "psi9 - psi8");


figure(3);
plot(t6, exact6c);
hold on;
plot(t6, exact7c);
hold on;
plot(t6, exact8c);
hold on;
plot(t6, exact9c);
title("Non Scaled Convergence Psi exact - Psi ");
legend("psiex6 - psi6", "psiex7 - psiex7", "psiex8 - psi8", "psiex9 - psi9");

figure(4);
plot(t6, exact6c)
hold on;
plot(t6, 4*exact7c);
hold on;
plot(t6, 16*exact8c);
hold on;
plot(t6, 64*exact9c);
title("Scaled Convergence Psi exact - Psi");
legend("psiex6 - psi6", "psiex7 - psiex7", "psiex8 - psi8", "psiex9 - psi9");

