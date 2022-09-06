function T = decategorify(T)
%CATEGORIFY Makes char columns categorical

varTypes = varfun(@class,T,'OutputFormat','cell');

N=numel(varTypes);
    for k=1:N
        fieldName=T.Properties.VariableNames{k};
        varType = varTypes{k};
        
        switch varType
            case 'categorical'
                T.(fieldName) = double(T.(fieldName));

%             case 'cell'
%                 if iscellstr(T{:,k})
%                    T.(fieldName) = categorical(T.(fieldName));
%                 end


        end

        
        
    end

end



