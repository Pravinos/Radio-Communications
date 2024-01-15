%% Losses Calculation for television radiocoverage

% Calculate lambda for f= 570 MHz
f = 570;
e_0 = 8.854 * 10^(-12);
m_0 = 4 * pi * 10^(-7);
c = 1 / sqrt(e_0 * m_0);
lambda = (c / (f * 10^6));

% Define the distance between settlements and broadcasting center
d_values = [10, 2, 10, 33, 13, 22, 13, 8, 7, 3, 6, 11, 15, 11, 4, 3, 10];

% Define Pmax
Pmax_values = [0.04, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0.13, 0, 0, 0];

% Initialize a matrix to store the results
results_matrix = zeros(17, 7);

Ltot = zeros(17, 1);

for i = 1:17
    d = d_values(i);
    P = Pmax_values(i);
    free_space_losses = 122 + 20 * log10(d) - 20 * log10(lambda * 100);
    v = 1.4142 * (2 * P - 1);

    if v < -0.7
        Ldiff = 0;
    else
        Ldiff = 6.9 + 20*log10(sqrt(((v-0.1)^2)+1)+v-0.1);
    end

    Ltot(i) = free_space_losses + Ldiff + 4;

    % Store results in the matrix
    results_matrix(i, 1) = i;
    results_matrix(i, 2) = d;
    results_matrix(i, 3) = free_space_losses;
    results_matrix(i, 4) = P;
    results_matrix(i, 5) = v;
    results_matrix(i, 6) = Ldiff;
    results_matrix(i, 7) = Ltot(i);
end

% Display the results matrix with column labels
disp('Results Matrix:');
fprintf('%4s  %10s  %15s  %5s  %15s  %15s  %15s\n', 'Iter', 'Distance (Km)', 'LFS', 'Pmax', 'v', 'Ldiff', 'Ltot');
fprintf('%4d  %10.2f  %15.4f  %5.2f  %15.4f  %15.4f  %15.4f\n', results_matrix.');

