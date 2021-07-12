function [mean_path_length, g0, ginf, beta, psi] = interpolate_ray_tracing_quantities(sFilename, s, h)
%interpolate_ray_tracing_quantities Interpolate the mean path length, g_0,
%g_inf, beta (latter as in (10) in 1997KokhanovskyAO)
%   Given a csv file with the data(<l> g0, ginf, beta, psi), a relative
%   refractive index s, and an aspect ratio h, interpolate new data values
%   s should vary faster than h
% Colums should be ordere s, h, <l>, g0, ginf, beta, psi
if(~ exist(sFilename, 'file'))
    error(['File ', sFilename, ' does not exist']);
end
%Format is s, h, MPL, g0, ginf, beta
input_data = csvread(sFilename);
s_vals=input_data(:, 1);
h_vals=input_data(:, 2);
MPL_vals=input_data(:, 3);
g0_vals=input_data(:, 4);
ginf_vals=input_data(:, 5);
beta_vals=input_data(:, 6);
psi_vals=input_data(:, 7);
% dtable = table(s_vals, h_vals, MPL_vals, 'VariableNames', {'lmean', 's', 'h'})
s_v = unique(s_vals);
h_v = unique(h_vals);
[sg, hg] = meshgrid(s_v, h_v);
MPLg = reshape(MPL_vals, size(sg.')).';
g0g = reshape(g0_vals, size(sg.')).';
ginfg = reshape(ginf_vals, size(sg.')).';
betag = reshape(beta_vals, size(sg.')).';
psig = reshape(psi_vals, size(sg.')).';
mean_path_length = interp2(sg, hg, MPLg, s, h);
g0 = interp2(sg, hg, g0g, s, h);
ginf = interp2(sg, hg, ginfg, s, h);
beta = interp2(sg, hg, betag, s, h);
psi = interp2(sg, hg, psig, s, h);
end

