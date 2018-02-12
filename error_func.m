function e = error_func( i, j, w1, h1, x1, y1, dx1, dy1 );

% initial values
x = i - w1/2; y = j - h1/2;

minX = x;minY = y;
if x < x1
    minX = x1;
end
if y < y1
    minY = y1;
end
maxX = x + w1;maxY = y + h1;
if x + w1 > x1 + dx1
    maxX = x1 + dx1;
end
if y + h1 > y1 + dy1
    maxY = y1 + dy1;
end

pNq = (maxX-minX + 1) * (maxY - minY + 1);
p = w1 * h1;
q = dx1 * dy1;
pUq = p + q - pNq;
e = pNq/pUq;

end

