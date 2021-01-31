function [X_0] = training

%training step 2
[Xtr, ~, ~] = load_images;

%training step 3
phi_0 = mean(Xtr); % avg

%training step 4
[d, n] = size(Xtr);
X_0 = zeros(d, n); %zero-mean training matrix
for i = 1:d
    X_0(i,:) = Xtr(i,:)-phi_0;
end



%training step 5




% access elements like this
%a = Xtr(:,5)
% value of 5 could be between 1 and 200(=n_users*images_per_user/2)
