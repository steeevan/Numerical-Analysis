function [] = H04_Q01()
    % Main function to get inputs and run FPI
    p1 = input("Enter a value for p1: ");                      % Initial guess
    g = input("Enter an anonymous function g: ");   % Directly input the function as a function handle
    alpha = input("Enter a value for alpha: ");  % Actual fixed point
    epsilon = input("Enter a value for epsilon: ");           % Tolerance
    
    % Call the FPI function
    FPI(g, p1, epsilon, alpha);
end

function [] = FPI(g, p1, epsilon, alpha)
    % Fixed Point Iteration Function
    n = 1;
    p(n) = p1; % Initial guess
    fERROR_EST = inf; % Initialize the error estimate
    rho = abs((g(alpha + epsilon) - g(alpha)) / epsilon);
    % Compute the maximum number of iterations using the formula
    nMax = ceil(log(abs(p1 - alpha) / epsilon) / log(1 / rho));
    nMax = 20;
    
    % Pre-allocate storage for error estimates and alpha approximations
    error_estimates = zeros(1, nMax);
    alpha_estimates = zeros(1, nMax);
    
    % Loop until convergence or reaching max iterations
    while fERROR_EST > epsilon && n < nMax
        n = n + 1;
        p(n) = g(p(n-1)); % Apply function g to the previous iteration
        
        % Error estimate (|p(n) - p(n-1)|)
        if n < 2
            fERROR_EST = 10 * epsilon;
        else
            if alpha <= 1
                gP = abs((p(n) - p(n-1)) / (p(n-1) - p(n-2)));
                fERROR_EST = abs(gP / (gP - 1)) * abs(p(n) - p(n-1));
            else
                fERROR_EST = abs(p(n) - p(n-1));
            end
        end

        % Store error estimates for plotting later
        error_estimates(n) = fERROR_EST;
        
        % Compute alpha approximation for n >= 3
        if n >= 3
            ehat_n = abs(p(n) - p(n-1));
            ehat_n_1 = abs(p(n-1) - p(n-2));
            ehat_n_2 = abs(p(n-2) - p(n-3));
            
            if ehat_n_1 > 0 && ehat_n_2 > 0
                alpha_n = (log(ehat_n) - log(ehat_n_1)) / (log(ehat_n_1) - log(ehat_n_2));
                alpha_estimates(n) = alpha_n;
            end
        end
        
        % Display the current iteration, p(n), and the error estimate
        fprintf('n = %d: p(%d) = %.8f, ehat(%d) = %.8e\n', n, n, p(n), n-1, fERROR_EST);
    end

    % Generate the three plots after the loop
    generate_plots(p, error_estimates, alpha_estimates, g);
end

function [] = generate_plots(p, error_estimates, alpha_estimates, g)
    % Plot 1: p(n) versus n
    figure;
    n_vals = 1:length(p);
    plot(n_vals, p, '-o');
    xlabel('n');
    ylabel('p(n)');
    title('Fixed Point Iteration: p(n) vs. n');
    
    % Plot 2: ˆen versus ˆen-1
    if length(error_estimates) > 1
        figure;
        plot(error_estimates(2:end), error_estimates(1:end-1), '-o');
        xlabel('$\hat{e}_{n-1}$', 'Interpreter', 'latex');
        ylabel('$\hat{e}_n$', 'Interpreter', 'latex');
        title( sprintf('Fixed Point Iteration for g(x) = %s', func2str(g)) );
    end
    
    % Plot 3: ˆαn versus n
    if ~isempty(alpha_estimates)
        figure;
        alpha_vals = 3:length(alpha_estimates)+2;  % Starts from n = 3
        plot(alpha_vals, alpha_estimates(3:end), '-o');
        xlabel('n');
        ylabel('$\hat{\alpha}_n$', 'Interpreter', 'latex');
        title('Convergence Factor $\hat{\alpha}_n$ vs. n', 'Interpreter', 'latex');
    end
end

%----------------------------------------------------------------------------------
%{
function [] = H04_Q01()
    % Main function to get inputs and run FPI
    p1 = input("Enter a value for p1: ");                      % Initial guess
    g = input("Enter an anonymous function g: ");   % Directly input the function as a function handle
    alpha = input("Enter a value for alpha: ");  % Actual fixed point
    epsilon = input("Enter a value for epsilon: ");           % Tolerance
    
    % Call the FPI function
    FPI(g, p1, epsilon, alpha);
end

function [] = FPI(g, p1, epsilon, alpha)
    % Fixed Point Iteration Function
    n = 1;
    p(n) = p1; % Initial guess
    fERROR_EST = inf; % Initialize the error estimate
    rho = abs((g(alpha + epsilon) - g(alpha)) / epsilon);
    % Compute the maximum number of iterations using the formula
    nMax = ceil(log(abs(p1 - alpha) / epsilon) / log(1 / rho));
    nMax = 20;
    
    % Loop until convergence or reaching max iterations
    while fERROR_EST > epsilon && n < nMax
        n = n + 1;
        p(n) = g(p(n-1)); % Apply function g to the previous iteration
        
        % Error estimate (|p(n) - p(n-1)|)
        if n < 2
            fERROR_EST = 10 * epsilon;
        else
            if alpha <= 1

                gP = abs((p(n) - p(n-1))/(p(n-1) - p(n-2)));

                fERROR_EST = abs(gP/(gP - 1)) * abs(p(n) - p(n-1));
            else
                fERROR_EST = abs(p(n) - p(n-1));
            end
        end

        
       % Display the current iteration, p(n), and the error estimate starting from n=2
        fprintf('n = %d: p(%d) = %.8f, ehat(%d) = %.8e\n', n, n, p(n), n-1, fERROR_EST);
    
    end

   
end
%}

