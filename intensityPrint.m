function [fig, img] = intensityPrint(source, aperture, screen)
% intensityPrint    calculates the intensity distribution of rectangular aperture Fraunhofer diffraction using intensityDiff(), and display the image using printImg()
%
%   [fig, img] = intensityPrint() displays the intensity distribution image using default settings
%
%   [fig, img] = intensityPrint(source, aperture, screen) displays the image, determined by the given light source, aperture and screen parameters, parameters can be omitted to use default settings
%
%       source, aperture, screen: same as intensityDiff()
%
%       fig: the output figure object of printImg()
%
%       img: a dim*dim*1 array of number, the image of absolute intensity distribution
%
%   by ChiGamma, 2018


% handle omitted struct and fields of light source
if nargin<1                     % if the whole struct is omitted, create struct and add fields below
    source = struct;
end
if ~isfield(source, 'lambda')   % if certain field is omitted, use the default value for calculation
    source.lambda   = 500 *1e-9;
end
if ~isfield(source, 'k')        % k is recommended omitted to handle automatically
    source.k        = (2*pi) ./source.lambda;
end
if ~isfield(source, 'Iabs')
    source.Iabs     = 2.5e7;
end
if ~isfield(source, 'Irel')
    source.Irel     = ones(size(source.lambda));
end

% handle omitted struct and fields of aperture
if nargin<2
    aperture = struct;
end
if ~isfield(aperture, 'a')
    aperture.a      = 1e-6;
end
if ~isfield(aperture, 'b')
    aperture.b      = aperture.a;   % default is square aperture
end

% handle omitted struct and fields of light screen
if nargin<3
    screen = struct;
end
if ~isfield(screen, 'Dp')
    screen.Dp       = 1.0e-3;
end
if ~isfield(screen, 'lim')
    screen.lim      = 0.5e-2;
end
if ~isfield(screen, 'dim')
    screen.dim      = 500;
end
if ~isfield(screen, 'res')      % res is recommended omitted to handle automatically
    screen.res      = 2*screen.lim / screen.dim;
end


% calculates intensity distribution
img = intensityDiff(source, aperture, screen);


% handle information string showing on figure
lambdaStr = sprintf('%0.0f ', source.lambda*1e9);
str = sprintf('λ = %snm \na = %0.2f μm, b = %0.2f μm, Dp = %0.2f mm', ...
              lambdaStr, aperture.a*1e6, aperture.b*1e6, screen.Dp*1e3);

% display intensity distribution
fig = printImg(img, screen, str);

end
