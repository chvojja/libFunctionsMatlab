function [tblTags,tblVals] = tablesCompare(T1,T2,tblQuest)
%TABLESCOMPARE Compares two tables T1 and T2
% takes a structure of tags with specified conditions on which to respond
% 
tags = fieldnames(tblQuest);
Ntags=length(tags);

unn = structUnnest(tblQuest);
Nq=size(unn,1);
columnsToExplore = unique(unn(:,3));
statementsToVerify = unique(unn(:,2));


% for kt = 1:Ntags
%     tag = tags{kt};
%     unn = structUnnest(tblQuest.(tag));
%     columnsToExplore = unique(unn(:,2));
%     sss
% 
% end



for kt = 1:Ntags
    tag = tags{kt};
    statements = fieldnames(tblQuest.(tag));
    Ns=numel(statements)
    for ks = 1:Ns
        statement = statements{ks};
        column = tblQuest.(tag).(statement);
        value = tblQuest.(tag).(statement).(column);
        tblVals.
        switch statement
            case 'missing'
                tblQuest.(tag).missing.(column)
                
    end
%     unn = structUnnest(tblQuest.(tag));
%     columnsToExplore = unique(unn(:,2));
    sss

end

tags = [];
vals = [];

end

