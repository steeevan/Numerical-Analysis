function [] = H02_Q02()
    % H02_Q02 - A script that applies the Bisection Method to find a root
    % of a given function in a user-specified interval [a, b] with a desired
    % tolerance.
    %
    % This function prompts the user to input values for the interval endpoints
    % 'a' and 'b', and the tolerance 'epsilon', then uses the bisection method
    % to find the root of the function f(x) = x^2 - 5.
    %
    % Usage:
    %   Call the function without any arguments:
    %   >> H02_Q02
    %
    % User Inputs:
    %   a - Left endpoint of the interval [a, b]
    %   b - Right endpoint of the interval [a, b]
    %   epsilon - Desired accuracy for the root

    % Define the function handle for f(x) = x^2 - 5
    f = @(x) x^2 - 5;
    
    % Prompt the user for input values
    a = input('Enter a value for a: ');
    b = input('Enter a value for b: ');
    ep = input('Enter a value for epsilon:');
    
    % Call the bisection function to find the root
    bisection(a, b, f, ep);
end

function [] = bisection(a, b, f, ep)
    % Bisection Method to find the root of the function f in the interval [a, b]
    %
    % This function applies the Bisection Method iteratively to find a root
    % of the given function f with an accuracy specified by epsilon.
    %
    % Inputs:
    %   a  - Left endpoint of the interval [a, b]
    %   b  - Right endpoint of the interval [a, b]
    %   f  - Function handle for the equation to be solved
    %   ep - Desired tolerance (epsilon) for the root accuracy
    %
    % Output:
    %   Prints each iteration showing the interval and midpoint with the
    %   sign of f(a), f(midpoint), and f(b).
    
    % Calculate maximum number of iterations needed for the specified tolerance
    nMax = ceil(log2((b - a) / ep));
    
    % Pre-allocate space for variables
    p = zeros(1, nMax);       % Midpoints
    a_values = zeros(1, nMax); % Left endpoints (a_n values)
    b_values = zeros(1, nMax); % Right endpoints (b_n values)
    
    % Store initial values of a and b
    a_values(1) = a;
    b_values(1) = b;
    
    % Iterative method to find the root
    for n = 1:nMax
        p(n) = (a + b) / 2;  % Midpoint of the current interval
        
        % Store current a(n), b(n)
        a_values(n) = a;
        b_values(n) = b;

        % Print the iteration details
        fprintf('n = %d: an = %0.8f, pn = %0.8f, bn = %0.8f, sign(f(an)) = %d, sign(f(pn)) = %d, sign(f(bn)) = %d\n', ...
            n, a, p(n), b, sign(f(a)), sign(f(p(n))), sign(f(b)));

        % Determine which subinterval to select
        if sign(f(a)) ~= sign(f(p(n)))
            b = p(n);  % Root is in the left subinterval
        else
            a = p(n);  % Root is in the right subinterval
        end
        
        % Store new a(n), b(n)
        a_values(n+1) = a;
        b_values(n+1) = b;
    end

    % Final result if the loop completes
    %fprintf('Approximate root after %d iterations: %f\n', nMax, p(n));

    %% Plot 1: a(n), p(n), and b(n) versus n
    figure;
    n_values = 1:nMax;
    plot(n_values, a_values(1:nMax), 'go-', 'LineWidth', 2); hold on;
    plot(n_values, p(1:nMax), 'ko-', 'LineWidth', 2); 
    plot(n_values, b_values(1:nMax), 'ro-', 'LineWidth', 2);
    % Set axis limits
    xlim([0 20]);
    ylim([2 3]);
    
    % Set tick steps
    xticks(0:5:20);  % 
    yticks(2:0.1:3);  % Ticks 
    xlabel('n');
    ylabel('Values');
    legend('a(n)', 'p(n)', 'b(n)');
    title('Bisection Method for f(x) = x^2 - 5');
    grid on;

    %% Plot 2: Error bound \bar{e}_n versus \bar{e}_{n-1}
    % Calculate error bounds: e_n = |p(n) - p(n-1)|
    error_bound = abs(diff(p));
    
    figure;
    plot(error_bound(1:end-1), error_bound(2:end), 'bo-', 'LineWidth', 2);
    % Set axis limits
    xlim([0 0.5]);
    ylim([0 0.25]);
    
    % Set tick steps
    xticks(0:.1:0.5);  % 
    yticks(0:0.05:0.25);  % Ticks
    xlabel('e_n-1');
    ylabel('e_n');
    title('Bisection Method for f(x) = x^2 - 5');
    grid on;

    %% Plot 3: Alpha values (convergence rate approximation)
    % Calculate alpha values using the provided formula
    if length(error_bound) >= 3  % Ensure there are at least 3 error bounds
        alpha = zeros(1, nMax-2);  % Pre-allocate for alpha values
        for n = 3:length(error_bound)
            alpha(n-2) = (log(error_bound(n)) - log(error_bound(n-1))) / ...
                         (log(error_bound(n-1)) - log(error_bound(n-2)));
        end

        figure;
        plot(3:nMax, alpha, 'm*-', 'LineWidth', 2);
         % Set axis limits
        xlim([0 20]);
        ylim([0 1.01]);
        
        % Set tick steps
        xticks(0:5:20);  % 
        yticks(0: 1.01);  % Ticks
        ylabel('Iteration (n)');
        xlabel( '$\bar{e} {n-1}$', 'interpreter', 'latex' );
        title('Bisection Method for f(x) = x^2 - 5');
        grid on;
    else
        fprintf('Not enough error bounds to compute \alpha values.\n');
    end
    

end
