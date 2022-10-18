Ei=importdata('Einput_rice.txt'); % Load enzyme activity levels optimized at 280 ppm for rice
Einput=ones(37,1); % 
CO2i = 200; % Set Ci values ranging from 200 - 360
PPFDi = 2000; % Set light intensity
WeatherTemp = 25; Set temperature
global Vrubusco_adj; reset enzyme activity
Vrubusco_adj = 1.0;
global VmaxAdj;% reset enzyme activity
VmaxAdj = 1.0;
NetAssimilation =  EPS_Drive_GRNs(Einput,CO2i,PPFDi,WeatherTemp,0,0,Ei); % Calculate net assimilation rate A for a given Ci value using set of enzyme activity levels optimized for 280
