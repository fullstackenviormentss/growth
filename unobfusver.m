%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Forest - a Demonstration of Functional MATLAB Programming
%   
%   This program demonstrates several techniques for 
%   functional programming in MATLAB using anonymous functions.
%   This code runs only by executing a single anonymous function,
%   without touching the global workspace at all,
%   and also without the help of external libraries.
%   
%   When executed, this code outputs a figure of a forest, consisting of 9 trees.
%   The number of trees to draw could be changed by changing the constant 9
%   in the end of the code.
%
%   In this code, the following features are implemented:
%   - recursion (and loops)
%   - conditionals (and lazy evaluation)
%   - lexical variables ('let' clause)
%   - execution of multiple statements
%   
%   Technical details
%   - Recursion is implemented by using the Y combinator.
%   - Loops are implemented by tail recursion.
%   - Conditionals are implemented by evaluating a function chosen from a list,
%       where the index number is given by a formula consisting of relational operators.
%   - Lazy evaluation is performed by wrapping an expression with @()
%       and then applying feval at a desired timing.
%   - Lexical variables are implemented by passing constants to a function through its arguments.
%    
%   This program was written by Hikaru Ikuta, in 2014.

%%%%%%%%%%%%%%%%%
%% main program
figure(1),clf,hold('on'),grid('on'),view(58,38),
feval((@ (Y,x) ...
        feval((@ (G) ...
                feval(Y(G), ...
                      x,0,0,floor(sqrt(x)))), ...
              feval((@ (L) ...
                      (@ (M) ...
                         (@ (n,p,q,r) ...
                           feval(feval((@ (list,ind) list{ind}), ...
                                        { (@ () 1),...
                                          (@ () ...
                                             {feval(Y(L), ...
                                                    [floor((n-1)/r)*5^2-5^2*(r-1)/2;mod((n-1),r)*5^2-5^2*(r-1)/2;0], [0;0;1], [1;0;0], 6), ...
                                              M(n-1,0,0,floor(sqrt(x)))})}, ...
                                        (n<=0)*1+~(n<=0)*2))))), ...
                    (@ (drawBranchLambda) ...
                      (@ (u, n, t, N) ...
                        ...% Conditionals, implemented by selecting a desired function from a list (which also uses lazy evaluation)
                        feval(feval((@ (list,ind) ...
                                      list{ind}), ...
                                    { (@() plot3(u(1),u(2),u(3), '*g', 'markersize', 5, 'markerfacecolor', 'g')),...
                                      (@() feval((@(c, b, p, h, C) ...
                                                    { feval((@(a) plot3(a(1,:),a(2,:),a(3,:), '-', 'Color', C(N/6), 'linewidth', N^2*0.3)), ...
                                                            [u,u+n*c]), ...
                                                      feval(@ (f,t1,n1) 
                                                              { drawBranchLambda(u+n*c, n1, t1, N-1), ...
                                                                drawBranchLambda(u+n*c, f(n1,n,p), f(t1,n,p), N-1), ...
                                                                drawBranchLambda(u+n*c, f(n1,n,p*2), f(t1,n,p*2), N-1)}, ...
                                                           (@ (r,n,p) r .* cos(p) + n * (n' * r) * (1 - cos(p)) - cross(r,n) * sin(p)), ...
                                                           n*sin(h) - t*cos(h), ...
                                                           n*cos(h) + t*sin(h))}), ...
                                                 ...% Lexical variables, implemented by passing constants to an anonymous function
                                                 9.8/(7.2-N),0.1,2*pi/3,2*pi/7, ...
                                                 (@ (r) [.32, .22, .08]*r + [0,1,.5]*(1-r))))}, ...
                                    (N<=0)*1+(N>0)*2))))))), ...
      ...% The Y combinator, used for recursion
      (@ (f) ...
        feval((@ (g) ...
                (@ (m,n,o,p) feval(f(g(g)),m,n,o,p))), ...
              (@ (g) ...
                (@ (m,n,o,p) feval(f(g(g)),m,n,o,p))))), ...
      9);
