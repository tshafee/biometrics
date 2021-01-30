function [Xtr] = training

[Xtr, ~, ~] = load_images;


% access elements like this
%a = Xtr(5,:)
% value of 5 could be between 1 and 200(=n_users*images_per_user/2)
