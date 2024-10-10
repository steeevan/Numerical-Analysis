function [] = H06Q06()
    % Function to get input from user
    p1 = input('Enter a value for p1: ');
    f = input('Enter an anonymous function f: ');
    fprime = input('Enter an anonymous function f'': ');
    fdprime = input('Enter an anonymous function f'''': ');
    epsilon = input('Enter a value for epsilon: ');
    nMax = input('Enter a maximum value for n: ');

    ModifiedNewtonMethod(f,fprime,fdprime,p1,epsilon,nMax);

end

function [] = ModifiedNewtonMethod(f, fprime, fdoubleprime, p1, epsilon, nMax)
    % Modified Newton's Method Approach 1

    % Initialize variables
    p(1) = p1; % Initial guess
    n = 1;     % Iteration count starts at 1

    % Loop until convergence or reaching max iterations
    while n < nMax
        % Compute first and second derivatives at p(n)
        fp_value = fprime(p(n));
        fpp_value = fdoubleprime(p(n));

        % Check for division by zero in the second derivative
        if fpp_value == 0
            fprintf('Error: Division by zero in the second derivative at p(%d) = %.8f\n', n, p(n));
            return;
        end

        % Modified Newton's Method iteration step
        p(n+1) = p(n) - fp_value / fpp_value;

        % Calculate the error estimate (difference between successive p values)
        ehat = abs(p(n+1) - p(n));

        % Print the iteration, p(n+1), and the error estimate
        fprintf('n = %d: p(%d) = %.8f, ehat(%d) = %.8e\n', n+1, n+1, p(n+1), n, ehat);

        % Break if the error is smaller than the tolerance (epsilon)
        if ehat <= epsilon
            break;
        end

        % Update iteration count
        n = n + 1;
    end

    % Final output after convergence
    fprintf('Converged to root: %.8f after %d iterations.\n', p(end), n);
end

















