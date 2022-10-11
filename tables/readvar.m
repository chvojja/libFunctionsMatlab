function y = readvar(nv)
%READVAR this function is not the fastest....use loadfun insted
arguments
    nv.Files = [];  % assuming  the files comes from categorical table variable
    nv.ReadFun;
    nv.CatDim=1; % default concatenate along 1 dimension (rows)
% TODO by ID
end

if ~isempty(nv.Files)

    nv.Files = categorical(cellstr(nv.Files));
    N = numel( nv.Files );

%     l = nv.ReadFun( char(nv.Files(1))  );
%     fn=fieldnames(l);
%     fn=fn{1};
    x = nv.ReadFun( char(nv.Files(1))  );
    dim = [1 1];
    dim(nv.CatDim) = N;
    y = repmat( zeros(size(x)) , dim);


    switch nv.CatDim
        case 1
             y(1,:) = x;
            for i = 2:N
                y(i,:) = nv.ReadFun(  char(nv.Files(i))  );
            end
        case 2
            y(:,1) = x;
            for i = 2:N
                y(:,1) = nv.ReadFun(  char(nv.Files(i))  );
            end

    end
     

end



end

