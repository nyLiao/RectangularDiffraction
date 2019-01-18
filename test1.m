% demo of setting parameters and displaying figures
%
%   NOTE that all units of length are meters
%
%   by nyLiao, 2018


%clc;
close all;
clear all;


% simply display intensity figure using default settings
fig1 = intensityPrint();


% simply display color figure using default settings
fig2 = colorPrint();


% set some parameters and use default for the rest
source3.lambda  = 1000 *1e-9;
aperture3.a     = 3e-6;

[fig3, img3] = intensityPrint(source3, aperture3);


% use group of lights for color figure
source4.lambda  = [365.05 404.58 435.87 546.05 579.11] *1e-9;
source4.Irel    = [  0.30   0.40   1.00   0.80   0.20];

[fig4, img4] = colorPrint(source4);


% set all parameters
source5.lambda   = (375:25:750) *1e-9;
source5.k        = (2*pi) ./source5.lambda;         % k is recommended omitted to handle automatically
source5.Iabs     = 5e9;
source5.Irel     = ones(size(source5.lambda)) ./ size(source5.lambda,2);    % for uniform intensity, Irel can be omitted

aperture5.a      = 1.2e-6;
aperture5.b      = 3.7e-6;

screen5.Dp       = 5.0e-3;
screen5.lim      = 3.0e-2;
screen5.dim      = 1000;
screen5.res      = 2*screen5.lim / screen5.dim;     % res is recommended omitted to handle automatically

[fig5, img5] = colorPrint(source5, aperture5, screen5);


% use lower layer unpackaged functions
source6.lambda   = 589.3 *1e-9;
source6.k        = (2*pi) ./source6.lambda;
source6.Iabs     = 5e7;
source6.Irel     = ones(size(source6.lambda));

aperture6.a      = 2e-6;
aperture6.b      = 0.5e-6;

screen6.Dp       = 1.0e-3;
screen6.lim      = 0.4e-2;
screen6.dim      = 800;
screen6.res      = 2*screen6.lim / screen6.dim;

img6 = intensityDiff(source6, aperture6, screen6);
fig6 = printImg(img6, screen6);
