function [] = HW1_Q01()
%
%
%
%
%
%   
    a = input('Enter the value for a: ');
    x1 = input('Enter the value for x1: ');
    epsilon = input('Enter the value for epsilon: ');
    nMax = input('Enter the value for nMax: ');

    sqrRoot(a,x1,epsilon,nMax);

end


function [] = sqrRoot(a, x1, epsilon, nMax)
%
%
%
%
%   
    fprintf('%0.2f - %0.2f - %0.2f - %0.2f',a,x1,epsilon,nMax);
end

% git activated
