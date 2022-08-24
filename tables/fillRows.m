function y = fillRows(nv)
%STRUCT2ROWS Summary of this function goes here
%   Detailed explanation goes here
arguments
        nv.Sources = []; % struct or table row or cell array of either struct or table row 
        nv.Source = []; % even element cell array of Key-Value pairs
    nv.Target;
    nv.Rows;
    nv.Overwriting = false;
    nv.Verbose = true;
end

     %% Prepare data
     if (  isempty(nv.Sources) && isempty(nv.Source)   )
         disp2(nv.Verbose,'Not enough arguments');
         return
     else
        totalDataStruct = [];
        if ~isempty(nv.Sources)
            totalDataStruct = fields2struct(Sources = nv.Sources,OverwriteSameFields = nv.Overwriting); 
        end
        if ~isempty(nv.Source)
            singleSourceStruct = cell2namedargs(nv.Source);  
            totalDataStruct = structMerge(Source=singleSourceStruct,Target = totalDataStruct,OverwriteSameFields=nv.Overwriting);
        end     
     end


    %% Updating the Target from the Sources

    fieldsC = fieldnames(totalDataStruct);
    for kf = 1:numel(fieldsC)
         fieldName = fieldsC{kf};

         if isfieldt(nv.Target,fieldName) 

            
            for kr = 1: numel(nv.Rows)
                 b_writeNoCell = false;
                 b_missing = ismissingt(nv.Target.(fieldName)(nv.Rows(kr)));
                 b_missing(isnan(b_missing))=true; % dont care about logicals that cant be determined if missing or not
                 switch class(nv.Target.(fieldName)(nv.Rows(kr)))
                     case 'cell'
                         b_equal =  isequaln(  nv.Target.(fieldName){nv.Rows(kr)}  ,  totalDataStruct.(fieldName)    ); % compare values 
                         if (~b_equal && b_missing)
                             nv.Target.(fieldName)(nv.Rows(kr)) = { totalDataStruct.(fieldName)  } ;
                         else
                             if (nv.Overwriting )
                                 nv.Target.(fieldName)(nv.Rows(kr)) =  { totalDataStruct.(fieldName)  } ;
                             end
                         end
                     otherwise
                         b_equal =  isequaln(  nv.Target.(fieldName)(nv.Rows(kr))  ,  totalDataStruct.(fieldName)    ); % compare values 
                         if (~b_equal && b_missing)
                             b_writeNoCell = true   ;
                         else
                             if (nv.Overwriting )
                                 b_writeNoCell = true   ;
                             end
                         end
                         
                         if b_writeNoCell
                            if ~isempty(totalDataStruct.(fieldName)) 
                                writeVal = totalDataStruct.(fieldName);
                            else
                                writeVal = NaN;
                            end
                            nv.Target.(fieldName)(nv.Rows(kr)) =  writeVal   ; 
                         end

                 end
            end

         else
             disp2(nv.Verbose,['Column ' fieldName ' not present in Target.' ])
         end
    end
    
    y = nv.Target;

end

