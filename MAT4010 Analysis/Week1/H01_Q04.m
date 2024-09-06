function [] = H01_Q04()

    % Prompt user for input values
    e1 = input('Enter a value  for e1: ');
    e2 = input('Enter a value  for e2: ');
    e3 = input('Enter a value  for e3: ');
    
    alph = input('Enter a value for alpha: ');
    lambda = input('Enter a value for lambda: ');
    epsilon = input('Enter a value for epsilon: ');


    % initialize the error for the first iteration
    en = e3;
    iterations = 3;
    
    while en >= epsilon
        en = lambda * en^alph;
        fprintf('n = %d gives e(%d) = %0.2e\n',iterations,iterations + 1, en)
        iterations = iterations + 1;

    end

    fprintf('We expect approximately %d iterations to be required', iterations);


end