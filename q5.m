im = imread('geisel.jpeg');
[h, w] = size(im);
gaussian = 1/159*[2, 4, 5, 4, 2;...
            4, 9, 12, 9, 4;...
            5, 12, 15, 12, 5;...
            4, 9, 12, 9, 4;...
            2, 4, 5, 4, 2;];
im = conv2(double(im), double(gaussian), 'same');
figure,imagesc(im);colormap(gray);
sobel_x = [-1, 0, 1;...
           -2, 0, 2;...
           -1, 0, 1;];
sobel_y = [-1, -2, -1;...
            0, 0, 0;...
            1, 2, 1;];
gx = conv2(im, sobel_x, 'same');
gy = conv2(im, sobel_y, 'same');
figure,imagesc(gx);
colormap(gray);
figure,imagesc(gy);
colormap(gray);
gmag = sqrt(gx.*gx+gy.*gy);
figure,imagesc(gmag);
colormap(gray);
gtheta = atan2(gy,gx);
coords = zeros(2);
gmag = padarray(gmag,[1, 1]);
gtheta = padarray(gtheta,[1, 1]);
for i=2:h+1
    for j=2:w+1
        if gmag(i,j)>0
            dir = gtheta(i,j)/(pi/8);
            if (dir>=-1 && dir<=1 || dir<=-7 && dir>=7)
                coords = [i,j+1;i,j-1];
            elseif (dir>1 && dir<=3 || dir>-7 && dir<=-5)
                coords = [i-1,j+1;i+1,j-1];
            elseif (dir>3 && dir<=5 || dir>-5 && dir<=-3)
                coords = [i-1,j;i+1,j];
            else
                coords = [i+1,j+1;i-1,j-1];
            end
            if (gmag(i,j)<gmag(coords(1,1),coords(1,2)) || gmag(i,j)<gmag(coords(2,1),coords(2,2)) || i==2 || j==2 || i==h+1 || j==w+1)
                gmag(i,j) = 0;
            end
        end
    end
end
gmag = gmag(2:h+1,2:w+1);
ma = max(gmag(:));
mi = min(gmag(:));
gmag = (gmag-mi)/(ma-mi)*255;
figure,imagesc(gmag);
colormap(gray);
T2 = 40;
T2mask = gmag>T2;
T1 = 20;
[T1r, T1c] = find(gmag>T1);
bw = bwselect(T2mask, T1c, T1r, 8);
figure,imagesc(bw);
colormap(gray);