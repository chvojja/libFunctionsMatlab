classdef JancaSpike < handle
    %A Constants and Static methods for current analysis
    
    properties   (Constant)

        jancaSpikeSettings = JancaSpike.getSettings();
        
    end

   

    methods (Static)

        function y = getSettings(nv)
                  arguments
                      nv.fs = 5000;
                  end
                        script_jancaSpikeDetectorSettings;
                        y.strict5000Hz.settingsStr = jancaspike.strict5000Hz;
                        y.strict5000Hz.VKJlabelsName = 'strict5000Hz' ;
                        y.strict5000Hz.VKJlabelsColor = ['0 0 1'];
                        
                        y.dontmiss5000Hz.settingsStr  = jancaspike.dontmiss5000Hz;
                        y.dontmiss5000Hz.VKJlabelsName = 'dontmiss5000Hz' ;
                        y.dontmiss5000Hz.VKJlabelsColor = ['0 0.5 0.8'];

                        y.default.settingsStr  = jancaspike.default;
                        y.default.VKJlabelsName = 'default' ;
                        y.default.VKJlabelsColor = ['0.4 0.3 0.2'];
              end



    end
end

