function result = conv_func( temp, car_, x1, y1, x2, y2 );

% conversion
temp = double(temp);
temp = temp - mean(temp(:))
car = double(car_);
car = car - mean(car(:))

% convolution
A = conv2(car, temp, 'same');

% draw heatmap
figure
colormap('jet');
imagesc(A);
colorbar;

% find MAX position
[h w d] = size(A);
[h1 w1 d1] = size(temp);

Max = max(A(:));
Avg = mean(A(:));
disp(Max);
disp(Avg);
thres = 2*(Max+Avg)/3;
counter = 0;
avgX = 0;
avgY = 0;
% calculate bounding box
for j = 1:h
    for i = 1:w
        if A(j, i) >= Max%thres for car2&3, max for car4&5
            avgX = avgX + i;
            avgY = avgY + j;
            counter = counter + 1;
        end
    end
end

% draw bouding box
avgX = avgX / counter;
avgY = avgY / counter;
%disp(avgX);disp(avgY);
figure
imshow(car_);
hold on
% my calculation
rectangle('Position',[avgX-w1/2 avgY-h1/2 w1 h1], 'EdgeColor', 'red');
% groundtruth car2
%rectangle('Position', [69 205 w1 h1], 'EdgeColor', 'blue');
% groundtruth car3
%rectangle('Position', [400-w1/2 290-h1/2 w1 h1], 'EdgeColor', 'blue');
% groundtruth car4
%rectangle('Position', [320-w1/2 210-h1/2 w1 h1], 'EdgeColor', 'blue');
% groundtruth car5
rectangle('Position', [600-w1/2 400-h1/2 w1 h1], 'EdgeColor', 'blue');
hold off;

%result = error_func( avgX, avgY, w1, h1, 69, 205, 488-69, 357-205);
%result = error_func( avgX, avgY, w1, h1, 400-w1/2, 290-h1/2, w1, h1);
%result = error_func( avgX, avgY, w1, h1, 320-w1/2, 210-h1/2, w1, h1);
result = error_func( avgX, avgY, w1, h1, 600-w1/2, 400-h1/2, w1, h1);
end

