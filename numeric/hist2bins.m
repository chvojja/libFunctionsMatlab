function y = hist2bins(x)
%FREQENCIES2INDS Summary of this function goes here
%   Detailed explanation goes here

x = x(:);
[pos_ind,~,vals] = find(x);
y = [];
for i=1:numel(pos_ind)
    ynew = pos_ind(i)*ones(vals(i),1);
    y = [ y ; ynew];
end

end

