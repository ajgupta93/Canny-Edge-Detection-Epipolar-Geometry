function I = naiveCorrespondanceMatching( I1, I2, corners1, corners2, R, SSDth );

[num coord] = size(corners1);

% find best match
A = zeros(num, 3);

minSum = 1000;
minInd_m = 0;

for n = 1:num
    for m = 1:num
        sum = SSDmatch(corners1(n, 2), corners1(n, 1), corners2(m, 2), corners2(m, 1), I1, I2, R);
        if sum < minSum
            minSum = sum;
            minInd_m = m;
        end
    end
    
    A(n, 1) = n;
    A(n, 2) = minInd_m;
    A(n, 3) = minSum;
    minSum = 1000;minInd_m = 0;
end

% create new image I
[h1 w1 d1] = size(I1);
[h2 w2 d2] = size(I2);

h = max(h1, h2);
w = max(w1, w2);

I = zeros(h, 2*w);

for j = 1:h1
    for i = 1:w1
        I(j, i) = I1(j, i);
    end
end

for j = 1:h2
    for i = 1:w2
        I(j, i + w1) = I2(j, i);
    end
end

% draw circles and lines
figure
imshow(I);
hold on
for it = 1:num
    if A(it, 3) <= SSDth
        y1 = corners1(it, 1);
        x1 = corners1(it, 2);
        y2 = corners2(A(it, 2), 1);
        x2 = corners2(A(it, 2), 2);
        rectangle('Position',[x1-R y1-R R*2 R*2],'Curvature', [1 1], 'EdgeColor', 'red', 'LineWidth',3);
        rectangle('Position',[x2+w1-R y2-R R*2 R*2],'Curvature', [1 1], 'EdgeColor', 'red', 'LineWidth',3);
        line([x1,x2+w1],[y1,y2], 'LineWidth', 3, 'Color', 'blue');
    end
end
hold off;

