classdef MExperiment
    % MExperiment Summary of this class goes here
    %   Object holds information about a experimental subject
    
    properties
        Property1
    end
    
    methods
        function obj = VKJsubject(inputArg1,inputArg2)
            %VKJSUBJECT Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

