[S, Id] = get_scores_from_file

% The list of Ids shows the id of the person that did the enty (for example
% first 8 entries are same person (see id list)
% S(x,y) returns the similiarity of entry x compared to enty y.
% when the score is high (exp 13) then its probably two entries from the
% same person.... when score is low (exp -500) then its probably different
% persons.

min_score = -1600;
max_score = 400;

false_match_rate = [];
false_non_match_rate = [];
true_match_rate = []
[~, size_ids] = size(Id)
thresholds = [];
for t = min_score:max_score
    thresholds = [thresholds, t];
    % compute match rate for threshold i
    count_of_checks_match = 0;
    count_of_checks_non_match = 0;
    count_of_FM = 0;
    count_of_FNM = 0;
    
    for i = 1:size_ids
        % get identity for this index
        temp_id = Id(i);
        for j = (i+1):size_ids
            compare_id = Id(j);
            if temp_id == compare_id
                %same person
                count_of_checks_match = count_of_checks_match + 1;
                if S(temp_id, compare_id) < t
                   count_of_FNM = count_of_FNM + 1; 
                end
            else
                %not same person
                count_of_checks_non_match = count_of_checks_non_match + 1;
                if S(temp_id,compare_id) >= t
                    count_of_FM = count_of_FM + 1;
                end
            end
        end
    end
    
    fmr = count_of_FM/count_of_checks_non_match;
    fnmr = count_of_FNM/count_of_checks_match;
    
    false_match_rate = [false_match_rate, fmr];
    false_non_match_rate = [false_non_match_rate, fnmr];
    true_match_rate = [true_match_rate, 1-fnmr];
end

figure(1); % FMR & FNMR
plot(thresholds, false_match_rate)
hold on;
plot(thresholds, false_non_match_rate)
xlabel('Threshold t'); ylabel('pdf'); title('False match & non-match rates');

figure(2); % DET
plot(false_match_rate, false_non_match_rate)
xlabel('False match rate FMR(t)'); ylabel('False non-match rate FNMR(t)'); title('Decision error trade-off curve (DET)');

figure(3); % ROC
plot(false_match_rate, true_match_rate)
xlabel('False match rate FMR(t)'); ylabel('True match rate TMR(t)'); title('Receiver operating characteristic (ROC)');


