function y = val2nan(x)
%val2nan
if isa(x,'double')
    y= NaN;
elseif isa(x,'single')
    y= NaN;
elseif ischar(x)
    y= '';
elseif iscellstr(x)
    y= {''};
elseif isstring(x)
    y= string(NaN);
elseif iscategorical(x)
    y= ''; % '<undefined>'
elseif isdatetime(x)
    y= NaT;
elseif isduration(x)
    y= NaN;

else
    y= NaN;

end


end

%%%%
