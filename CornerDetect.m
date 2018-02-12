function corners = CornerDetect( Image, nCorners, smoothSTD, windowSize );

% grayscale
A = rgb2gray(Image);

% gaussian filter g_sig and g_size
g_size = windowSize;
g_sig = smoothSTD;
B = imgaussfilt(A, g_sig, 'FilterSize', g_size);

% compute derivatives
dx = [-1 0 1; -1 0 1; -1 0 1];
dy = dx';

Ix = conv2(A, dx, 'same');
Iy = conv2(A, dy, 'same');   

% find products of derivatives
g_size = 3;
Ix2 = imgaussfilt(Ix.^2, g_sig, 'Filtersize', g_size);
Iy2 = imgaussfilt(Iy.^2, g_sig, 'Filtersize', g_size);
Ixy = imgaussfilt(Ix.*Iy, g_sig, 'Filtersize', g_size);


% construct matrix C and find eigenvalues
% using det and trace is much faster
[h w d] = size(Ix);
E = zeros(h, w);
for i = 10:w-10
    for j = 10:h-10
        % https://courses.cs.washington.edu/courses/cse455/09wi/Lects/lect6.pdf
        E(j, i) = (Ix2(j, i) * Iy2(j, i) - Ixy(j, i).^2) - 0.04 * (Ix2(j, i) + Iy2(j, i)).^2;
    end
end

% find local maxima
dia = g_size*20;
Max = ordfilt2(E, dia^2, ones(dia, dia));

% make an image of local maxima and above threshold
for i = 1:w
    for j = 1:h
        if E(j, i) ~= Max(j, i)% || E(j, i) <= 0.01%0.1 for dino
            E(j, i) = 0;
        end
    end
end

% sort by maxima
S = sort(E(:), 'descend');

% find the 20th maximum value
value = S(nCorners);

% create corner array
corners = zeros(nCorners, 2);
counter = 0;

figure
imshow(A);
hold on

for i = 10:w-10
    for j = 10:h-10
        if E(j, i) >= value && counter < nCorners
            counter = counter + 1;
            rectangle('Position',[i-windowSize*5 j-windowSize*5 windowSize*10 windowSize*10],'Curvature', [1 1], 'EdgeColor', 'blue', 'LineWidth',3);
            corners(counter, 1) = j; corners(counter, 2) = i;
        end
    end
end
hold off;

end

