# Two-Parameter Bathtub-Shaped Lifetime Distribution (Code Implementation)

## Overview

This repository contains an **independent implementation of computational methods** for a **two-parameter lifetime distribution** capable of exhibiting **bathtub-shaped** or **monotonically increasing hazard rates**.

⚠️ **Important note:**  
The **distributional model and theoretical results were not developed by the author of this repository**.  
This repository **only implements the methods described in the original study**, with the goal of:
- Reproducibility
- Methodological validation
- Computational experimentation

No claim of authorship over the proposed distribution is made.

---

## Model Description

The implemented model is a two-parameter lifetime distribution defined through its cumulative distribution function (CDF):

\[
F(x) = 1 - \exp\left[\lambda \left(1 - e^{x^\beta}\right)\right], 
\quad x > 0,\; \beta > 0,\; \lambda > 0
\]

The corresponding functions implemented in code include:
- Probability density function (PDF)
- Survival function
- Hazard function

The model is flexible enough to capture **bathtub-shaped** as well as **increasing failure rate** behaviors depending on the parameter values.

---

## Scope of Implementation

The repository focuses exclusively on **computational implementation**, including:

### 1. Random Variate Generation
- Inverse transform sampling derived from the published formulation
- Custom random number generator for simulation purposes

### 2. Likelihood-Based Inference
- Log-likelihood functions for:
  - Complete data
  - Right-censored survival data
- Maximum Likelihood Estimation (MLE)
- Numerical optimization routines
- Observed information matrix for standard error estimation

### 3. Monte Carlo Simulation Framework
- Simulation under multiple sample sizes
- Performance metrics:
  - Bias
  - Mean Squared Error (MSE)
  - Absolute Percentage Error (APE)
  - Coverage Probability (CP)

> Simulation results and numerical tables are **not included** in this repository.

### 4. Application and Model Fitting Code
- Fitting the distribution to lifetime datasets
- Comparison of fitted hazard and survival functions
- Integration with standard survival analysis workflows

---

---

## Reproducibility

- All numerical procedures are fully scripted
- Results are reproducible given the same data and random seeds
- Code is modular and intended for extension or verification studies

---

## Intended Use

This repository is intended for:
- Researchers verifying published lifetime distributions
- Students learning survival model implementation
- Methodological replication studies
- Simulation-based validation of parametric lifetime models

It is **not** intended to serve as the original source of the distribution.

---

## Citation

Please cite the **original paper proposing the distribution** when using this code for academic work.  
A citation entry will be added once bibliographic details are finalized.

---

## Disclaimer

The author of this repository **does not claim ownership** of the underlying statistical model.  
All credit for the distribution's theoretical development belongs to the original authors.
