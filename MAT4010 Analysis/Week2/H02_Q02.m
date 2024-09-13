function [] = H02_Q02()
    
    f = @(x) x^2 - 5;
    
    a = input('Enter a value for a: ');
    b = input('Enter a value for b: ');
    ep= input('Enter a value for epsilon: ');

    bisection(a,b,f,ep);
    
end


 %{
function [] = bisection(a,b,f,ep)
   
    an(1) = a;
    bn(1) = b;
    nMax = ceil(log2((b-a)/ep));
    fprintf('This is nMax-> %0.2f\n',nMax);
    
    %p = zeros(1,nMax);

    for n=1:nMax

        pn(n) = (an(n) + bn(n)) / 2;

        if sign(f(an(n))) ~= sign(f(bn(n)))
            an(n+1) = an(n);
            bn(n+1) = pn(n);
        else
            an(n+1) = pn(n);
            bn(n+1) = bn(n);
        end

        fprintf('n = %d: an = %f, pn = %f, bn = %f, sign(f(an)) = %d, sign(f(pn)) = %d, sign(f(bn)) = %d\n',n,an(n),pn(n),bn(n),sign(f(an(n))),sign(f(pn(n))),sign(f(bn(n))));
    end
   %}
function [] = bisection(a, b, f, ep)
    % Bisection Method to find root of function f in the interval [a, b]
    % a - starting point of the interval
    % b - end point of the interval
    % f - function handle
    % ep - desired tolerance (epsilon)

    nMax = ceil(log2((b - a) / ep));  % Maximum iterations needed
    fprintf('This is nMax -> %d\n', nMax);
    
    % Pre-allocate space for variables
    p = zeros(1, nMax);   % Midpoints
    a_values = zeros(1, nMax);  % a(n) values
    b_values = zeros(1, nMax);  % b(n) values
    
    % Store initial values
    a_values(1) = a;
    b_values(1) = b;
    
    % Iterative method to find the root
    for n = 1:nMax
        p(n) = (a + b) / 2;  % Midpoint of the current interval
        
        % Store current a(n), b(n)
        a_values(n) = a;
        b_values(n) = b;

        % Print the iteration details
        fprintf('n = %d: a = %f, p = %f, b = %f, f(a) = %f, f(p) = %f, f(b) = %f\n', ...
            n, a, p(n), b, f(a), f(p(n)), f(b));

       

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
    fprintf('Approximate root after %d iterations: %f\n', nMax, p(n));

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
        xlabel('Iteration (n)');
        ylabel('$\bar{\alpha}_n$', 'interpreter', 'latex');
        title('Convergence rate approximation \bar{\alpha}_n vs n');
        grid on;
    else
        fprintf('Not enough error bounds to compute \alpha values.\n');
    end
end
