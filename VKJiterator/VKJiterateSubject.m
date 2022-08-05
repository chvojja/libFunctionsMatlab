classdef VKJiterateSubject < handle
   properties
      %% Debugging
      verboseOn=true;
      %% This is settings
      subjRootPathsCell; % cell array of paths
      subjNamesCell; % cell array of subjects per one path
      
      %% changing in for loops
      rootWKJ; % current root WKJ path
      subjRootPathsCellIDx; % pointer to paths
      subjName;
      subjPath;
      ks;
      
      fsFolders;
      
   
      
      %subjStruct; % temp structure for Subject
      %foldersFs; % sampling frequencies folders
          
   end 
   methods
      %  Default constructor
 %      function o = iterateFolderClass()
      %     o.verboseOn=true;
         % o = feval(varargin{1},o);
         % tohle jsou cesty k myšim. Složka RootWKJ má vždycky stejnou danou strukturu.
%                o.foldersRootPathsCell{1} = 'J:\WKJ complete first\WKJ_DATA'; % cesta
%                 o.foldersNamesCell{1} = {'jc20181211_1',...
%                                    'jc20181211_2',...
%                                     }; % nazev myši
%               o.foldersRootPathsCell{2} = 'F:\WKJ_MTORMUT 6_1_2020'; % cesta
%               o.foldersNamesCell{2} = {'jc20190327',...
%                                    }; % nazev myši

   %    end
   
        function o = WKJiterateSubjectObj(varargin)
             if ~isempty(varargin)
                 initObj  = varargin{1};
                 mco = ?WKJiterateSubjectObj;
                 for prop = mco.PropertyList'
                    if ismember(prop.SetAccess, {'public', 'protected'}) &&( isfield(initObj,prop.Name) | isprop(initObj,prop.Name) )
                       o.(prop.Name) = initObj.(prop.Name);
                    else
                       warning('could not copy property %s', prop.Name);
                    end
                 end   
             end
        end
        
        
       
       function iterateSubj(o)
            pathIndex=[]; subjs =[];
            Nsubjs=0;
            for kd = 1:numel(o.subjRootPathsCell)
               subjsOnePath = o.subjNamesCell{kd};
               NsubjsOnePath = numel(subjsOnePath);
               Nsubjs = Nsubjs + NsubjsOnePath;
               pathIndex=[pathIndex; kd*ones(NsubjsOnePath,1)];
               subjs = [subjs; subjsOnePath];
            end

            % subjects
            for ks=1:Nsubjs
                o.ks = ks;
                o.rootWKJ = o.subjRootPathsCell{pathIndex(ks)};
                o.subjName =  subjs{ks};
                o.subjRootPathsCellIDx = pathIndex(ks);

                o.subjPath = [o.rootWKJ, '\' o.subjName ];
                o.fsFolders = WKJgetSamplingFreqFolders(o.subjPath);

                if o.verboseOn, disp('I have gathered info about the next subject and Im going to process it.'); end;
                onSubjNext(o);
            end
       end
   end
   
   methods 
       function onSubjNext(o)
           % Expected to be implemented in subclasses
       end 
   end
end