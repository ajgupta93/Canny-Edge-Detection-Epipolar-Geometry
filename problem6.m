% load data
% dino
%{
data = load('/Users/junelee/Desktop/CSE252/hw2/data/dino2.mat');
[h1 w1 d1] = size(data.dino01);
[h2 w2 d2] = size(data.dino02);

I1 = data.dino01;
I2 = data.dino02;
%}

% matrix
%{
data = load('/Users/junelee/Desktop/CSE252/hw2/data/matrix2.mat');
[h1 w1 d1] = size(data.matrix01);
[h2 w2 d2] = size(data.matrix02);

I1 = data.matrix01;
I2 = data.matrix02;
%}

% warrior

data = load('/Users/junelee/Desktop/CSE252/hw2/data/warrior2.mat');
[h1 w1 d1] = size(data.warrior01);
[h2 w2 d2] = size(data.warrior02);

I1 = data.warrior01;
I2 = data.warrior02;


smoothSTD = 3;
windowSize = 9;
R = 20;
SSDth = 10;%5;

%% 6.1
nCorners = 20;
CornerDetect(I1, nCorners, smoothSTD, windowSize);
CornerDetect(I2, nCorners, smoothSTD, windowSize);

%% 6.3
nCorners = 10;
C1 = CornerDetect(I1, nCorners, smoothSTD, windowSize);
C2 = CornerDetect(I2, nCorners, smoothSTD, windowSize);
I = naiveCorrespondanceMatching( I1, I2, C1, C2, R, SSDth);%10~11

%% 6.4
cam1 = data.cor1;
cam2 = data.cor2;
F = fund(cam1, cam2);

% right null space
er = null(F);
er = er./er(3, 1);

% left null space
el = (null(F.'));
el = el./el(3, 1);

figure
imshow(rgb2gray(I1));
hold on
for i = 1:10
    x1 = C1(i, 2);
    y1 = C1(i, 1);
    rectangle('Position',[x1-R y1-R R*2 R*2],'Curvature', [1 1], 'EdgeColor', 'blue', 'LineWidth',3);
    One = [x1 y1 1];
    Two = [er(1, 1) er(2, 1) 1];
    Three = cross(One, Two);
    Three = Three.';
    pts = linePts(Three,[1, w1],[1, h1]);
    line([pts(1, 1), pts(2, 1)], [pts(1, 2), pts(2, 2)], 'Color', 'blue', 'LineWidth',3);
end
hold off

figure
imshow(rgb2gray(I2));
hold on
for i = 1:10
    x2 = C2(i, 2);
    y2 = C2(i, 1);
    rectangle('Position',[x2-R y2-R R*2 R*2],'Curvature', [1 1], 'EdgeColor', 'blue', 'LineWidth',3);
    One = [x2 y2 1];
    Two = [el(1, 1) el(2, 1) 1];
    Three = cross(One, Two);
    Three = Three.';
    pts = linePts(Three,[1, w2],[1, h2]);
    line([pts(1, 1), pts(2, 1)], [pts(1, 2), pts(2, 2)], 'Color', 'blue', 'LineWidth',3);
end
hold off

%% 6.5
ncorners = 10;
F = fund(cam1, cam2);
corners1 = CornerDetect(I1, ncorners, smoothSTD, windowSize);
corsSSD = correspondanceMatchingLine( I1, I2, corners1, F, R, SSDth);




