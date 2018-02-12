function [ inlier, outlier ] = findOutliers(points3D, P2, outlierTH, corsSSD)
n = size(corsSSD,1);
inlier = [];
outlier = [];
for i=1:n
    p = P2*points3D{i};
    p = floor(p./p(3));
    dist = pdist2([p(1) p(2)],[corsSSD(i,3), corsSSD(i,4)]);
    if(dist<outlierTH)
        inlier = [inlier; p(1:2)'];
    else
        outlier = [outlier; p(1:2)'];
    end
end