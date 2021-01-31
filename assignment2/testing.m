function [A] = testing

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
[m, d] = size(phi_m)
A = zeros(l,m)
for i = 1:l
   A(i,:) =  phi_m*transpose(X_0(i,:));
end
% size(phi_m)
% size(transpose(X_0(1,:)))
% phi_m*transpose(X_0(1,:))