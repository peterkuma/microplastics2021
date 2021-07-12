# Create a matlab script to call SIE
# Second version - calls a function to do the simulation
#
require(stringr)
create_sie_script <- function(index){
  input_script <- r"-(
inparams = dlmread('fibre_LSA_params.txt', ' ');
lambdas = inparams(:, 1);
aa = inparams(:, 2);
hh = inparams(:, 3);

THIS_INDEX = $INDEX$;
lambda = lambdas(THIS_INDEX);
a = aa(THIS_INDEX);
h = hh(THIS_INDEX);

sOutFilename = sprintf('LSA_output/LSA_a_%1.3f_h_%1.3f_l_%1.3f.csv', a, h, lambda);




 stRes = calculate_single_wavelength_size_fibre(lambda, a, h)
 res = [lambda, a, h, stRes.g, stRes.Qsca, stRes.Qext, stRes.Qabs, 0]


 csvwrite(sOutFilename, res);

quit(0);
)-"

  index_s <- sprintf("%d", index)


  replaced_script <- input_script %>% str_replace_all(c("\\$INDEX\\$" = index_s))
  invisible(replaced_script)
}
