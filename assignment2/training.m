function [phi_m, lambda_m, phi_0] = training
% configuration: m
m = 10; % 10 items

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
% reference https://nl.mathworks.com/help/matlab/ref/eig.html
[phi,lambda] = eig(sigma); % phi=eigenvector, lambda=eigenvalues
[d,ind] = sort(diag(lambda));
lambda = lambda(ind,ind);
lambda = diag(lambda);
phi = phi(:,ind);

%training step 7
[n_1, n_2] = size(phi);
phi_m = zeros(m,n_1);
phi_index = 1;
lambda_m = [];
for i = n_2:-1:n_2-m+1
    phi_m(phi_index,:) = phi(:,i);
    lambda_m(phi_index) = lambda(i);
    phi_index = phi_index+1;
end

% Task 2: plot v(m)

flipped_lambda = flip(lambda);
d = 2576;
sum_d = 0;
v = [];
for i=1:d
   sum_d = sum_d + flipped_lambda(i);
end
sum_m = 0;
for i = 1:d
  sum_m = sum_m + flipped_lambda(i);
  v(i) = double(sum_m/sum_d);
  if v(i) >= 1.0
      break;
  end
end

figure(1);
plot(v)
xlabel('m'); ylabel('v(m)'); title('distribution of v(m)');

