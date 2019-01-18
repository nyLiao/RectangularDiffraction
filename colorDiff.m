function rgbImg = colorDiff(source, aperture, screen)
% colorDiff     calculates the spectral color image of rectangular aperture Fraunhofer diffraction of specific monochromatic light
%
%   rgbImg = colorDiff(intensityImg, lambda) uses the intensity from intensityDiff(), and the color from corresponding wavelength of the monochromatic light source, to make a single color image file
%
%       source, aperture, screen: same as intensityDiff()
%
%       rgbImg: a dim*dim*3 array, as the colored image in RGB format
%
%   by nyLiao, 2018


% calculate intensity image, same as intensityDiff()
intensityImg = intensityDiff(source, aperture, screen);

% convert wavelength color to RGB format
rgbWl = ones(1,1,3);
rgbWl(1,1,:) = spectrumRGB(source.lambda*1e9);
%    sRGB = spectrumRGB(LAMBDA) converts the spectral color with wavelength LAMBDA in nanometers to RGB format

% convert RGB wavelength to HSI format, which is easier to adjust intensity
hsiWl = rgb2hsi(rgbWl);
%    HSI = RGB2HSI(RGB) converts an RGB image to HSI

% apply intensity from intensityDiff() to the image
rgbImg(:,:,1) = ones(size(intensityImg)) * hsiWl(1,1,1);    % apply Hue
rgbImg(:,:,2) = ones(size(intensityImg)) * hsiWl(1,1,2);    % apply Saturation
rgbImg(:,:,3) = intensityImg * hsiWl(1,1,3);                % apply intensity
% NOTE: this may make the intensity out of range [0, 1], thus cause HSI-to-RGB conversion different from expect
%rgbImg(:,:,1) = ( intensityImg - 2 * mean(mean(intensityImg)) ) * cbcr(1);     % simple noise reduction (no need so far)

% convert back to RGB format, which is easier to add layers and display
rgbImg = hsi2rgb(rgbImg);
%    RGB = HSI2RGB(HSI) converts an HSI image to RGB
% NOTE: the defect of HSI2RGB() function cause the HSI2RGB conversion do not result overexposure

end
