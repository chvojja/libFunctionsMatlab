function y = randpickpercent(Inds,percHowMuch)


Nids=numel(Inds);

NhowMuch = ceil(Nids*percHowMuch/100);

selIdx = randperm(Nids,NhowMuch);
y = Inds(selIdx);