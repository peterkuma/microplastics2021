function [stRes] = calculate_single_wavelength_size_fibre(lambda,a, h, ForceMethod)
%calculate_single_wavelength_size_fibre Return results for a given lambda, a, h
%   This returns scattering, extinction, absorption, g
%       results.
if(nargin < 4)
    ForceMethod='none';
end
if(any(size(lambda) ~= 1))
    error('lambda must be 1x1')
end
if(any(size(a) ~= 1))
    error('a must be 1x1')
end
if(any(size(h) ~= 1))
    error('h must be 1x1')
end
height = 2*a*h;
cyl_height = height - 2*a;
volume = 4/3*pi*a^3 + cyl_height*pi*a^2;
aequiv = (volume * 3/4/pi)^(1/3);
x = 2*pi*aequiv/lambda;

surface_area = 4*pi*a^2 + 2*pi*cyl_height*a;





    stRes = LargeSizeLimitSingleShotFibre(lambda, a, h);
    stRes.method='Large';

end





function stRes = LargeSizeLimitSingleShotFibre(lambda, a, h)
    %Use large-size approximations
    
    epsilon1 = 1;
    epsilon2 = epsPETfit(lambda);
    s=real(sqrt(epsilon2/epsilon1));
    alphaabs = 4*pi*imag(sqrt(epsilon2/epsilon1))/lambda;
    %Approximations, as from 1997KokhanovskyAO
    stRes.Qext = 2;
    SA = 4*pi*a^2 + 2*(h-1)*a*2*pi*a;
    V = 4/3*pi*a^3 + 2*(h-1)*a*pi*a^2;
    stRes.Cext = 2*(SA/4);
%     b = sqrt(1-(1/s^2));
%     a*(3/4/pi)^(1/3) is volume-equiv sphere radius
    [MPL, g0, ginf, beta, psi] = interpolate_ray_tracing_quantities('pill_mpl.csv', s, h);
    gRT = ginf - (ginf-g0)*exp(-beta * alphaabs); %it's beta*c, but here beta is defined with alphaabs not c
%     CabsLowAbs = alphaabs*MPL*3/2*a^2;
    
    c = alphaabs * 2*3*V/SA;
    
    
    stRes.Cabs = (1-GetLambertianReflectance(s))*(1-exp(-psi*c))*SA/4;
    stRes.Csca = stRes.Cext - stRes.Cabs;
    stRes.albedoRT = 1-stRes.Cabs/(SA/4);
    stRes.g = (stRes.albedoRT*gRT + 1)/(stRes.albedoRT+1);
    stRes.gRT = gRT;
    stRes.a = a;
    stRes.h = h;
    stRes.lambda = lambda;
    stRes.Qext = stRes.Cext / (SA/4);
    stRes.Qabs= stRes.Cabs / (SA/4);
    stRes.Qsca = stRes.Csca / (SA/4);
end
    
 function RF = GetLambertianReflectance(n)

if n==1
    RF=0;
else
    RF = 0.5 + (n-1).*(3*n+1) ./ (6*(n+1).^2) ...
        - 2*n.^3.*(n.^2+2*n-1) ./ ((n.^4-1).*(n.^2+1)) ...
        + 8*n.^4.*(n.^4+1).*log(n) ./ ( (n.^4-1).^2 .* (n.^2+1) ) ...
        + n.^2.*(n.^2-1).^2 .* log( (n-1)./(n+1) ) ./ ((n.^2+1).^3);
    
end
 end

