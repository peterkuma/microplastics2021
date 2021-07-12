library(Rpathlength)
library(dplyr)

asym_params <- list(Nray=1e6, alphasca=0, n2=seq(from=1.5, to=1.8, by=0.05), h=10^seq(from=0, to=log10(1000), length.out=50), shape=0, max_its=-1, alphaabs_small=1e-3)
asym_res <- run_over_parameters(asymmetry_parameter_worker, asym_params, filename = "mpl_interp_10.rds", rerun=T, force_seed = T, seed_base = 1876, nthreads = 1)
asym_res %>% select(n2, h, lmean, g0, ginf, beta, psi) %>% write.table(file="pill_mpl.csv", row.names = F, col.names=F, sep=',')

