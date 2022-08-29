classdef JancaSpike 
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
                        y.IED_strict5000Hz.settingsStr = jancaspike.strict5000Hz;
                        y.IED_strict5000Hz.VKJlabelsName = 'IED_strict5000Hz' ;
                        y.IED_strict5000Hz.VKJlabelsColor = ['0 0 1'];
                        
                        y.IED_dontmiss5000Hz.settingsStr  = jancaspike.dontmiss5000Hz;
                        y.IED_dontmiss5000Hz.VKJlabelsName = 'IED_dontmiss5000Hz' ;
                        y.IED_dontmiss5000Hz.VKJlabelsColor = ['0 0.5 0.8'];

              end



    end
end

