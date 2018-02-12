%% Triangulation
outlierTH = 20;
[~, ~, v] = svd(F');
e = v(:,3)/v(3,3);
ex = [0 -e(3) e(2);...
      e(3) 0 -e(1);...
      -e(2) e(1) 0];
P1 = eye(3,4);
P2 = [ex*F, e];
points3D = triangulate(corsSSD, P1, P2);
[ inlier, outlier ] = findOutliers(points3D, P2, outlierTH, corsSSD);

figure,imshow(I2);
hold on;
for i=1:n
    plot(matchedPoints2(i,1),matchedPoints2(i,2),'ko','MarkerSize',20);
end
n = size(inlier,1);
for i=1:n
    plot(inlier(i,1),inlier(i,2),'b+','MarkerSize',20);
end
n = size(outlier,1);
for i=1:n
    plot(outlier(i,1),outlier(i,2),'r+','MarkerSize',20);
end
