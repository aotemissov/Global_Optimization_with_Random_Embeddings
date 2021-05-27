# Global_Optimization_with_Random_Embeddings

[![purple-pi](https://img.shields.io/badge/Rendered%20with-Purple%20Pi-bd00ff?style=flat-square)](https://github.com/nschloe/purple-pi?activate)

### Description

### Global Optimization background
Global optimization is a task of determining the most extreme value of a function over a predefined domain. Global optimization has a broad range of applications; examples include portfolio man- agement, protein structure prediction, engineering design, object packing, curve fitting, climate modelling and many more. Unlike local optimization, where one is satisfied with minimizers over a neighbourhood, 
global optimization requires exploration/consideration of the entire feasible domain. This task is commonly associated with large computational costs, 
which often grow exponentially with the dimension of the problem rendering global optimization of high- dimensional functions an extremely challenging problem. 
Along with attempts to devise a generic global optimization algorithm capable of handling high-dimensional problems, 
researchers have also targeted specific classes of functions, which possess some type of structure often encountered in practice. 
The main subclass of problems that are ‘easy’ are convex problems (both the objective function and domain are convex); 
most convex problems of practical importance are solvable in polynomial time and hence tractable ([Nesterov and Nemirovskii, 1994](https://epubs.siam.org/doi/book/10.1137/1.9781611970791?mobileUi=0)). However, real-life problems are often non-convex, 
having multiple local and global extrema, or they are black-box, so that their convexity or lack of, cannot be ascertained a priori.

As for generic global optimization algorithms (which are mostly effective for small dimensional problems), they can be broadly categorized into two groups: deterministic and stochastic. A method is called deterministic if it can provide theoretical guarantees that the value of a produced solution is larger than the value of the true global minimum by at most ![epsilon](https://latex.codecogs.com/svg.latex?%5Cepsilon) for a pre-specified ![epsilon](https://latex.codecogs.com/svg.latex?%5Cepsilon%20%3E%200) ([Liberti and Kucherenko, 2005](https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1475-3995.2005.00503.x)). Stochastic methods, on the other hand, do not provide such guarantees and can only produce probabilistic bounds that the generated solution is indeed global. Some of the most popular global optimization methods include Branch & Bound, random search methods, Bayesian Optimization and multi-start methods.



### A technique of Random Embeddings

### Algorithms

### Test set

Function | Domain | Global minimum 
--- | :-: | :-: | 
[Beale](https://www.sfu.ca/~ssurjano/beale.html) | ![Beale_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B-4.5%2C4.5%5D%5E2) | ![Beale_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%200) 
[Branin](https://www.sfu.ca/~ssurjano/branin.html) | ![Branin_x](https://latex.codecogs.com/svg.latex?%5Cbegin%7Balign*%7Dx_1%20%26%20%5Cin%20%5B-5%2C10%5D%5C%5C%20x_2%20%26%20%5Cin%20%5B0%2C15%5D%20%5Cend%7Balign*%7D) | ![Branin_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%200.397887)
[Brent](http://infinity77.net/global_optimization/test_functions_nd_B.html#go_benchmark.Brent) | ![Brent_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B-10%2C10%5D%5E2) | ![Brent_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%200)
[Bukin N6](https://www.sfu.ca/~ssurjano/bukin6.html)| ![BukinN6_x](https://latex.codecogs.com/svg.latex?%5Cbegin%7Balign*%7D%20x_1%20%26%20%5Cin%20%5B-15%2C-5%5D%20%5C%5C%20x_2%20%26%20%5Cin%20%5B-3%2C3%5D%20%5Cend%7B%7D) | ![BukinN6_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%200) 
[Easom](https://www.sfu.ca/~ssurjano/easom.html) |![Easom_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B-100%2C100%5D%5E2)| ![Easom_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-1)
[Goldstein-Price](https://www.sfu.ca/~ssurjano/goldpr.html) | ![Goldstein_Price_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B-2%2C2%5D%5E2) | ![Goldstein_Price_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%203)
[Hartmann 3](https://www.sfu.ca/~ssurjano/hart3.html) | ![Hartmann3_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B0%2C1%5D%5E3) | ![Hartmann3_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-%203.86278)
[Hartmann 6](https://www.sfu.ca/~ssurjano/hart6.html) |![Hartmann6_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B0%2C1%5D%5E6) | ![Hartmann6_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-%203.32237)
[Levy](https://www.sfu.ca/~ssurjano/levy.html) | ![Levy_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B-10%2C10%5D%5E4) | ![Levy_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%200)
[Perm 4, 0.5](https://www.sfu.ca/~ssurjano/permdb.html) | ![Perm_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B-4%2C4%5D%5E4) | ![Perm_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%200)
[Rosenbrock](https://www.sfu.ca/~ssurjano/rosen.html) | ![Rosenbrock_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B-5%2C10%5D%5E3) | ![Rosenbrock_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%200)
[Shekel 5](https://www.sfu.ca/~ssurjano/shekel.html) | ![Shekel5_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B0%2C10%5D%5E4) | ![Shekel5_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-%2010.1532)
[Shekel 7](https://www.sfu.ca/~ssurjano/shekel.html) |![Shekel7_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B0%2C10%5D%5E4)|![Shekel7_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-%2010.4029)
[Shekel 10](https://www.sfu.ca/~ssurjano/shekel.html) |![Shekel10_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B0%2C10%5D%5E4)|![Shekel10_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-%2010.5364)
[Shubert](https://www.sfu.ca/~ssurjano/shubert.html) | ![Shubert_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B-10%2C10%5D%5E2) | ![Shubert_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-%20186.7309)
[Six-hump camel](https://www.sfu.ca/~ssurjano/camel6.html) | ![Camel_x](https://latex.codecogs.com/svg.latex?%5Cbegin%7Balign*%7D%20x_1%20%26%20%5Cin%20%5B-3%2C3%5D%20%5C%5C%20x_2%20%26%20%5Cin%20%5B-2%2C2%5D%20%5Cend%7B%7D) | ![Camel_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-%201.0316)
[Styblinski-Tang](https://www.sfu.ca/~ssurjano/stybtang.html) |![Styblinski_Tang_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B-5%2C5%5D%5E4)| ![Styblinski_Tang_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-%20156.664)
[Trid](https://www.sfu.ca/~ssurjano/trid.html) |![Trid_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B-25%2C25%5D%5E5)| ![Trid_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-%2030)
[Zettl](http://www.geocities.ws/eadorio/mvf.pdf) |![Zettl_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B-5%2C5%5D%5E2)| ![Zettl_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-%200.00379)

### References

Further resources if you want to know learn more about this project: 

* C. Cartis and A. Otemissov. [A dimensionality reduction technique for unconstrained global optimization of functions with low effective dimensionality](https://academic.oup.com/imaiai/advance-article-abstract/doi/10.1093/imaiai/iaab011/6278168), *Information and Inference: A Journal of the IMA*, 2021

* C. Cartis, E. Massart, and A. Otemissov. [Constrained global optimization of functions with low effective dimensionality using multiple random embeddings](https://arxiv.org/abs/2009.10446). 
arXiv e-prints, art. arXiv:2009.10446, 2020

* A. Otemissov. [Dimensionality reduction techniques for global optimization](https://ora.ox.ac.uk/objects/uuid:aa441eb8-c2ad-4da3-abfc-291bb0fdeb1f). PhD thesis, University of Oxford, 2020

### Acknowledgements

This project was funded and supported by the Alan Turing Insitute under The Engineering and Physical Sciences Research Council (EPSRC) grant EP/N510129/1 and the Turing Project Scheme.
