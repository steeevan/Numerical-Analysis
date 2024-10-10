function [] = H06_Q02()
    % Main function to get inputs and run FPI
    p1 = input("Enter a value for p1: ");                      % Initial guess
    p2 = input("Enter a value for p2: ");
    g = input("Enter an anonymous function f: ");   % Directly input the function as a function handle
    epsilon = input("Enter a value for epsilon: ");           % Tolerance
    nMax = input('Enter a maximum value for n: ');
    

    SecantMethod(g,p1,p2,epsilon,nMax)
end

function [] = SecantMethod(f, p1, p2, epsilon, nMax)
    % Secant Method Function
    
    n = 2; % Start with two initial points
    p(1) = p1; % First guess
    p(2) = p2; % Second guess
    fError(1) = abs(p(2) - p(1)); % Initial error for the second guess

    % Loop until convergence or reaching max iterations
    while true
        % Secant Method update: p(n+1) = p(n) - f(p(n)) * (p(n) - p(n-1)) / (f(p(n)) - f(p(n-1)))
        fp_n = f(p(n));
        fp_n1 = f(p(n-1));

        % Prevent division by zero
        if fp_n == fp_n1
            fprintf('Error: Zero division detected at iteration %d\n', n);
            return;
        end
        
        % Secant update formula
        p(n+1) = p(n) - fp_n * (p(n) - p(n-1)) / (fp_n - fp_n1);
        
        % Compute error estimate
        fError(n) = abs(p(n+1) - p(n));

        % Display the current iteration, p(n), and the error estimate
        fprintf('n = %d: p(%d) = %.8f, ehat(%d) = %.8e\n', n+1, n+1, p(n+1), n, fError(n));

        % Check convergence condition
        if fError(n) <= epsilon || n >= nMax
            break;
        end

        % Update iteration number
        n = n + 1;
    end

    % Final output
    %if fError(end) <= epsilon
        %fprintf('Converged to root: %.8f after %d iterations.\n', p(end), n);
    %else
        %fprintf('Error: Secant Method did not converge after %d iterations.\n', n);
    %end
end
