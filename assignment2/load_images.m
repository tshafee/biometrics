function [Xtr, Xte, pixel_vector_test_identities] = load_images
% FaceData is struct of 40x10, each containing an image(struct) of 56x48 uint8's
load('FaceData.mat', '-mat', 'FaceData');

% dimensions of FaceData
[n_users, images_per_user] = size(FaceData);

% size of image
[p,q] = size(FaceData(1,1).Image);

%pixel 
pixel_vectors = cell(n_users, images_per_user);

for i_user = 1:n_users
   for i_image = 1:images_per_user
      pixel_vectors(i_user, i_image) = {double(FaceData(i_user, i_image).Image(:))/255};
   end
end

% create test and training set
Xtr = zeros((n_users/2)*images_per_user, p*q); % pixel_vectors_training
Xte = zeros((n_users/2)*images_per_user, p*q); % pixel_vectors_test
pixel_vector_test_identities = [];
Xtr_i = 0;
Xte_i = 0;

% training: all users images 1-5
% test: all users images 6-10
for i_user = 1:n_users/2
   for i_image = 1:images_per_user
      Xtr_i = Xtr_i + 1;
      temp_val = pixel_vectors(i_user, i_image);
      Xtr(Xtr_i,:) = temp_val{1,1};
   end
end
for i_user = (n_users/2)+1:n_users
    for i_image = 1:images_per_user
      Xte_i = Xte_i + 1;
      temp_val = pixel_vectors(i_user, i_image);
      Xte(Xte_i,:) = temp_val{1,1};
      pixel_vector_test_identities(Xte_i) = i_user;
   end
end

% access elements like this
%a = Xtr(5,:)
% value of 5 could be between 1 and 200(=n_users*images_per_user/2)
