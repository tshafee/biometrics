function [pixel_vectors_training, pixel_vectors_test] = load_images
% FaceData is struct of 40x10, each containing an image(struct) of 56x48 uint8's
load('FaceData.mat', '-mat', 'FaceData');

% dimensions of FaceData
[n_users, images_per_user] = size(FaceData);

%pixel 
pixel_vectors = cell(n_users, images_per_user);

for i_user = 1:n_users
   for i_image = 1:images_per_user
      pixel_vectors(i_user, i_image) = {double(FaceData(i_user, i_image).Image(:))/255};
   end
end

% create test and training set
pixel_vectors_training = cell(n_users, images_per_user/2);
pixel_vectors_test = cell(n_users, images_per_user/2);

% training: all users images 1-5
% test: all users images 6-10
for i_user = 1:n_users
   for i_image = 1:images_per_user
      if i_image <= images_per_user/2
          pixel_vectors_training(i_user, i_image) = pixel_vectors(i_user, i_image);
      else
          pixel_vectors_test(i_user, i_image-(images_per_user/2)) = pixel_vectors(i_user, i_image);
      end
   end
end

