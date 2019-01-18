function intensityImg = intensityDiff(source, aperture, screen)
% intensityDiff     calculates the intensity distribution of rectangular aperture Fraunhofer diffraction
% NOTE that all units of length are meters
%
%   intensityImg = intensityDiff(source, aperture, screen) gives the image of intensity distribution on a light screen, determined by the given light source, aperture and screen parameters
%
%       source: 1*1 struct describing the monochromatic light source
%           source.lambda:  light source (center) wavelength, a number in unit of meters
%           source.k:       light source wavelength in vaccuum, a number in meter^(-1)
%           source.Iabs:    light source absolute intensity at the aperture, a number, this number determines the actual value of matrix intensityImg
%           source.Irel:    light source relative intensity modulus
%
%       aperture: 1*1 struct describing the rectangular aperture
%           aperture.a:     rectangular aperture size along axis X, a number in meters
%           aperture.b:     rectangular aperture size along axis Y, a number in meters
%
%       screen: 1*1 struct describing the light screen and image
%           screen.Dp:      light screen distance from aperture, a number in meters
%           screen.lim:     light screen size on each axis side, a number in meters, so the calculation range is [-lim, lim] meter for axis X and Y
%           screen.dim:     image dimension, a number, so the image size is dim*dim pixel
%           screen.res:     image resolution, a number in unit of meter/pixel
%
%       intensityImg: a dim*dim*1 array of number, the image of absolute intensity distribution
%
%   by ChiGamma, 2018


% initialize image
x = -screen.lim : screen.res : screen.lim;                  % screen coordinates range and resolution decides the calculation units thus the image
y = x ;

% intermediate variable
I00 = (aperture.a * aperture.b / source.lambda / screen.Dp)^2 * source.Iabs * source.Irel;    % absolute intensity at screen center (0,0) (the brightest on screen)
alph = source.k * aperture.a * x ./(2*pi * screen.Dp);      % periodic parameter on X axis
beta = source.k * aperture.b * y ./(2*pi * screen.Dp);      % periodic parameter on Y axis

% calculate intensity image on screen
intensityImg = I00 * (sinc(beta).^2)' * (sinc(alph).^2);    % NOTE that the order cannot be exchanged

end
