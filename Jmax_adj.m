clear all;

Vcmax_m=105.1452508;% potato Vcmax 
Jmax_m=158.6924474;% potato Jmax

%%%%%%%%%%
Lii=1800;%light intensity
%Farquhar model parameters
%Gr=38.6;%µbar von caemmerer 2020 %Gamma Star
Gr=41.36971778;%µbar %Gamma Star from fitting
%Rd=1;
Rd=2.319107419; %Rd from fitting
I2=Lii/2*0.85*(1-0.15);
Theta=0.7;
Kc=272;%µbar
Ko=166;%mbar Sharkey 2007
O=210;%mbar
J=(I2+Jmax_m-sqrt((I2+Jmax_m)^2-4*Theta*I2*Jmax_m))/(2*Theta);
%%%%%%%%%%%%%%%%%%%%%
CA=[800,1200,1500,1800];
global Vrubusco_adj;
Vrubusco_adj=1.12;
global VmaxAdj;%adjust enzyme activity


global pcfactor;  
ProteinTotalRatio=0;
pcfactor=1/ProteinTotalRatio;
% inE=importdata('MeM_input5_0.txt');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Input conversion
% InputF=importdata('GrCM_output.txt');
% DataCol=InputF.textdata(1,:);
% idx = find(ismember(DataCol, 'Ele:Amb' ));
% DataGeneID=InputF.textdata(:,1);
% GeneNo=size(inE.textdata,1)-1;
% ExpValue=ones(GeneNo,1);
% for i=1:GeneNo
%     if find(ismember(DataGeneID,string(inE.textdata(i+1,1))))
%     idRow=find(ismember(DataGeneID,string(inE.textdata(i+1,1))));
%     ExpValue(i,1)=InputF.data(idRow-1,idx-2);
%     end
% end
% Einput=ExpValue;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Einput=ones(37,1);%No gene expression data input
Edata=importdata('Einput7.txt');
Eio=Edata.data(:,1);
MetaOnly=0;% if MetaOnly=1 run only Metabolic model
WeatherTemp=25;
WeatherRH=0.6;
WeatherWind=5;
Convert=1E6/(2.35E5); %Convert W m^{-2} to u moles m^{-2} s^{-1}
Radiation_PAR=Lii/Convert*0.85*0.85;%%%%
Radiation_NIR=0;
Radiation_LW=0;
PhotosynthesisType=1.1;
Vcmax25=100;
Jmax25=200;
GRNC=0;

for j=1:25
    j
VmaxAdj=2.0+j*0.02;%adjust enzyme activity  %modify ratio 1.2 to 1.4 (or greater) if no fit %default 0.8
Eio(1)=Edata.data(1,1)*Vrubusco_adj;
Eio(2:27)=Edata.data(2:27,1)*VmaxAdj;

for i=1:4
Air_CO2=CA(i);
if MetaOnly==1
CO2i=Air_CO2*0.7; % intercellular CO2 
PPFDi=Lii;
NetAssimilation=EPS_Drive_GRNs(Einput,CO2i,PPFDi,WeatherTemp,GRNC,0,Eio);
else
LeafResult=Leaf(WeatherRH,WeatherTemp,Air_CO2,WeatherWind,Radiation_PAR,Radiation_NIR,Radiation_LW,PhotosynthesisType,Vcmax25,Jmax25,GRNC,Einput,Eio);
Ci=LeafResult(1);
NetAssimilation=LeafResult(2);
Gs=LeafResult(3);
LeafTemperature=LeafResult(4);
Transpirationi=LeafResult(5);
end
%calculate masured A values at different Ci)
ACI_m=J*(Ci-Gr)/(4*Ci+8*Gr)-Rd;
ACi_evsm(i)=(ACI_m-NetAssimilation)^2;%the squares of the residuals
end
SSR(j,1)=VmaxAdj;
SSR(j,2)=sum(ACi_evsm);%the sum of the squares of the residuals
end
% fileID = fopen('LeafmetaOut.txt','w');
% fprintf(fileID,'%6s\n','A');
% fprintf(fileID,'%6.2f\n',NetAssimilation);
% fclose(fileID);