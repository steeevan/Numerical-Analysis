function [] = H03_Q02()

    e1 = input('Enter a value for a: '); % Not used in iteration
    e2 = input('Enter a value for b: '); % Not used in iteration

    ep = input('Enter a value for epsilon:');

    f = @(x) x^2 - 5;
    false_position(e1,e2,f,ep);


end
function false_position2(a,b,f,ep)
    a(1) = a;
    b(1) = b;
    p = [];
    ehat = [];
    
end
function [] = false_position(a0, b0, f, ep)
    % False Position Method to find the root of the function f in the interval [a0, b0]
    %
    % Inputs:
    %   a0 - Initial left endpoint of the interval [a0, b0]
    %   b0 - Initial right endpoint of the interval [a0, b0]
    %   f  - Function handle for the equation to be solved
    %   ep - Desired tolerance (epsilon) for the root accuracy
    %
    % Output:
    %   Prints each iteration showing the interval, root approximation, error estimate, and signs of f(a), f(b), and f(p).
    
    % Initialize vectors for storing a, b, p values
    a = [a0];  % Vector for storing left endpoints
    b = [b0];  % Vector for storing right endpoints
    p = [];    % Vector for storing root approximations
    ehatn = [1e-6 1e-6]; % Vector for storing error estimates

    % Iterative method to find the root
    n = 0;  % Initialize the iteration counter

    while abs(b(end) - a(end)) > ep  % Stopping condition based on tolerance
        n = n + 1;
        
        % Calculate p_n using the False Position Method formula
        p_n = (a(end) * f(b(end)) - b(end) * f(a(end))) / (f(b(end)) - f(a(end)));
        p = [p, p_n];  % Append new p_n to the vector
        
        % Calculate error estimate only when n >= 3
        if n >= 3
            ehatn_n = abs(p(end) - p(end-1));  % Error estimate
        else
            ehatn_n = 10 * eps;  % Default error value for n < 3
        end
        ehatn = [ehatn, ehatn_n];  % Append new error estimate to the vector
        
        % Print the current iteration with the desired format
        fprintf('n = %d: an = %0.8f, pn = %0.8f, bn = %0.8f, ehatn = %0.8f, sign(f(an)) = %d, sign(f(pn)) = %d, sign(f(bn)) = %d\n', ...
            n, a(end), p(end), b(end), ehatn(end), sign(f(a(end))), sign(f(p(end))), sign(f(b(end))));
        
        % Update the interval based on the sign of f(p_n)
        if sign(f(a(end))) ~= sign(f(p_n))
            b = [b, p_n];  % Root is in the left subinterval
            a = [a, a(end)];  % Append the current value of a to the vector
        else
            a = [a, p_n];  % Root is in the right subinterval
            b = [b, b(end)];  % Append the current value of b to the vector
        end
        
        % Check if the desired accuracy has been reached
        if abs(f(p_n)) < ep
            fprintf('Root found at pn = %0.8f after %d iterations.\n', p_n, n);
            break;
        end
    end
    
    % Print the final root
    fprintf('The approximate root is pn = %0.8f after %d iterations.\n', p(end), n);
end
