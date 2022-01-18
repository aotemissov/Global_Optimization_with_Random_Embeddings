# Global_Optimization_with_Random_Embeddings

### 1 Introduction

This page contains the descriptions and numerical testing of the REGO (Random Embeddings for Global Optimization) and X-REGO algorithms proposed and analysed in these three papers ([Cartis & Otemissov (2020)](https://arxiv.org/abs/2003.09673), [Cartis et al. (2020)](https://arxiv.org/abs/2009.10446) and [Cartis et al. (2021)](https://arxiv.org/abs/2107.12102)). 

This research uses the ideas of dimensionality reduction prominent in the machine learning community and adapts it for global optimization. Our approach is based on the techniques presented in [Wang et al., 2016](https://arxiv.org/abs/1301.1942) for Bayesian Optimization. 

#### Acknowledgements

This project was funded and supported by the _Alan Turing Insitute_ under _The Engineering and Physical Sciences Research Council (EPSRC)_ grant EP/N510129/1, the _Turing Project Scheme_ (PI: [Coralia Cartis](https://www.maths.ox.ac.uk/people/coralia.cartis)) and by the _National Physical Laboratory_.

#### 1.1 Outline

- Section 1.2 contains the backgorund of global optimization (and its challenges) with references to important works in the field. 
- Section 1.3 gives the overview of our research and provides a brief literature review. 
- Section 2 introduces two dimensionality reduction frameworks (REGO and X-REGO)
- Section 3 decribes the numerical experiments we conducted to test the effectiveness of REGO and X-REGO.
	- Section 3.1 formally outlines the REGO and X-REGO algorithms and proposes different variants of X-REGO.
	- Section 3.2 provides the test set of functions used in the experiments.
	- Section 3.3 describes the global otimization solvers we used in combination with the two frameworks. 
	- Section 3.4 briefly describes the [Dolan and More](https://link.springer.com/article/10.1007/s101070100263)'s performance profile for comparing different algorithms.
	- Section 3.5 describes how our uploaded code is organized. 

#### 1.2 Global Optimization background
Global optimization is a task of determining the most extreme value of a function over a predefined domain. Global optimization has a broad range of applications; examples include portfolio management, protein structure prediction, engineering design, object packing, curve fitting, climate modelling and many more. Unlike local optimization, where one is satisfied with minimizers over a neighbourhood, 
global optimization requires exploration/consideration of the entire feasible domain. This task is commonly associated with large computational costs, 
which often grow exponentially with the dimension of the problem rendering global optimization of high-dimensional functions an extremely challenging problem. 
Along with attempts to devise a generic global optimization algorithm capable of handling high-dimensional problems, 
researchers have also targeted specific classes of functions, which possess some type of structure often encountered in practice. 
The main subclass of problems that are ‘easy’ are convex problems (both the objective function and domain are convex); 
most convex problems of practical importance are solvable in polynomial time and hence tractable ([Nesterov and Nemirovskii, 1994](https://epubs.siam.org/doi/book/10.1137/1.9781611970791?mobileUi=0)). However, real-life problems are often non-convex, 
having multiple local and global extrema, or they are black-box, so that their convexity or lack of, cannot be ascertained a priori.

As for generic global optimization algorithms (which are mostly effective for small dimensional problems), they can be broadly categorized into two groups: deterministic and stochastic. A method is called deterministic if it can provide theoretical guarantees that the value of a produced solution is larger than the value of the true global minimum by at most ![epsilon](https://latex.codecogs.com/svg.latex?%5Cepsilon) for a pre-specified ![epsilon](https://latex.codecogs.com/svg.latex?%5Cepsilon%20%3E%200) ([Liberti and Kucherenko, 2005](https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1475-3995.2005.00503.x)). Stochastic methods, on the other hand, do not provide such guarantees and can only produce probabilistic bounds that the generated solution is indeed global. Some of the most popular global optimization methods include Branch & Bound, random search methods, Bayesian Optimization and multi-start methods.

#### 1.3 What is this research about?

Our research lies at the boundary between optimization and machine learning.  Both fields attract much attention nowadays due to ubiquitous contributions to practical applications. When it comes to the contributions to one another, researchers commonly refer to optimization as a donor that offers huge supply of tools to guide machine learning algorithms; just think of Bayesian Optimization for hyper-parameter tuning ([Shahriari et al., 2016](https://www.cs.ox.ac.uk/people/nando.defreitas/publications/BayesOptLoop.pdf)) or Stochastic Gradient Descent for neural networks ([Montavon et al., 2012](https://link.springer.com/book/10.1007%2F978-3-642-35289-8)). Given the generosity of optimization, researchers began to ask: can machine learning be generous back? Can we use machine learning techniques to tackle optimization problems? These questions inspired the topic of my doctoral research which investigates the effectiveness of a particular machine learning technique called ‘dimensionality reduction’ applied to high-dimensional global optimization problems of a certain class of functions termed functions with low effective dimensionality, which vary only along a few linear directions and are constant along others. These functions appear in applications such as neural networks ([Bergstra & Bengio, 2012](https://www.jmlr.org/papers/volume13/bergstra12a/bergstra12a.pdf)), combinatorial optimization problems ([Hutter et al., 2014](https://proceedings.mlr.press/v32/hutter14.html)), climate modelling ([Knight et al., 2007](https://www.pnas.org/content/104/30/12259)) and complex engineering and physical simulations ([Constantine, 2015](https://epubs.siam.org/doi/pdf/10.1137/1.9781611973860.fm)).
	
For these functions, we are tackling the following optimization problem
<p align="right">
	  <img width="500" src="https://latex.codecogs.com/svg.latex?%5Chspace*%7B%5Cfill%7D%20%5Cmin_%7B%5Cmathbf%7Bx%7D%20%5Cin%20X%7D%20f%28%5Cmathbf%7Bx%7D%29%2C%20%5Chspace*%7B8.5cm%7D%20%28P%29" alt="(P)">
</p>
where X = R^D or X = [-1,1]^D (we address both cases) with large D. 

In general, it is an extremely hard problem (for both cases) therefore the need to impose the structural assumption on f. We tackle (P) in two steps:

* (Reduction step) In the dimensionality reduction step we transform high-dimensional f(**x**) into a lower-dimensional one: let **A** be a predefined D×d matrix, where d ≪ D; we construct g(**y**) := f(**Ay**). 
* (Optimization step) The global optimization of the new function g(**y**) is now more tractable for existing global optimization algorithms. Optimize g(**y**) using any suitable global optimization algorithm and let **y*** be its solution. We recover the corresponding minimizer in the original space by setting **x*** = **Ay***.

The global minimum of f(**x**) may be lost during the reduction process, in other words, minimum of g(**y**) may be different from the global minimum of (P). We say that the reduction has been successful if the global minima of g(**y**) and (P) coincide. The success or failure of the reduction depends chiefly on the choice of matrix **A**. In this regard, different approaches to defining **A** have been proposed; some suggested to define **A** based on the learned structure of f ([Fornasier et al., 2012](https://arxiv.org/abs/1008.3043); [Tyagi & Cevher, 2014](https://arxiv.org/abs/1310.1826)) while others proposed to define A randomly independent of f ([Wang et al., 2016](https://arxiv.org/abs/1301.1942); Binois et al., [2014](https://arxiv.org/abs/1411.3685), [2017](https://arxiv.org/abs/1704.05318)). The latter has the advantage of requiring less computational resources to define **A**. Our work investigates this latter approach for random **A**’s initialized according to Gaussian matrix distribution (each entry of **A** is an i.i.d. standard normal variable). Geometrically, (with such random **A**’s) the reduction constitutes an embedding of a uniformly distributed random d-dimensional linear subspace into R^D and so this reduction technique is called random embeddings. 

The technique of random embeddings was initially proposed in ([Wang et al., 2016](https://arxiv.org/abs/1301.1942)) for Bayesian Optimization, a particular class of global optimization methods. [Wang et al. (2016)](https://arxiv.org/abs/1301.1942) showed that the reduction with random embeddings is successful with probability 1 if d ≥ d_e, where d_e ≪ D is the dimension of the effective subspace of f (along which the function varies). Extending their approach, our work proposes and investigates two frameworks compatible with any global optimization method. The work improves and extends [Wang et al. (2016)](https://arxiv.org/abs/1301.1942)’s theoretical analysis and the analyses existent elsewhere in the literature and validates the theoretical findings by extensive numerical testing some of which we present here.

#### 1.4 Functions with low effective dimensionality

Functions with low effective dimensionality can be defined in at least two ways as presented in [Fornasier et al. (2012)](https://arxiv.org/abs/1008.3043), [Wang et al. (2016)](https://arxiv.org/abs/1301.1942). Since our work is based on [Wang et al. (2016)](https://arxiv.org/abs/1301.1942), we decided to work with their definition given in terms of linear subspaces:  

**Definition (functions with low effective dimensionality)** _A function f : R^D → R has effective dimensionality d_e ≤ D if there exists a linear subspace T of dimension d_e such that for all vectors **x**⊤ in T and **x**⊥ in T⊥ (orthogonal complement of T) we have_

<p align="center">
	  <img width="160" src="https://latex.codecogs.com/svg.latex?f%28%5Cmathbf%7Bx%7D_%7B%5Ctop%7D%20&plus;%20%5Cmathbf%7Bx%7D_%7B%5Cperp%7D%29%20%3D%20f%28%5Cmathbf%7Bx%7D_%7B%5Ctop%7D%29" alt="(P)">
</p>

_and d_e is the smallest integer such that the above equation is satisfied._ 

The linear subspace T is called the effective subspace of f and its orthogonal complement T⊥, the constant subspace of f. It is convenient to think of T⊥ as a subspace of no variation of largest dimension (along which the value of f does not change) and T as its orthogonal complement.

Every vector **x** can be decomposed as **x** = **x**⊤ + **x**⊥, where **x**⊤ and **x**⊥ are orthogonal projections of **x** onto T and T⊥, respectively. In particular, if **x**\* is a global minimizer and f* is the global minimumof f in X then **x**\* =**x**\*⊤+**x**\*⊥ and

<p align="center">
	  <img width="270" src="https://latex.codecogs.com/svg.latex?f%5E*%20%3D%20f%28%5Cmathbf%7Bx%7D%5E*%29%20%3D%20f%28%5Cmathbf%7Bx%7D_%7B%5Ctop%7D%5E*&plus;%5Cmathbf%7Bx%7D_%7B%5Cperp%7D%5E*%29%20%3D%20f%28%5Cmathbf%7Bx%7D_%7B%5Ctop%7D%5E*%29." alt="(P)">
</p>

Moreover, we have 

<p align="center">
	  <img width="190" src="https://latex.codecogs.com/svg.latex?f%5E*%20%3D%20f%28%5Cmathbf%7Bx%7D_%7B%5Ctop%7D%5E*%29%20%3D%20f%28%5Cmathbf%7Bx%7D_%7B%5Ctop%7D%5E*&plus;%5Cmathbf%7Bx%7D_%7B%5Cperp%7D%29" alt="(P)">
</p>

for every vector **x**⊥ in T⊥. This feature of functions with low effective dimensionality implies that the set of global minimizers of f in X, which we call G, contains infinitely many points. In particular, if X = R^D then the set of global minimizers G is an affine subspace of dimension D-d_e. If X is a hyper-box then G is a polytope (see an illustration futher down below). 


### 2 Two frameworks we would like to test

When finding the global minimum of g(**y**) one needs to impose constraints on the problem to avoid search over infinite domain. We propose two different constraints — each for two different domains (i.e., X ∈ R^D and X ∈ [−1, 1]^D ) — resulting in two different frameworks. The first framework named REGO (Random Embeddings for Global Optimization) defines bound constraints in the new variables, i.e., **y** ∈ Y = [−δ, δ]^d for some user-defined δ. The second one named X-REGO imposes the linear constraints **Ay** ∈ X . So, instead of solving high-dimensional (P), we solve

<p align="right">
	  <img width="600" src="https://latex.codecogs.com/svg.latex?%5Cbegin%7Balign*%7D%20%5Cmin_%7B%5Cmathbf%7By%7D%7D%20%26%20%5C%3B%5C%3B%20f%28%5Cmathbf%7BAy%7D%29%20%5C%5C%20%5Ctext%7Bsubject%20to%7D%20%26%20%5C%3B%5C%3B%20%5Cmathbf%7By%7D%20%5Cin%20Y%20%3D%20%5B-%5Cdelta%2C%5Cdelta%5D%5Ed%2C%20%5Cend%7Balign*%7D%20%5Chspace*%7B8cm%7D%20%5Ctext%7B%28RP%29%7D" alt="(P)">
</p>

if the domain X in (P) is given by R^D and solve

<p align="right">
	  <img width="600" src="https://latex.codecogs.com/svg.latex?%5Cbegin%7Balign*%7D%20%5Cmin_%7B%5Cmathbf%7By%7D%7D%20%26%20%5C%3B%5C%3B%20f%28%5Cmathbf%7BAy%7D&plus;%5Cmathbf%7Bp%7D%29%20%5C%5C%20%5Ctext%7Bsubject%20to%7D%20%26%20%5C%3B%5C%3B%20%5Cmathbf%7BAy%7D&plus;%5Cmathbf%7Bp%7D%20%5Cin%20X%20%3D%20%5B-1%2C1%5D%5ED%20%5Cend%7Balign*%7D%20%5Chspace%7B7cm%7D%20%28%5Ctext%7BRPX%7D%29" alt="(P)">
</p>

if the domain X in (P) is given by the hyper-box [-1,1]^D. Here, **p** is a point in X at which we draw a random subspace; it provides additional flexibility that we exploit algorithmically.

#### 2.1 REGO
Due to randomness of **A**, g(**y**) is a random function and so are its global solutions. As mentioned above, the reduction in the unconstrained case is almost surely successful for d ≥ de, but the constraints **y** ∈ Y = [−δ,δ]^d bring about additional impediments to the success of the reduced problem. As the solutions of g(**y**) are random, they are included in Y in probability. Therefore, REGO’s theoretical analysis focuses on determining the nature of the relationship of the parameters of the problem and the probability of successful reduction.

Using tools of Random Matrix Theory, we found that the Euclidean norm of the random global minimizer of g(**y**) follows a(n appropriately scaled) chi-squared distribution with d − d_e + 1 degrees of freedom and, most importantly, that it is independent of large D under certain assumptions. This implies that REGO does not inherit the high computational demands of (P) and this was confirmed by our numerical experiments.

#### 2.2 X-REGO
Unlike REGO, where we draw only one **A**, X-REGO uses multiple random embeddings, solving (RPX) repeatedly, approximately and possibly, adaptively. The reason for using many embeddings is the fact that with embeddings now restricted to be inside the box [−1, 1]^D the probability of successful reduction is decreased. Our theoretical analysis derives a lower bound on this probability in the case when d is equal or larger than d_e. We show that this success probability is positive and that it depends on both the effective subspace and the ambient dimension D. However, in the case when the effective subspace is aligned with the coordinate axes, we show that the dependence on D in this lower bound is at worst polynomial.

Using the success probability of the reduced subproblems, we prove that X-REGO converges globally, with probability one, and linearly in the number of embeddings, to a neighbourhood of a constrained global minimizer. Our numerical experiments on special structure functions illustrate our theoretical findings and the improved scalability of X-REGO variants when coupled with state-of-the-art global — and even local — optimization solvers for the subproblems.

#### Extensions to general objective functions



### 3 Experiments

We perform two experiments. In the first experiment we compare REGO against _no-embedding_ framework in which (P) is solved directly without using random embeddings and with no explicit exploitation of its special structure. In the second experiment, we compare X-REGO against no-embedding.
- Refer to [Coralia & Otemissov (2021)](https://academic.oup.com/imaiai/advance-article-abstract/doi/10.1093/imaiai/iaab011/6278168) for the details of the experimental setup of REGO vs no embedding.
- Refer to [Coralia et al. (2020)](https://arxiv.org/abs/2009.10446) for the details of the experimental setup of X-REGO vs no embedding.

#### 3.1 Algorithms

#### REGO 

Below is the outline of REGO (Random Embeddings for Global Optimization) algorithm applied to (P):


---------------------------------------------------Algorithm 1----------------------------------------------------

1. _Initialise_ d _and_ δ _and define_ Y = [−δ, δ]^d
2. _Generate a_ D × d _Gaussian matrix_ **A**
3. _Apply a global optimization solver (e.g. BARON, DIRECT, KNITRO) to_ (RP) _until a termination criterion is satisfied, and define ymin to be the generated (approximate) solution of_ (RP).
4. _Reconstruct_ x_{min} = Ay_{min}

------------------------------------------------end of Algorithm 1------------------------------------------------

#### X-REGO

Below is the outline of X-REGO (X-Random Embeddings for Global Optimization) algorithm applied to (P):

---------------------------------------------------Algorithm 2----------------------------------------------------

1. _Initialise_ d _and_ **p**^0 ∈ X
2. _for_ k ≥ 1 _until termination do_
3. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_Draw a_ D x d _random Gaussian matrix_ **A**^k
4. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_Calculate_  **y**^k _by solving approximately and possibly, probabilistically,_
<p align="right">
	  <img width="600" src="https://latex.codecogs.com/svg.latex?%5Cbegin%7Balign*%7D%20%5Cmin_%7B%5Cmathbf%7By%7D%7D%20%26%20%5C%3B%5C%3B%20f%28%5Cmathbf%7BA%7D%5Ek%5Cmathbf%7By%7D&plus;%5Cmathbf%7Bp%7D%5E%7Bk-1%7D%29%20%5C%5C%20%5Ctext%7Bsubject%20to%7D%20%26%20%5C%3B%5C%3B%20%5Cmathbf%7BA%7D%5Ek%5Cmathbf%7By%7D&plus;%5Cmathbf%7Bp%7D%5E%7Bk-1%7D%20%5Cin%20X%20%5Cend%7Balign*%7D%20%5Chspace*%7B8cm%7D%20%5Ctext%7B%28RPX%24%5Ek%24%29%7D" alt="(P)">
</p>

5. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _Let_
<p align="center">
	  <img width="150" src="https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%5Ek%20%3A%3D%20%5Cmathbf%7BA%7D%5Ek%20%5Cmathbf%7By%7D%5Ek&plus;%5Cmathbf%7Bp%7D%5E%7Bk-1%7D" alt="(P)">
</p>
	
6. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _Choose (deterministically or randomly)_ **p**^k ∈ X
7. _end for_		

------------------------------------------------end of Algorithm 2------------------------------------------------

We test different variants of X-REGO algorithm against no-embedding. Each variant of X-REGO corresponds to a specific choice of **p**^k, k ≥ 0:

- Adaptive X-REGO (A-REGO). In X-REGO, the point **p**^k is chosen as the best point found up to the k-th embedding: if f(**A**^k**y**^k + **p**^{k−1}) < f(**p**^{k−1}) then **p**^k := **A**^k**y**^k + **p**^{k−1}, otherwise, **p**^k := **p**^{k−1}.
- Local Adaptive X-REGO (LA-REGO). In X-REGO, we solve (RPX^k) using a local solver (instead of a global one as in N-REGO). Then, if |f(**A**^k**y**^k + **p**^{k−1}) − f(**p**^{k−1})| > γ for some small γ (here, γ = 10^{−5}), we let **p**^k := **A**^k**y**^k + **p**^{k−1}, otherwise, **p**^k is chosen uniformly at random in X.
- Nonadaptive X-REGO (N-REGO). In X-REGO, all the random subspaces are drawn at the origin: **p**^k := 0 for all k.
- Local Nonadaptive X-REGO (LN-REGO). In X-REGO, the low-dimensional problem (RPX^k) is solved using a local solver, and the point **p**^k is chosen uniformly at random in X for all k.

#### 3.2 Test set

Our test set of functions with low effective dimensionality is derived from 19 global optimization problems (of dimensions 2–6) with known global minima ([Gavana, n.d.](http://infinity77.net/global_optimization/); [Ernesto & Diliman, 2005](http://www.geocities.ws/eadorio/mvf.pdf); [Surjanovic & Bingham, 2013](https://www.sfu.ca/~ssurjano/optimization.html)), some of which are from the Dixon-Szego set ([Dixon & Szego, 1975](https://catalogue.nla.gov.au/Record/1832800)). The list of the problems is given in Table 1 below.

Below we describe the method adopted from [Wang et al. (2016)](https://arxiv.org/abs/1301.1942) to generate high-dimensional functions with low effective dimensionality. Let h(**x**) be any function in Table 1; let d_e be its dimension and let the given domain be scaled to ![interval](https://latex.codecogs.com/svg.latex?%5B-1%2C1%5D%5E%7Bd_e%7D). We create a D-dimensional function g(**x**) by adding D−d_e fake dimensions to h(**x**), 
<p align="center">
	  <img width="400" src="https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%7D%29%20%3D%20h%28%5Cmathbf%7Bx%7D%29%20&plus;%200%5Ccdot%20x_%7Bd_e&plus;1%7D%20&plus;%200%5Ccdot%20x_%7Bd_e&plus;2%7D&plus;%5Ccdots&plus;0%5Ccdot%20x_D" alt="(P)">
</p>

We further rotate the function by applying a random orthogonal matrix **Q** to **x** to obtain a non-trivial constant subspace. The final form of the function we test is given as
<p align="center">
	  <img width="115" src="https://latex.codecogs.com/svg.latex?f%28%5Cmathbf%7Bx%7D%29%20%3D%20g%28%5Cmathbf%7BQx%7D%29." alt="(P)">
</p>

For each problem in the test set, we generate three functions f as defined above, one for each D = 10, 100, 1000.

#### Table 1

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
[Six-hump camel </br> (Camel)](https://www.sfu.ca/~ssurjano/camel6.html) | ![Camel_x](https://latex.codecogs.com/svg.latex?%5Cbegin%7Balign*%7D%20x_1%20%26%20%5Cin%20%5B-3%2C3%5D%20%5C%5C%20x_2%20%26%20%5Cin%20%5B-2%2C2%5D%20%5Cend%7B%7D) | ![Camel_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-%201.0316)
[Styblinski-Tang](https://www.sfu.ca/~ssurjano/stybtang.html) |![Styblinski_Tang_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B-5%2C5%5D%5E4)| ![Styblinski_Tang_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-%20156.664)
[Trid](https://www.sfu.ca/~ssurjano/trid.html) |![Trid_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B-25%2C25%5D%5E5)| ![Trid_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-%2030)
[Zettl](http://www.geocities.ws/eadorio/mvf.pdf) |![Zettl_x](https://latex.codecogs.com/svg.latex?%5Cmathbf%7Bx%7D%20%5Cin%20%5B-5%2C5%5D%5E2)| ![Zettl_g](https://latex.codecogs.com/svg.latex?g%28%5Cmathbf%7Bx%5E*%7D%29%20%3D%20-%200.00379)

#### 3.3 Solvers 

Below, we give the descriptions of the three state-of-the-art solvers we use to test REGO and X-REGO variants.

DIRECT ([Gablonsky & Kelley, 2001](https://link.springer.com/article/10.1023/A:1017930332101); [Jones et al., 1993](https://link.springer.com/article/10.1007/BF00941892); [Finkel, 2003](http://www2.peq.coppe.ufrj.br/Pessoal/Professores/Arge/COQ897/Naturais/DirectUserGuide.pdf)) version 4.0 (DIviding RECTangles) is a deterministic global optimization solver first introduced in [Jones et al. (1993)](https://link.springer.com/article/10.1007/BF00941892) as an extension of Lipschitzian optimization. DIRECT does not require information about the gradient nor about the Lipschitz constant and, hence, can be used for black-box functions. DIRECT divides the search domain into rectangles and evaluates the function at the centre of each rectangle. Based on the previously sampled points, DIRECT carefully decides what rectangle to divide next balancing between local and global searches. [Jones et al. (1993)](https://link.springer.com/article/10.1007/BF00941892) showed that DIRECT is guaranteed to converge to global minimum, but convergence may sometimes be slow.

BARON ([Sahinidis, 2014](https://minlp.com/downloads/docs/baron%20manual.pdf); [Tawarmalani & Sahinidis, 2005](https://link.springer.com/article/10.1007/s10107-005-0581-8)) version 17.10.10 (Branch- And-Reduce Optimization Navigator) is a branch- and-bound type global optimization solver for non-linear and mixed-integer non-linear programs. To provide lower and upper bounds for each branch, BARON utilizes algebraic structure of the objective function. It also includes a preprocessing step where it performs a multi-start local search to obtain a tight global upper bound. In comparison to other existing global solvers, BARON was demonstrated to be the most robust and fastest (see [Neumaier et al. (2005)](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.64.2670&rep=rep1&type=pdf)). However, BARON accepts only a few (general) classes of functions including polynomial, exponential, logarithmic, etc. and, unlike DIRECT, it is unable to optimize black-box functions.

KNITRO ([Byrd et al., 2006](https://link.springer.com/chapter/10.1007/0-387-30065-1_4)) version 10.3.0 is a large-scale non-linear local optimization solver capable of handling problems with hundreds of thousands of variables. KNITRO allows to solve problems using one of the four algorithms: two interior point type methods (direct and conjugate gradient) and two active set type methods (active set and sequential quadratic programming). In contrast to BARON and DIRECT, which specialize on finding global minima, KNITRO focuses on finding local solutions. Nonetheless, KNITRO has multi-start capabilities, i.e., it solves a problem locally multiple times every time starting from a different point in the feasible domain. It is this feature that we make use of in the experiments.

**Remark**. The experiments are done not to compare solvers but to contrast ‘no-embedding’ with REGO and X-REGO variants. All the experiments were run in MATLAB on the 16 cores (2×8 Intel with hyper-threading) Linux machines with 256GB RAM and 3300 MHz speed.

#### 3.4 Performance profile

We compare the results (for X-REGO experiment) using performance profiles ([Dolan & More (2002)](https://link.springer.com/article/10.1007/s101070100263)), which measure the proportion of problems solved by the algorithm in less than a given budget defined based on the best performance among the algorithms considered. More precisely, for each solver (BARON, DIRECT and KNITRO), and for each algorithm ![](https://latex.codecogs.com/svg.latex?%5Cmathcal%7BA%7D) (the above-mentioned variants of X-REGO and ‘no-embedding’), we record ![](https://latex.codecogs.com/svg.latex?%5Cmathcal%7BN%7D_p%28%5Cmathcal%7BA%7D%29), the computational cost of running algorithm ![](https://latex.codecogs.com/svg.latex?%5Cmathcal%7BA%7D) to solve problem p within accuracy ![](https://latex.codecogs.com/svg.latex?%5Cepsilon). Let ![](https://latex.codecogs.com/svg.latex?%5Cmathcal%7BN%7D_p%5E*) be the minimum computational cost required for problem p by any algorithm ![](https://latex.codecogs.com/svg.latex?%5Cmathcal%7BA%7D). The performance (probability) of algorithm ![](https://latex.codecogs.com/svg.latex?%5Cmathcal%7BA%7D) on the problem set ![](https://latex.codecogs.com/svg.latex?%5Cmathcal%7BP%7D) is defined as

<p align="center">
	  <img width="280" src="https://latex.codecogs.com/svg.latex?%5Cpi_%7B%5Cmathcal%7BA%7D%7D%28%5Calpha%29%20%3D%20%5Cfrac%7B%7C%5C%7B%20p%5Cin%20%5Cmathcal%7BP%7D%3A%5Cmathcal%7BN%7D_p%28%5Cmathcal%7BA%7D%29%20%5Cleq%20%5Calpha%20%5Cmathcal%7BN%7D_p%5E*%20%5C%7D%7C%7D%7B%7C%5Cmathcal%7BP%7D%7C%7D%2C" alt="(P)">
</p>

with performance ratio ![](https://latex.codecogs.com/svg.latex?%5Calpha%20%5Cgeq%201). As each experiment involving random embeddings is repeated five times, we obtain five curves for the corresponding algorithm-solver pairs.

#### 3.5 MATLAB functions' guide

Here, we provide a brief description of the roles of uploaded files. 

- _main.m_ - the main MATLAB file which initiates the REGO and X-REGO experiments
- _solvers_REGO.m_ - 
- _solveers_XREGO.m_ - 
- _solvers_no_emb_vs_REGO.m_
- _solvers_no_emb_vs_XREGO.m_
- _Matrices_Q.mat_ - contains the entries of orthogonal **Q** matrices created for each function in the test set (refer to Section 3.2 above)
- _list_of_functions_ - a text file that contains a list of functions that the user would like to solve

- _Complementary_functions/DIRECT_with_linear_constraints.m_ - a special function created for X-REGO experiments with DIRECT solver to deal with linear constraints 
- _Complementary_functions/Test_set.m_ - contains the list of high-dimensional functions (created as described in Section 3.2) that we are testing. 
- _Complementary_functions/Extract_function.m_ - this function is essentially Table 1, it helps to extract information about the initial low-dimensional function  (from which the repsective high-dimensional functions were created).
- _Complementary_functions/tight_subplot.m_ - this function allows to draw multiple subplots in a plot. This function was created by Pekka Kumpulainen (2022). tight_subplot(Nh, Nw, gap, marg_h, marg_w) (https://www.mathworks.com/matlabcentral/fileexchange/27991-tight_subplot-nh-nw-gap-marg_h-marg_w), MATLAB Central File Exchange. Retrieved January 17, 2022.

- _plots_generator/Plots_generator\_"name of framework"\_"name of solver".m_ - this function draws the figures which visualize the data for the "name of framework" vs no embedding experiment for "name of solver" solver. 
- In addition, in plots_generator directory there are numerous Results mat files which contain the data for our experiments. 

**Remark**. For the above code to run successfully, you need to include the codes (files) of the respective solvers in the MATLAB path. BARON and KNITRO are commercial solvers. Check out their websites: [BARON](https://minlp.com/baron-solver), [KNITRO](https://www.artelys.com/solvers/knitro/). Visit [this website](https://ctk.math.ncsu.edu/Finkel_Direct/) to get the DIRECT solver which should be free of charge. However, note that to generate the plots based on our data, you don't need the solvers. 

### Main references

This work is based on the following articles and a thesis: 

* C. Cartis and A. Otemissov. [A dimensionality reduction technique for unconstrained global optimization of functions with low effective dimensionality](https://academic.oup.com/imaiai/advance-article-abstract/doi/10.1093/imaiai/iaab011/6278168), *Information and Inference: A Journal of the IMA*, 2021

* C. Cartis, E. Massart, and A. Otemissov. [Constrained global optimization of functions with low effective dimensionality using multiple random embeddings](https://arxiv.org/abs/2009.10446). 
arXiv e-prints, art. arXiv:2009.10446, 2020

* A. Otemissov. [Dimensionality reduction techniques for global optimization](https://ora.ox.ac.uk/objects/uuid:aa441eb8-c2ad-4da3-abfc-291bb0fdeb1f). PhD thesis, University of Oxford, 2020

