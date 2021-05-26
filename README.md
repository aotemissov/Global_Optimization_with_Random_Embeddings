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

### References

Further resources if you want to know learn more about this project: 

* C. Cartis and A. Otemissov. [A dimensionality reduction technique for unconstrained global optimization of functions with low effective dimensionality](https://academic.oup.com/imaiai/advance-article-abstract/doi/10.1093/imaiai/iaab011/6278168), *Information and Inference: A Journal of the IMA*, 2021

* C. Cartis, E. Massart, and A. Otemissov. [Constrained global optimization of functions with low effective dimensionality using multiple random embeddings](https://arxiv.org/abs/2009.10446). 
arXiv e-prints, art. arXiv:2009.10446, 2020

* A. Otemissov. [Dimensionality reduction techniques for global optimization](https://ora.ox.ac.uk/objects/uuid:aa441eb8-c2ad-4da3-abfc-291bb0fdeb1f). PhD thesis, University of Oxford, 2020

### Acknowledgements

This project was funded and supported by the Alan Turing Insitute under The Engineering and Physical Sciences Research Council (EPSRC) grant EP/N510129/1 and the Turing Project Scheme.
