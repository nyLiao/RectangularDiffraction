% demo of examples used in readme
%
%   by ChiGamma, 2018


%clc;
close all;
clear all;


% cover figure, default green light in square aperture
source          = struct;       % set empty struct to use default settings
aperture        = struct;
screen.dim      = 1000;

fig0 = colorPrint(source, aperture, screen);


% intensity image, infrared light, narrow aperture
source1.lambda  = 1000 *1e-9;
aperture1.a     = 1e-6;
aperture1.b     = 20e-6;

fig1 = intensityPrint(source1, aperture1, screen);


% multiple colors of mercury lamp spectrum
source2.lambda  = [365.05 404.58 435.87 546.05 579.11] *1e-9;
source2.Irel    = [  0.30   0.40   1.00   0.80   0.20];
aperture2.a     = 2e-6;
aperture2.b     = 1e-6;

fig2 = colorPrint(source2, aperture2, screen);


% white light
source3.lambda  = (350:25:750) *1e-9;
source3.Irel    = ones(size(source3.lambda));
aperture3.a     = 1e-6;
aperture3.b     = 12e-6;

fig3 = colorPrint(source3, aperture3, screen);
