[S, Id] = get_scores_from_file

% The list of Ids shows the id of the person that did the enty (for example
% first 8 entries are same person (see id list)
% S(x,y) returns the similiarity of entry x compared to enty y.
% when the score is high (exp 13) then its probably two entries from the
% same person.... when score is low (exp -500) then its probably different
% persons.

min_score = -1600
max_score = 500

false_match_rate = []
[~, size_ids] = size(Id)
thresholds = []
for t = min_score:max_score
    thresholds = [thresholds, t];
    % compute match rate for threshold i
    count_of_checks = 0;
    count_of_FM = 0;
    
    for i = 1:size_ids
        % get identity for this index
        temp_id = Id(i);
        for j = (i+1):size_ids
            compare_id = Id(j);
            if temp_id == compare_id
                %same person
                count_of_checks = count_of_checks + 1;
            else
                %not same person
                count_of_checks = count_of_checks + 1;
                if S(temp_id,compare_id) > t
                    count_of_FM = count_of_FM + 1;
                end
            end
        end
    end
    
    fmr = count_of_FM/count_of_checks;
    
    false_match_rate = [false_match_rate, fmr];
end

plot(thresholds, false_match_rate)
xlabel('Threshold t'); ylabel('pdf'); title('False match rate');

