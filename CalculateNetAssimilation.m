%Function file for run_optimization
%Eidata=importdata('Einput_potato.txt'); % Load enzyme activity levels optimized at 280 ppm for rice
%Eidata=importdata('Einput7.txt'); % Load enzyme activity levels optimized at 280 ppm
Eidata=Einput_rice;
%Ei=Eidata.data;
Ei=Eidata;
Einput=ones(37,1); % 
%CO2i = 200; % Set Ci
PPFDi = 2000; % Set light intensity
WeatherTemp = 25; % Set temperature
global Vrubusco_adj; %reset enzyme activity
Vrubusco_adj = 0.7;%set 1.0
global VmaxAdj;% reset enzyme activity
VmaxAdj = 2.1;%set 1.0
global pcfactor;
pcfactor=1;
% Create output vector for A 
NetAssimilationRate = zeros(9,1);
% Loop function to calculate net assimilation rate A for a given Ci value using set of enzyme activity levels optimized for 280
for i=1:15 % No. of A values
CO2i = (140:20:420)'; % Set Ci values ranging from 200 - 360
NetAssimilationRate(i)= EPS_Drive_GRNs(Einput,CO2i(i,1),PPFDi,WeatherTemp,0,0,Ei);

%A =  EPS_Drive_GRNs(Einput,CO2i,PPFDi,WeatherTemp,0,0,Ei); 
end
% Save assimilation rates to output text file
%file=fopen('output_A.txt','w');
%fprintf(file, %6.2f %12.8f\r\n', NetAssimilationRate);
%writematrix(NetAssimilationRate,'output_A.txt','Delimiter','space');