function Y = table2missingRow(T)
%TABLE2MISSINGROW  Wrapper
arguments
    T;
end

Y = table2missing(T,Nrows=1);

end

