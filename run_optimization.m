Eidata=importdata('Einput_rice.txt'); % Load enzyme activity levels optimized at 280 ppm for rice
Ei=Eidata.data;
Einput=ones(37,1); % 
CO2i = 360; % Set Ci
PPFDi = 2000; % Set light intensity
WeatherTemp = 25; % Set temperature
global Vrubusco_adj; %reset enzyme activity
Vrubusco_adj = 1.0;
global VmaxAdj;% reset enzyme activity
VmaxAdj = 1.0;
global pcfactor;
pcfactor=1;
%Loop function
%NetAssimilationRate = zeros(9,1);
% for i=1:9
% CO2i = (200:20:360)'; % Set Ci values ranging from 200 - 360
A9 =  EPS_Drive_GRNs(Einput,CO2i,PPFDi,WeatherTemp,0,0,Ei); % Calculate net assimilation rate A for a given Ci value using set of enzyme activity levels optimized for 280
%end