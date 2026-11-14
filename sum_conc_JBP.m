function count = sum_conc_JBP(name,mtrx,dmin,dmax)
%-------------------------------------------------------------------------%
% Evaluates the total number concentration of the particle size
% distributions (DMPS file). The used method is the siectional integration.
%
% The used form sum_conc(name,mtrx,dmin,dmax)
% name = any string (dummy)
% mtrx = a dmps file already loaded in the workspace
% dmin = lower limit of integration (minimum diameter)
% dmax = upper limit of integration (maximum diameter)
%
%   Tareq Hussein, October 2002.
%   Renamed by Jakob Pernov 2026 to distingush between original file and my
%   version, no changes were made
%-------------------------------------------------------------------------%
[m n]   = size(mtrx);
dp      = log10(mtrx(1,2:n))';
conc    = mtrx(2:m,2:n);
%Checking dmin and dmax against spectra limits
dmin    = max(log10(dmin),dp(1));
dmax    = min(log10(dmax),dp(n-1));
%Dense diameter grid
step = 0.01;
dpi = [dmin:step:dmax]';
%Interpolating to dense grid
count   = nansum(interp1(dp,conc',dpi,'nearest')*step)';
%-------------------------------------------------------------------------%
