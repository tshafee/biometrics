function [X_0] = training

%training step 2
[Xtr, ~, ~] = load_images;

%training step 3
phi_0 = mean(Xtr); % avg

%training step 4
[n, d] = size(Xtr);
X_0 = zeros(n, d); %zero-mean training matrix
for i = 1:n
    X_0(i,:) = Xtr(i,:)-phi_0;
end

%training step 5
sigma = cov(X_0); %covariance of zero-mean training matrix



%training step 6



% access elements like this
%a = Xtr(:,5)
% value of 5 could be between 1 and 200(=n_users*images_per_user/2)
