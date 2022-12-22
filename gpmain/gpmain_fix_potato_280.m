%   Copyright   Xin-Guang Zhu and Stephen P. Long, University of Illinois 
%   Copyright ©  2007

%   This file is part of CarbonMetabolism.

%    CarbonMetabolism is free software; you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation; either version 3 of the License, or
%    (at your option) any later version.

%    CarbonMetabolism is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.

%    You should have received a copy of the GNU General Public License (GPL)
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function gpmain_fix_potato_280(Ci, CO2_fix_280_potato)
global Vrubusco_adj;
Vrubusco_adj=1.0; %keep as 1.0 after fixed optimization
global VmaxAdj;%
VmaxAdj=1.0;

%Ci=280;% adj 200,220,240 or 260
CO2i=Ci;% adj 200,220,240 or 260 %CO2i=Ci
PPFDi=2000;
WeatherTemp=25;
GRNC=0;
Einput=ones(37,1);%No gene expression data input
%Edata=importdata('Einput7.txt');
Edata=importdata('Einput_potato_129.txt');
Eio=Edata.data(:,1);
Eio(1)=Edata.data(1,1)*Vrubusco_adj;
Eio(2:26)=Edata.data(2:26,1)*VmaxAdj;
Enzyme=importdata('MW&Kcat.txt');
MWKcat=Enzyme.data;
%%%%%%%%%%%%%%%%%%% Initialize Variables %%%%%%%%%%%%%%%%%%%
global pcfactor; 
pcfactor=1;
global VmaxNum;
%global NConc; 
% IntContinue = 0;        % This is a flag to indicate whether we need to use the external data or not for the initialization. Default is 0.
% WriteExcel = 0;

% The following variables are used to output data from the simulation. 

global d_plot;
global Tt_plot;

% global NetCarbon_plot;
% global PS_VEL_gpmain;

global GP;
GP = 1;         % This is a parameter used for transfer infomration to the PSRate file. 
global TimeBegin;
TimeBegin = clock;

global Optiona;
Optiona =0;     % The option used in the mutate.m file for creating mutation.

%WARNING population size (PopSize) must be divisible by 4
popSize = 16;       
numofGen = 1500;       % The total number of generations    
mutatePercentage = 0.02;     % Maximal percentage of changes in Vmax in each generation

% Different options of generating new population. Default is 1. 
generationTransfer = 1; 
VmaxNum = 26;           % The number of enzymes used in the optimization. 

factor = 1;
ScaleR = factor;        % This is a factor used to modify the enzyme concentration.

%%%% Initialize Population Array %%%%

% Coeff = 1/30/3600*1000;

pop = zeros(VmaxNum+2,popSize);

% In the pop matrix, the first element is rank; 2rd: the CO2 uptake rate; 3:VmaxNum + 2, different Vmax;

for i = 1:popSize
pop(3:28,i)=Eio(1:26);
end


%%%% Initialize BK and MW Array %%%%

global BK;
BK=MWKcat(:,2);
global MW;
MW=MWKcat(:,3);


% Calculate the default nitrogen concentration
sumd = 0;
for k = 1:VmaxNum
    sumd= sumd + pop(k+2,1)/BK(k)*MW(k);
end 
sumd = sumd- pop(9,1)/BK(7)*MW(7)-pop(11,1)/BK(9)*MW(9)-pop(13,1)/BK(11)*MW(11)-pop(14,1)/BK(12)*MW(12);      % The transketolse is double counted. So, it is corrected at here. 


% NConcDefault = sumd/1000/33 * 0.16;        % This is the default nitrogen concentraion for those enzymes in the carbon metabolism pathway. 
% NConc = NConcDefault * factor;
% NConc = NConc * 1000 * 33 /0.16       % mg protein l-1

global NTotal;
%NTotal = sumd * factor
NTotal = sumd
%%%% Mutate Initial Population %%%%
tempn = popSize/8;
temp_pop=pop(:,1:tempn);
pop = mutate(pop, popSize, mutatePercentage);
pop(:,1:tempn) = temp_pop;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% global gp2condition_RuCon;
CO2PLOT = zeros(3,5);  
% 1: Generation number; 2: Average; 3, Error bar; 

TAVMatrix = zeros(numofGen,VmaxNum+2);
TSTDMatrix = zeros(numofGen,VmaxNum+2);
TBestMatrix = zeros(numofGen,VmaxNum+2);

for i = 1:numofGen
    
    %%%%%%%%%%%%% Test Population %%%%%%%%%%%%%%
    
% Store CO2 Assimilation Rate into pop
    
      disp('generation:');i
%     display('Time passed:'); 
%     Lapse = clock-TimeBegin
    
    for j = 1:popSize
%         gp2condition_RuCon = pop(3,j)/2;
%         global gp2V111;
%         gp2V111 = pop(3,j) * 0.24;            % Here the rate of Rubisco oxygenation is adjusted.
            %Temp = CM_Drive(pop, j);
            Eiopop=Eio;
            Eiopop(1:26)=pop(3:28,j);
            Eiopop(7)=Eiopop(4);
            Eiopop(9)=Eiopop(6);
	        Eiopop(11)=Eio(11);
            Eiopop(12)=Eio(12);%VATP synthesis not used

            %Fixing minimal enzyme level constraints for photorespiratory metabolites from optimization at 129 ppm 
            %Sub in correct values when optimization at 129 completes%
            if Eiopop(13)<50.23510928
            disp('Phosphoglycolate phosphatase value is below the limit.')
            continue
            elseif Eiopop(14)<110.5936341
            disp('Glycerate kinase value is below the limit.')
            continue
            elseif Eiopop(15)<23.02766342
            disp('(S)-2-hydroxy-acid oxidase & Catalase value is below the limit.')
            continue
            elseif Eiopop(16)<28.36522879
            disp('Serine-glyoxylate transaminase value is below the limit.')
            continue
            elseif Eiopop(17)<208.4888462
            disp('Glycerate dehydrogenase value is below the limit.')
            continue
            elseif Eiopop(18)<30.42616687
            disp('Glycine transaminase value is below the limit.')
            continue
            elseif Eio(19)<13.86877939
            disp('Glycine dehydrogenase (aminomethyl-transferring) value is below the limit.')
            continue
            else
            end % All values within constraints, so analysis can proceed

            Temp=EPS_Drive_GRNs(Einput,CO2i,PPFDi,WeatherTemp,GRNC,0,Eiopop);
            % #check whether the concentrations of metabolites reach steady states#
            sizeT=size(d_plot);
            global tglobal;
            Tcheck = tglobal * 4/5;             
            
            Tindex = find(Tt_plot>Tcheck);    
            IndexMiddle = Tindex(1);
            ddiff=d_plot(sizeT(1),53:87)-d_plot(IndexMiddle,53:87);%metabolites
            dnorm1 = norm(ddiff);
            tdiff = Tt_plot(sizeT(1))-Tt_plot(IndexMiddle);
            sloped = dnorm1/tdiff/0.01;
            
            if sloped < 10^(-3)
                pop(2,j) = Temp;
            else
                pop(2,j) = 0;
            end
            
            
            test = pop(2,j);
   
    end

    %%%%%%%%%%% Rank Population %%%%%%%%%%%
    pop = rankPop(pop,popSize);
    
    %%%%%% Save optimization Statistics %%%%%%%%
    AVMatrix = average(pop,popSize);
    STDMatrix = stdev(pop,popSize);
    BestMatrix = pop(:,1)';
    
    TAVMatrix(i,:)=AVMatrix;
    TSTDMatrix(i,:)=STDMatrix;
    TBestMatrix(i,:)=BestMatrix;
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Check if this is the last generation
    CO2PLOT(1,i) = i;
    CO2PLOT(2,i) = AVMatrix(2);
    CO2PLOT(3,i) = STDMatrix(2);

    %mcc nojvm does not use the Java Virtual Machine (JVM) so comment out
    %all figure rendering commands to avoid errors
    %errorbar(CO2PLOT(1,:),CO2PLOT(2,:),CO2PLOT(3,:)); pause(5);
    %xlim([1, i+1]); ylim([0,80]);  
        %Resize Pop Array
        switch generationTransfer
            case 1
                pop = resizePop(pop, popSize);
            case 2
                pop = twoPoint(pop,popSize);
        end
        % Mutate Population
        pop = mutate(pop, popSize, mutatePercentage);
	  if rem(i/100,1)==0
        i
        save CO2_fix_potato_280;     % Save the work space
        %Save matrix of optimal enzyme rates to output file
%         file=fopen('outputenz_129_rice.txt','w');
%         fprintf(file,'%.4f\n',BestMatrix);
          writematrix(BestMatrix,'outputenz_fix_280_potato.txt');
          writematrix(d_plot,'d_plot_fix_280_potato.xls');
          %save CO2_129_potato_280;
      end
	%Save workspace
	%save output_potato_129_280;
end