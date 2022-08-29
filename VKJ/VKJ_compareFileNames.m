function y=VKJ_compareFileNames(str1,str2,nv)
arguments
    str1;
    str2;
    nv.LabelMatchingEEG = true;
end


    if nv.LabelMatchingEEG
        str1 = char(str1);
        str2 = char(str2);
        [subject1,number1,time_str1,device1,type1]=VKJ_parseFileName( str1 );
        [subject2,number2,time_str2,device2,type2]=VKJ_parseFileName( str2 );


         

        if strcmp([ subject1 time_str1],[subject2 time_str2]) && ~strcmp(type1,type2) % strcmp(str1(1:28),str2(1:28)) %
            y =true;
        else
            y = false;
        end
    end

end