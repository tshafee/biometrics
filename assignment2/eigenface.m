function [] = eigenface
% task 3 - 

[phi_m, lambda_m] = training;
[d, m] = size(phi_m);

mean_face = reshape(mean(phi_m), 56, 46);

figure(1);
imagesc(mean_face);
title('mean face');

for i = 1:d
    % reorganize phi_m vectors into image matrix
    image = reshape(phi_m(i,:), 56, 46);
    
    figure(i+1);
    imagesc(image);
    title("face #" + i + "  -  Lambda: " + lambda_m(i))
end