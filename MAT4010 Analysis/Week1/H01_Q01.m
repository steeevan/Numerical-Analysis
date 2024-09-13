function [] = H01_Q01()
% Name of Function: HW1_Q01
%
% Description: 
% This function serves as the main script for user input to approximate the square 
% root of a given number using an iterative method. It collects input values from 
% the user for the number `a`, initial guess `x1`, error tolerance `epsilon`, and 
% the maximum number of iterations `nMax`. It then calls the `sqrRoot` function to 
% perform the square root approximation.
%
% Input:
%   None (inputs are collected interactively from the user via the command line).
%
% Output:
%   None (results are printed via the `sqrRoot` function).
%
% Local Variables:
%   a       - The number for which the square root is to be approximated (scalar).
%   x1      - The initial guess for the square root (scalar).
%   epsilon - The tolerance level for error (scalar).
%   nMax    - The maximum number of iterations allowed (integer).
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    a = input('Enter the value for a: ');
    x1 = input('Enter the value for x1: ');
    epsilon = input('Enter the value for epsilon: ');
    nMax = input('Enter the value for nMax: ');

    sqrRoot(a,x1,epsilon,nMax);

end


function [] = sqrRoot(a, x1, epsilon, nMax)
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Name of Function: sqrRoot
%
% Description: 
% This function approximates the square root of a number `a` using an iterative 
% method based on the Babylonian method (also known as Newton's method for square roots). 
% The approximation converges until the error between consecutive approximations is less 
% than the tolerance `epsilon` or the maximum number of iterations `nMax` is reached.
%
% Input:
%   a       - The number for which the square root is to be approximated (scalar).
%   x1      - The initial guess for the square root (scalar).
%   epsilon - The tolerance level for error (scalar).
%   nMax    - The maximum number of iterations allowed (integer).
%
% Output:
%   None (results are printed to the console).
%
% Local Variables:
%   n           - The iteration counter (integer).
%   x(n)        - The approximation of the square root at each step (vector).
%   afErrorEst  - The estimated error at each iteration (vector).
%
% Example Call:
%   sqrRoot(16, 1, 0.0001, 100);
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Initialization of iteration counter and error estimate
    n = 1;
    x(1) = x1;
    afErrorEst(1) = inf;
    
    % Iteration loop: continue until error is less than epsilon or max iterations reached
    while afErrorEst(n) > epsilon && n < nMax
        % Update approximation using the Babylonian method
        x(n+1) = (0.5) * (x(n) + a/x(n));
        
        % Calculate error estimate
        afErrorEst(n+1) = abs(x(n+1) - x(n));
        
        % Increment iteration counter
        n = n + 1;
        
        % Print current iteration's results
        fprintf('For n = %d, x(%d) = %0.2f and |eHat(%d)| = %0.2e\n', n, n, x(n), n, afErrorEst(n));
    end
    
    %{
    % Check for convergence and print final results
    if afErrorEst(n) < epsilon
        fprintf('An approx of the square root of %0.2f is %0.2f\n', a, x(n));
    else
        fprintf('Max iterations reached\n');
    end
    %}
    % Print input values for reference
    % fprintf('%0.2f - %0.2f - %0.2f - %0.2f\n', a, x1, epsilon, nMax);
        % Plot 1: Approximation (x_n) vs iteration number (n) alongside true sqrt(a)
    %{
    figure(1); % Create a new figure for the first plot
    hold on;
    plot(1:n, x(1:n), '-o', 'DisplayName', 'x_n Approximation');  % Plot approximation with markers
    yline(sqrt(a), '-','LineWidth', 1.5, 'DisplayName', 'True sqrt(a)');
    xlabel('Iteration number (n)');
    ylabel('Value of sqrt approximation');
    legend('show');
    title('Approximation of sqrt(a) vs Iteration number');
    hold off;
    %}
    figure(1); % Create a new figure for the first plot
    hold on;
    semilogy(1:length(afErrorEst), -flip(afErrorEst), '-o', 'LineWidth', 2);
    xlabel('Iteration (n)', 'FontSize', 12);
    ylabel('|e_n| (Log Scale)', 'FontSize', 12);
    title('Error vs. Iteration', 'FontSize', 14);
    hold off;

end


% ---------------
% git activated |
% ---------------