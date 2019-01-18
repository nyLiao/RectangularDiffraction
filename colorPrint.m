function [fig, img] = colorPrint(source, aperture, screen)
% colorPrint    calculates the single- or multi- color image of rectangular aperture Fraunhofer diffraction using colorDiff(), and display the image using printImg()
%
%   [fig, img] = colorPrint() displays the color image using default settings
%
%   [fig, img] = colorPrint(source, aperture, screen) displays the image, determined by the given light source, aperture and screen parameters, some parameters can be omitted to use default settings
%
%       source: 1*1 struct describing the monochromatic or multicolor light source
%           source.lambda:  light source (center) wavelength, a 1*N array of number of each wavelength compositing the light color, in unit of meters
%           source.k:       light source wavelength in vaccuum, a 1*N array of number for corresponding lambda, in meter^(-1)
%           source.Iabs:    light source absolute intensity at the aperture, a number, this number determines the actual value of matrix intensityImg
%           source.Irel:    light source relative intensity modulus, a 1*N array of number for corresponding lambda in the light
%
%       aperture, screen: same as intensityDiff()
%
%       fig: the output figure object of printImg()
%
%       img: a dim*dim*3 array, as the add-up colored image in RGB format
%
%   by nyLiao, 2018


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
if ~isfield(source, 'Irel')     % for uniform intensity, Irel can be omitted
    source.Irel     = ones(size(source.lambda));    % I=Iabs for every wavelength
    if size(source.lambda,2)>=5                     % reduce intensity to prevent overexposure
        source.Irel = ones(size(source.lambda)) ./ size(source.lambda,2);
    end
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


% calculate and add image by wavelength
tic;                                            % set timer
fprintf('\ncolorPrint() running... \n');         % show progress
img = zeros(screen.dim+1, screen.dim+1, 3);     % initialize image
for colort = 1 : size(source.lambda,2)
    % make the 1*1 source struct of corresponding wavelength
    sourcet.lambda  = source.lambda (colort);
    sourcet.k       = source.k      (colort);
    sourcet.Iabs    = source.Iabs;
    sourcet.Irel    = source.Irel   (colort);

    % calculate the current wavelength diffraction and add to img
    imgt = colorDiff(sourcet, aperture, screen);
    img = imadd(img, imgt);                     % use the built-in imadd() function to add RGB images

    % show progress of each loop
    fprintf('time = %6.3f s  |  color %2d  |  λ = %6.2f nm  |  I = %0.3e \n', ...
            toc, colort, sourcet.lambda*1e9, sourcet.Iabs*sourcet.Irel)
end


% handle information string showing on figure
lambdaStr = sprintf('%0.0f ', source.lambda*1e9);
str = sprintf('λ = %snm \na = %0.2f μm, b = %0.2f μm, Dp = %0.2f mm', ...
              lambdaStr, aperture.a*1e6, aperture.b*1e6, screen.Dp*1e3);

% display the color image
fig = printImg(img, screen, str);
toc;                                            % total time

end
