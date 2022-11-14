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



function returnPop = mutate(pop, popSize, mutatePercentage)

%%%% Global Variables %%%%

global BK;
global MW;
global VmaxNum;

global NTotal;
tempPop = zeros((VmaxNum+2),1);   % Create a vector of the size of Vmax+2
for j = 2:popSize
                sum=0;
                for m = 3:(VmaxNum+2)
			        if m==11
                        Nothing =1;
                        
                    elseif m==9     % For the transketolase, only count once. 
                        Nothing =1;                
                    else
			            rng shuffle % shuffle random values so there is no repetition of sequence from the random number generator
                        randval = 1 - 2 * rand(1);
                        tempPop(m) = (1+randval * mutatePercentage) * pop(m,j);
                        sum = sum + (tempPop(m)/BK(m-2))*MW(m-2);       % mg protein l-1 
                   end
                end
                

                Ratio = NTotal/sum;
                pop(:,j) = tempPop * Ratio;
end
returnPop = pop;
