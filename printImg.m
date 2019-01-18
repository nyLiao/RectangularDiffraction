function fig = printImg(img, screen, str)
% printImg      display the image with axis
%
%   fig = printImg(img, screen) display the img file using the built-in imshow() function
%       img:    the image, either monochromatic (dim*dim*1) or colored (dim*dim*3) is acceptable
%       screen: 1*1 struct describing the light screen and image
%
%       str (optional): display a text string on figure
%
%       fig: the output figure object
%
%   by ChiGamma, 2018


% display basic image
fig = figure();
imshow(img);        % use the built-in imshow() function to display image

% handle axis, unit is milimeters
ax = fig.CurrentAxes;
axis on;
xlabel(ax, '$x / {\rm mm}$', 'Interpreter', 'LaTeX');
ylabel(ax, '$y / {\rm mm}$', 'Interpreter', 'LaTeX');

% add axis label
ticklabels = (-screen.lim : screen.res*50 : screen.lim) *1000;         % basically label every lim/(dim/100) mm, i.e. 1mm for lim=5mm, dim=500
if screen.dim>=1000
    ticklabels = (-screen.lim : screen.res*100 : screen.lim) *1000;    % if dim is more than 1000, label every lim/(dim/200) mm, i.e. 1mm for lim=5mm, dim=1000
end
ticks = linspace(1, screen.dim, numel(ticklabels));
set(ax, 'XTick', ticks, 'XTickLabel', ticklabels);
set(ax, 'YTick', ticks, 'YTickLabel', flipud(ticklabels(:)));

% (optional) display a information text on the top left corner
if nargin>2
    text(ax, 0.01*screen.dim, 0.01*screen.dim, str, ...
         'color', 'w', 'FontWeight', 'bold', 'VerticalAlignment', 'top');
end

% if dim is more than 1000, use bigger font
if screen.dim>=1000
    set(ax, 'FontSize', 15);
end

end
