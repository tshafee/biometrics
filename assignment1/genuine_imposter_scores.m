function genuine_imposter_scores
% gather data
[S, Id] = get_scores_from_file
[~, size_ids] = size(Id)

% sort genuine and imposter scores
genuine = []
imposter = []

% loop through all indexes (i=row index)
for i = 1:size_ids
    % get identity for this index
    temp_id = Id(i);
    
    % collect all scores top-right of center (j=column index)
    %fprintf("i: %u\n", i)
    for j = (i+1):size_ids
        %fprintf("j: %u\n", j)
        compare_id = Id(j);
        
        % same source identify: genuine score
        if temp_id == compare_id
            genuine = [genuine, S(i, j)];
        % different source identity: imposter score
        else
            imposter = [imposter, S(i, j)];
        end
        
    end
    
end

figure(1);
[counts, centers] = hist(genuine, 50);
disp(counts)

figure(2);
[counts_2, centers_2] = hist(imposter, centers);

disp(counts_2)

disp(centers)
disp(centers_2)

figure(3);
bar(centers, [counts; counts_2])

fprintf("size_genuine: %u\n", size(genuine))
fprintf("size_imposter: %u\n", size(imposter))
fprintf("genuine_1 %u\n", genuine(1))