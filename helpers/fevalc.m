function y = fevalc(fhandles) %varargin)
%FUNCELL Avoid this function at all cost
% Dont store a lot of function handles, beware
% % Evaluate cell array of functions without any input arguments or with some
% variant with input arguments is way slower so I commented it out
% Inputs:
% fhandles
% args

%fhandles = varargin{1};


% if ~isempty(fhandles)

        Nhandles = numel(fhandles);
        x = cell(Nhandles,1);
                        for i = 1:Nhandles
                            x{i} = fhandles{i}() ;
                            %x{i} = feval(fhandles{i}) ;
                        end

%       switch nargin 
%           case 1  % multiple arguments
%                         for i = 1:Nhandles
%                             x{i} = fhandles{i}() ;
%                             %x{i} = feval(fhandles{i}) ;
%                         end
%           case 2
%               args = varargin{2};
%                     if ~iscell(args) % single argument for all
%                         for i = 1:Nhandles
%                             x{i} = fhandles{i}( args) ;
%                         end
%                     else
%                        for i = 1:Nhandles
%                             x{i} = fhandles{i}( args{i} ) ;
%                        end
%                     end
%       end

     if iscolumn(fhandles)
        y = cat(1, x{:} );
     else
        y = cat(2, x{:} );
     end
% end



