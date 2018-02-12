%% 4.3
% (3) More realistic images
% filter
temp = imread('/Users/junelee/Desktop/CSE252/hw2/data/cartemplate.jpg');

% car2
car2 = imread('/Users/junelee/Desktop/CSE252/hw2/data/car2.jpg');
temp2 = fliplr(temp);
temp2 = imrotate(temp2, -3);
temp2 = imcrop(temp2, [70 300 1650 700]);
temp2 = imresize(temp2, [70*3 165*3]);
figure
imshow(temp2);
e2 = conv_func(temp2, car2);
disp(e2);

%% car3
car3 = imread('/Users/junelee/Desktop/CSE252/hw2/data/car3.jpg');
%car3 = car3 - mean(car3(:));
temp3 = imcomplement(temp);
%temp3 = temp3 - mean(temp3(:));
[h w d] = size(temp3);
for i = 1:w
    for j = 1:h
        if temp3(j, i) < 20
            temp3(j, i) = 230;
        end
    end
end
temp3 = imrotate(temp3, -5);
temp3 = imcrop(temp3, [70 400 1800 600]);
temp3 = imresize(temp3, [120, 300]);
figure
imshow(temp3);
e3 = conv_func(temp3, car3);
disp(e3);

%% car4
car4 = imread('/Users/junelee/Desktop/CSE252/hw2/data/car4.jpg');
temp4 = fliplr(temp);
temp4 = imcomplement(temp4);
for i = 1:w
    for j = 1:h
        if temp4(j, i) < 20
            temp4(j, i) = 200;
        end
    end
end
temp4 = imcrop(temp4, [70 400 1800 800]);
temp4 = imresize(temp4, [120, 300]);
figure
imshow(temp4);
e4 = conv_func(temp4, car4);
disp(e4);

%% car5
car5 = imread('/Users/junelee/Desktop/CSE252/hw2/data/car5.jpg');
temp5 = imcomplement(temp);
[h w d] = size(temp5);
for i = 1:w
    for j = 1:h
        if temp5(j, i) < 20
            temp5(j, i) = 200;
        end
    end
end
temp5 = imcrop(temp5, [40 400 1800 400]);
temp5 = imresize(temp5, [200, 350]);
figure
imshow(temp5);
e5 = conv_func(temp5, car5);
disp(e5);