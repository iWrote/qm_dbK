# qm_dbK
Exploring variational methods in quantum mechanics using Daubechies' wavelets in MATLAB. 


In this project we solve textbook 1D bound-state quantum mechanics problems with wavelet methods to recover known solutions. We've written tutorials (.mlx notebooks in the "sopnotes" dir) to help others quickly reproduce our results and take the project further.

While a Fourier transform creates a representation of a signal in the frequency domain, a wavelet transform creates a representation of the signal in both time (or space!) and frequency domains, thereby allowing efficient access of localized information about the signal.

Intuitively, it tells you not only *what* frequencies are there in your signal, but also *where* they are in space or time.

Now consider a bound-state problem governed by a complicated PDE that you can neither work out on paper nor compute an exact solution for in the entire domain. 
Wavelet methods let you "peek" at the solution *at different resolutions in the regions you care about*. For example, you can produce low resolution solutions to equations describing the outskirts of a molecule, and compute higher resolution solutions in the critical regions.  

![example](https://github.com/iWrote/qm_dbK/blob/master/misc/fit_strange.png)
Picture showing wavelets recovering the profile of a sine wave. This was produced with approximation methods "peeking" at the solutions of the particle-in-a-box PDE.



