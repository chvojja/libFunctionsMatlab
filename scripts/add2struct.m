function y = add2struct(x,Name, Value)
% adds some data into a growing structure
arguments
    x
end
arguments (Repeating)
    Name;
    Value;
end
    if isempty(x)
        n = 1;
    else
        if numel(fieldnames(x)) == 0
            n = 1;
        else
            n = numel(x) + 1;
        end
    end

    Npairs = (nargin-1)/2;
    for i=1:Npairs
        x(n).(Name{i}) =Value{i};
    end
    y = x;
end

