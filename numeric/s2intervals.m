function [ intervals_len , onsetsIdx, offsetsIdx ] = s2intervals(s)
%S2INTERVALS 
% This ignores unfinished intervals e.g non zeros at the beggining or end of the s signal

% n = lengths of consecutive intervals
% is = start indexes of intervals
% ie = end indexes if intervals
s = logical(s); % anything non zero is considered to be an interval
dx = diff(s);

%     if x(end)<=0
   onsetsIdx = find(dx>0)+1; 
   offsetsIdx = find(dx<0); 

   if ~isempty(onsetsIdx) && ~isempty(offsetsIdx) 

       if offsetsIdx(1) < onsetsIdx(1) % if first interval does not start from zero
           offsetsIdx = offsetsIdx(2:end);
       end
    
       if offsetsIdx(end) < onsetsIdx(end) % if last interval  is not finished
           onsetsIdx = onsetsIdx(1:end-1);
       end
   end

   intervals_len = offsetsIdx-onsetsIdx+1;
 
end


