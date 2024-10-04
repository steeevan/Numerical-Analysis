function [] = H04_Q01()
p1 = input("Enter a value for p1:" );
anon = input("Enter an anonymous function g: ");
alpha = input("Enter a value for alpha: ");



end

function [] = FPI(g,p1,nMax,epsilon)
     n = 1;
     p(n) = p1;
     fERROR_EST = inf;
     while fERROR_EST > epsilon && n < nMax
         n = n + 1;
         p(n) = g(p(n-1));
         
     end

end