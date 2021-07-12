function epsPET = epsPETfit(lambda)
% Returns the wavelength-dependent relative dielectric function of
% microplastics using the fit from Peter.



lm=lambda/1e9; % [m]
loglm=log10(lm);
A=1.41;
B=1.06e-7;
c0=552.717  ;
c1=458.983;
c2=140.513;
c3=18.8141;
c4=0.926965;
extcoeff = 10.^(c0+loglm.*(c1+loglm.*(c2+loglm.*(c3+loglm*c4))));
epsPET = (sqrt(1 + A*lm.^2./(lm.^2-B.^2)) + 1i*extcoeff).^2;

% if ~isempty(find(lambda<399.99,1))
%     epsPET(lambda<399.99) = epsPETfit(400);
% end
if ~isempty(find(lambda>100000,1))
    epsPET(lambda>100000) = epsPETfit(100000);
end
if ~isempty(find(lambda<400,1))
    epsPET(lambda< 400) = epsPETfit(400);
end
