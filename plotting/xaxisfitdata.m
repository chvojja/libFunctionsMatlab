
function xaxisfitdata(hax)
arguments
    hax = gca;
end

    hData = findall(hax.Children,'Type','Line', '-property', 'XData');
    allXdata_C = {hData(:).XData};
    max_allXdata = NaN(numel(allXdata_C),1);
    for i =1:numel(allXdata_C)
        max_allXdata(i) = max(allXdata_C{i});
    end
    max_allXdata = max(max_allXdata);
    hax.XLim(2) = max_allXdata;
end