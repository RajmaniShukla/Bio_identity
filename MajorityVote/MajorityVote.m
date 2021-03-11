function candidate = MajorityVote(charArray)
%% Boyer–Moore majority vote algorithm
% The Boyer-Moore Vote Algorithm solves the majority vote problem in 
% linear time O(n) and logarithmic space O(\log n). The majority vote 
% problem is to determine in any given sequence of choices whether 
% there is a choice with more occurrences than all the others, and if so, 
% to determine this choice. Mathematically, given a finite sequence 
% (length n) of numbers, the object is to find the majority number 
% defined as the number that appears more than floor(n/2) times.%
%
% Example: 
%
% consider we want to find the majority element in 'aaaccbbcccbcc'
% MajorityVote('aaaccbbcccbcc')
% ans =
% c
%
% -------------------------------------------------
% code by: Reza Ahmadzadeh (reza.ahmadzadeh@iit.it)
% -------------------------------------------------
n = size(charArray,2);
% STEP 1: find the character with majority
candidate = charArray(1);
counter = 0;
for ii=1:n
    if counter == 0
        candidate = charArray(ii);
        counter = 1;
    elseif candidate == charArray(ii)
        counter = counter + 1;
    else 
        counter = counter - 1;
    end
end

% STEP 2: Determine if the remaining element is a valid majority element.
counter = 0;
for ii = 1:n
    if charArray(ii) == candidate
        counter = counter + 1;
    end
end

if counter < (n+1)/2 
    disp('There is no Majority');
    candidate = '';
end

end