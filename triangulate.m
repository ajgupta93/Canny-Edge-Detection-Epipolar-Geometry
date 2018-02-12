function [points3D] = triangulate(corsSSD, P1, P2)
n = size(corsSSD,1);
points3D = cell([1,n]);
for i=1:n
    p1 = [corsSSD(i,1:2) 1];
    p2 = [corsSSD(i,3:4) 1];
    x1 = p1(1);
    y1 = p1(2);
    x2 = p2(1);
    y2 = p2(2);
    A = [x1.*P1(3,:) - P1(1,:);...
         y1.*P1(3,:) - P1(2,:);...
         x2.*P2(3,:) - P2(1,:);...
         y2.*P2(3,:) - P2(2,:)];
    A(1,:) = A(1,:)./norm(A(1,:));
    A(2,:) = A(2,:)./norm(A(2,:));
    A(3,:) = A(3,:)./norm(A(3,:));
    A(4,:) = A(4,:)./norm(A(4,:));
    [~,~,v] = svd(A);
    points3D{i} = v(:,4);
    points3D{i} = points3D{i}./points3D{i}(4);
end
