%% 4.1
% import data
filter = double(imread('/Users/junelee/Desktop/CSE252/hw2/data/filter.jpg'));
toy = double(imread('/Users/junelee/Desktop/CSE252/hw2/data/toy.png'));

% (1) Warmup
filter_ = filter - mean(filter(:));
toy_ = toy - mean(toy(:));

A = conv2(toy_, filter_, 'same');

%figure('Position', [100, 100, 500, 400]);
figure
colormap('jet');
imagesc(A);
colorbar;

[h w d] = size(A);
[h1 w1 d1] = size(filter);

counter = 0;
Max = max(A(:));

figure
imshow(toy);
hold on
for j = 1:h
    for i = 1:w
        if A(j, i) >= Max
            disp(j);disp(i);
            rectangle('Position',[i-w1/2 j-h1/2 w1 h1]);
        end
    end
end