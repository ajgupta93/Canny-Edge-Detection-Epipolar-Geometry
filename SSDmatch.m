function sum = SSDmatch(x1, y1, x2, y2, I1, I2, windowSize);

% add up
sum = 0;

for i = 1:windowSize
    for j = 1:windowSize
        Y1 = y1 - windowSize/2 + j;
        X1 = x1 - windowSize/2 + i;
        Y2 = y2 - windowSize/2 + j;
        X2 = x2 - windowSize/2 + i;
        if X1 > 0 && Y1 > 0 && X2 > 0 && Y2 > 0
            sum = sum + (I1(Y1, X1) - I2(Y2, X2)).^2;
        else
            sum = 1000;
        end
    end
end


end

