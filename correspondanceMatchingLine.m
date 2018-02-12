function corsSSD = correspondanceMatchingLine( I1, I2, corners1, F, R, SSDth);

[h2, w2, d2] = size(I2);
[h, w] = size(corners1);
result = zeros(h, 3);
counter = 0;

figure
imshow(I2);
hold on
for i = 1:h
    x1 = corners1(i, 2);
    y1 = corners1(i, 1);

    lr = F*[x1; y1; 1];
    
    minSum = 1000;
    minInd = 0;
    for x = 1:w2
        px = x;
        py = round((-lr(1)*x - lr(3)*1)./lr(2));
        if py >= 1+R && py <= h2-R
            sum = SSDmatch(x1, y1, px, py, I1, I2, R);
            if sum < minSum
                minSum = sum;
                minInd = x;
            end
        end
        %x = x + 5;
    end
    
    if minSum < SSDth
        coordX = minInd;
        coordY = round((-lr(1)*coordX - lr(3)*1)./lr(2));
        %rectangle('Position',[coordX-20 coordY-20 40 40],'Curvature', [1 1], 'EdgeColor', 'blue');
        counter = counter + 1;
        result(counter, 1) = coordY;result(counter, 2) = coordX;result(counter, 3) = i;
    end
    
 
end

hold off

final = result(1:counter, :);
corsSSD = final;

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
for it = 1:counter
    x1 = corners1(corsSSD(it, 3), 2);
    y1 = corners1(corsSSD(it, 3), 1);
    x2 = corsSSD(it, 2);
    y2 = corsSSD(it, 1);
    rectangle('Position',[x1-R y1-R R*2 R*2],'Curvature', [1 1], 'EdgeColor', 'red', 'LineWidth',3);
    rectangle('Position',[x2+w1-R y2-R R*2 R*2],'Curvature', [1 1], 'EdgeColor', 'red', 'LineWidth',3);    
    line([x1,x2+w1],[y1,y2], 'Color', 'blue', 'LineWidth',3);
end
hold off;

end

