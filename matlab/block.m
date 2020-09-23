classdef block
    %Old Simulink log style
    %Contains information about a signal name and attributes for each
    %signal
    
    properties
        name = 'log';
        rms = 0;
        df1 = 0;
        df2 = 0;
    end
    
    methods
        function obj = block(name,rms,df1,df2)
            %Construct block with the rms voltage and the two discrete
            %fourier outputs
            obj.name = name;
            obj.rms = rms;
            obj.df1 = df1;
            obj.df2 = df2;
        end 
    end
end

