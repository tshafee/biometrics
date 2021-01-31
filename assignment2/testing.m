function [A] = testing

% load test image set
[Xtr, Xte, pixel_vector_test_identities] = load_images;

% get data from training
[phi_m, lambda_m, phi_0] = training;

%zero-mean testing matrix -> calculate x_i-u for all i
[n, d] = size(Xte);
X_0 = zeros(n, d); 
for i = 1:n
    X_0(i,:) = -Xte(i,:)-phi_0;
end

% calculate a_i for all i
transposed_phi_m = transpose(phi_m);
transposed_phi_m(X_0(1,:))