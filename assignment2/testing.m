function [S] = testing

% load test image set
[Xtr, Xte, pixel_vector_test_identities] = load_images;

% get data from training
[phi_m, lambda_m, phi_0] = training;

%zero-mean testing matrix -> calculate x_i-u for all i
[l, d] = size(Xte);
X_0 = zeros(l, d); 
for i = 1:l
    X_0(i,:) = -Xte(i,:)-phi_0;
end

% calculate a_i for all i
[m, d] = size(phi_m);
A = zeros(l,m);
for i = 1:l
   A(i,:) =  phi_m*transpose(X_0(i,:));
end

% calculate dissimilarity scores
S = zeros(l,l);
for el_1 = 1:l
    for el_2 = 1:l
        % calculate eucledian distance
        v1 = abs(A(el_1));
        v2 = abs(A(el_2));
        S(el_1, el_2) = sqrt(sum((v1-v2) .^ 2));
    end
end

