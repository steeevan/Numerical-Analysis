function [] = H05_Q02()
    % Function to get input from user
    p1 = input('Enter a value for p1: ');
    f = input('Enter an anonymous function f: ');
    fprime = input('Enter an anonymous function f'': ');
    epsilon = input('Enter a value for epsilon: ');
    nMax = input('Enter a maximum value for n: ');

    NewtonMethod(f,fprime,p1,epsilon,nMax);

end

function [] = NewtonMethod(f, fprime, p1, epsilon, nMax)
    % Newton's Method Function
    
    n = 1;
    p(n) = p1; % Initial guess
    fError(n) = inf; % Initialize the error estimate vector
    alpha(n) = 2; % Given value for alpha

    % Loop until convergence or reaching max iterations
    while true
        % Newton's Method update: p(n) = p(n-1) - f(p(n-1)) / fprime(p(n-1))
        fp_value = fprime(p(n));
        
        % Check if the derivative is zero to prevent division by zero
        if fp_value == 0
            %fprintf('Error: Derivative is zero at p(%d) = %.8f, unable to continue.\n', n, p(n));
            return;
        end
        g = @(x) x - f(x) ./ fprime(x);
         
        % Update iteration number
        n = n + 1;
        p(n) = g(p(n-1));

        % Compute the initial error estimate
        fError(n) = abs(p(n) - p(n-1));
        % Compute error estimate
        if n < 2
            fError(n-1) = 10 * epsilon; % Use 10ε for the first iteration where error can't be computed
        else
            fError(n-1) = abs(p(n) - p(n-1));
        end
        if n >= 3
            alpha(n) = (log(fError(n)) - log(fError(n-1)))/ (log(fError(n-1)) - log(fError(n-2)));
        end
        % Display the current iteration, p(n), and the error estimate starting from n=2
        fprintf('n = %d: p(%d) = %.8f, ehat(%d) = %.8e\n', n, n, p(n), n-1, fError(n-1));

        % Check convergence condition
        if fError(n-1) <= epsilon || n >= nMax
            break;
        end
    end

    % Final output
    if fError(end) <= epsilon
        %fprintf('Converged to root: %.8f after %d iterations.\n', p(n), n);
    else
        fprintf('Error: Newton’s Method did not converge\n');
    end
    % Plot p(n) vs n
    figure;
    plot(1:n, p(1:n), '-o');
    xlabel('n');
    ylabel('p_n');
    title( sprintf( 'Newton''s Method for f(x) = %s', func2str(f) ) );
    grid on;

    % Plot 2: fError(n) vs fError(n-1)
    figure;
    if length(fError) > 1
        plot(fError(1:end-1), fError(2:end), '-o');
        xlabel('$\hat{e}_{n-1}$', 'interpreter', 'latex');
        ylabel('$\hat{e}_{n}$', 'interpreter', 'latex');
        title(sprintf( 'Newton''s Method for f(x) = %s', func2str(f) ));
        grid on;
    else
        warning(sprintf( 'Newton''s Method for f(x) = %s', func2str(f) ));
    end

   %  Plot 3: alpha vs n
    figure;
    if ~isempty(alpha)
        valid_indices = find(~isnan(alpha));
        plot(valid_indices + 2, alpha(valid_indices), '-o'); % Plot from n = 3 onwards
        xlabel('Iteration Number (n)');
        ylabel('$\hat{\alpha}_n$', 'interpreter', 'latex');
        title('Newton''s Method: Convergence Rate Estimate $\hat{\alpha}_n$ vs Iteration Number', 'interpreter', 'latex');
        grid on;
    else
        warning('Not enough error estimates to generate the third plot.');
    end
end