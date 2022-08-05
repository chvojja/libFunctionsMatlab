classdef Verboser < handle
    % O_verboser Summary of this class goes here
    %   Basic object enabling smart printing of messages either stored in o.mssg or directly printed
    %   Has verbose property - temporarly disables printing
    %   Important ! The message labels may be the same if the number of arguments  differ.
    
    properties
        name;
        verbose; % defualt behavior
        mssg = struct;
    end
    
    methods
        % constructor
        function o = Verboser(pv)
            arguments
                pv.Name = 'DefualtVerboser'; % name of the object
                pv.Verbose = true;
            end
            o.name = pv.Name;
            o.verbose = pv.Verbose;
            % Put here some common messages
            % Errors and Warnings
            o.addMessage('Warning','-------------- A warning ----------------');
            o.addMessage('Error','-------------- An error occured ----------------');
            o.addMessage('ErrorHuge','--------------!!!!!!! Beware, a HUGE ERROR occured! So Bad!!!!!!!----------------');
            o.addMessage('MissingArguments','Fucking arguments not provided.');
            % Computation
            o.addMessage('Progress','Current progress: %d out of %d  %s'); % what out of how much of what
            o.addMessage('ProgressPercent','Current progress: %d %%. '); % what out of 100%
            % Gratefull
            o.addMessage('ThankJane','Honestly, I appreciate your programming skills, Jane.'); 
            o.addMessage('ThankLenka','Honestly, I appreciate your programming skills, Lenka.'); 
            o.addMessage('ThankMe','Honestly, I appreciate your programming skills, Emsik.'); 
            o.addMessage('ThankSomeone','Honestly, I appreciate your programming skills, %s.'); 
            
            
        end
        
        function verboserExample(o)
            o.addMessage('constructor','Hey, %s Im %d years old');
            o.addMessage('fuck','fuck2');
            disp('We added messages and will print one of them and the second one directly by sprinf2:')
            o.sprintf2('constructor', 'debilni', 57);
            o.sprintf2('Hey, %s Im %d years old', 'debilni', 57);
            disp('Verbose is on by default.')
            o.verbose = false;
            disp('Now verbose is off:')
            o.sprintf2('constructor', 'debilni', 57);
            o.sprintf2('Hey, %s Im %d years old', 'debilni', 57);
            disp('Nothing was printed.')
            o.verbose = true;
            disp('Now printing with disp2:')
            disp2(o,'fuck')
        end
       
        
        function sprintf2(varargin)
            % Printing by sprintf is with additional parameters
            % 2 - message label or message
            % 3 - ... parameters
            o=varargin{1};
            if o.verbose
                Nargs = (nargin-2);
                message = o.label2message(varargin{2},Nargs);
                if Nargs>=1 && ~isempty(message)
                    fprintf([ message '\n' ],varargin{3:end}) % Here we could use sprintf but it would also print ans = .... in Matlab cmd
                else
                    disp(message) % pure text is directly printed
                end
            end
        end

        function disp2(o,x)
            % Printing by disp is without any parameters
            % 2 - message label or message
            if o.verbose
                message = o.label2message(x,0);
                disp(message)
            end
        end
 
        function message = label2message(o,label,Nparams)
                mssg_label = [ label '_' num2str(Nparams) ]; % valid message label
                if isfield(o.mssg,mssg_label)
                    message = o.mssg.(mssg_label); % message label translated to message printed with and parameters
                else % if it was not found in message dictionary
                    if Nparams>0
                        message =[];
                    else
                        message = label; % directly printed 
                    end
                end
        end

        function addMessage(o,label,message)
            % adds a label to a message dictionary
             Nargs = numel(    regexp(message,'(?<!%)%(?!%)' )   ); % matches only % that are alone, e.g. not preceded or followed by %
             mssg_label = [ label '_' num2str(Nargs) ];
             o.mssg.(mssg_label) = message;
        end

        

    end

end