%% 4.2
% (2) Detection error
figure
imshow(toy);
hold on
dx1 = 100; dy1 = 100;
x1 = 341 - dx1/2; y1 = 89 - dy1/2;
rectangle('Position', [x1 y1 dx1 dy1], 'EdgeColor', 'red');

dx2 = 100; dy2 = 90;
x2 = 341 - dx2/2; y2 = 89 - dy2/2;
rectangle('Position', [x2 y2 dx2 dy2], 'EdgeColor', 'blue');

dx3 = 98; dy3 = 84;
x3 = 341 - dx3/2; y3 = 89 - dy3/2;
rectangle('Position', [x3 y3 dx3 dy3], 'EdgeColor', 'green');
hold off

error1 = error_func(341, 89, w1, h1, x1, y1, dx1, dy1);
error2 = error_func(341, 89, w1, h1, x2, y2, dx2, dy2);
error3 = error_func(341, 89, w1, h1, x3, y3, dx3, dy3);