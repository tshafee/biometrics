function [] = testing

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
[m, d] = size(phi_m);
A = zeros(l,m);
for i = 1:l
   A(i,:) =  phi_m*transpose(X_0(i,:));
end

% calculate dissimilarity scores
S = zeros(l,l);
for el_1 = 1:l
    for el_2 = 1:l
        % calculate eucledian distance
        v1 = abs(A(el_1));
        v2 = abs(A(el_2));
        S(el_1, el_2) = sqrt(sum((v1-v2) .^ 2));
    end
end


% calculate ROC
false_match_rate = [];
false_non_match_rate = [];
true_match_rate = [];
thresholds = [];
for t = 0:0.2:10
    thresholds = [thresholds, t];
    % compute match rate for threshold i
    count_of_checks_match = 0;
    count_of_checks_non_match = 0;
    count_of_FM = 0;
    count_of_FNM = 0;
    
    for i = 1:l
        % get identity for this index
        temp_id = pixel_vector_test_identities(i);
        for j = (i+1):l
            compare_id = pixel_vector_test_identities(j);
            if temp_id == compare_id
                %same person
                count_of_checks_match = count_of_checks_match + 1;
                if S(i, j) >= t
                   count_of_FNM = count_of_FNM + 1; 
                end
            else
                %not same person
                count_of_checks_non_match = count_of_checks_non_match + 1;
                if S(i, j) < t
                    count_of_FM = count_of_FM + 1;
                end
            end
        end
    end
    
    fmr = double(count_of_FM/count_of_checks_non_match);
    fnmr = double(count_of_FNM/count_of_checks_match);
    
    false_match_rate = [false_match_rate, fmr];
    false_non_match_rate = [false_non_match_rate, fnmr];
    true_match_rate = [true_match_rate, double(1-fnmr)];
end
[~, entries] = size(thresholds);

EER_Threshold_id = entries;
for i=1:entries
    fnmr = false_non_match_rate(i);
    fmr = false_match_rate(i);
    if fmr >= fnmr
       EER_Threshold = i;
       break;
    end
end

figure(1); % ROC
plot(false_match_rate, true_match_rate)
xlabel('False match rate FMR(t)'); ylabel('True match rate TMR(t)'); title("ROC (EER: " + false_match_rate(EER_Threshold) + " at threshold: " + thresholds(EER_Threshold) + ")");

