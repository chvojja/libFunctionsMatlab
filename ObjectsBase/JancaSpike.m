classdef JancaSpike < handle
    %A Constants and Static methods for current analysis
    
    properties   (Constant)

        strict5000Hz =  JancaSpike.getSettings( Name = 'strict5000Hz' );
        dontmiss5000Hz =  JancaSpike.getSettings( Name = 'dontmiss5000Hz' );
        default =  JancaSpike.getSettings( Name = 'default' );

    end

   

    methods (Static)

        function y = getSettings(nv)
                  arguments
                      nv.Fs = 5000;
                      nv.Name = [];
                  end

                  switch nv.Name 
                      case 'strict5000Hz'

                        y.settingsStr = ['-k1 5.50 -k2 5.50 -k3 0 -w 5000 -n 4000' ]; %    Candidate for the most strict settings, sharp and high amplitude
                        y.VKJlabelsName = 'strict5000Hz' ;
                        y.VKJlabelsColor = ['0 0 1'];

                      case 'dontmiss5000Hz'               

                        y.settingsStr  = ['-k1 4.50 -k2 4.00 -k3 0.2 -w 5000 -n 4000' ]; %
                        y.VKJlabelsName = 'dontmiss5000Hz' ;
                        y.VKJlabelsColor = ['0 0.5 0.8'];

                      case 'default'

                        y.settingsStr  = ['-k1 3.65 -k2 3.65 -k3 0' ];
                        y.VKJlabelsName = 'default' ;
                        y.VKJlabelsColor = ['0.4 0.3 0.2'];
                  end
              end



    end
end

