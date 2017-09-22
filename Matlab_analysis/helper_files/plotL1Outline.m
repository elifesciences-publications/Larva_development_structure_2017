function plotL1Outline(yplane,varargin)
% plotL1Outline(zplane, varargin) plots the L1 outline in correct coordinants 
% as a flat surface at plane yplane with LineSpec given in vargargin.

%%Define coordinants
outlinedata = ' 28.3,-5.8 34.0,-7.1 38.0,-9.4 45.1,-15.5 50.8,-20.6 57.7,-25.4 59.6,-25.6 63.2,-22.8 67.7,-18.7 70.7,-17.2 74.6,-14.3 78.1,-12.8 84.3,-12.6 87.7,-15.5 91.8,-20.9 98.1,-32.4 99.9,-38.3 105.2,-48.9 106.1,-56.4 105.6,-70.1 103.2,-75.8 97.7,-82.0 92.5,-87.2 88.8,-89.1 82.6,-90.0 75.0,-89.9 67.4,-89.6 60.8,-85.6 55.3,-77.2 52.4,-70.2 51.9,-56.7 55.0,-47.0 55.9,-36.4 56.0,-32.1 54.3,-31.1 51.0,-33.4 50.7,-42.5 52.7,-48.6 49.9,-58.4 44.3,-70.8 37.4,-80.9 33.1,-84.0 24.7,-86.0 14.2,-83.9 8.3,-79.1 2.9,-68.3 1.3,-53.5 2.5,-46.9 3.0,-38.3 6.3,-28.2 10.9,-18.7 16.3,-9.7 22.2,-6.4 28.3,-5.8 ';
moreoutlinedata = ' 88.8,-89.1 90.9,-97.7 92.9,-111.3 95.6,-125.6 96.7,-139.4 95.9,-152.0 92.8,-170.2 89.4,-191.0 87.2,-203.7 80.6,-216.6 73.4,-228.3 64.5,-239.9 56.4,-247.3 48.8,-246.9 39.0,-238.3 29.6,-226.9 24.7,-212.0 22.9,-201.2 23.1,-186.9 18.7,-168.3 14.1,-150.4 12.6,-138.0 13.7,-121.5 16.3,-105.1 18.3,-84.8 ';
outlinepts = str2num(outlinedata);
outlinex = 1000 * outlinepts(1:2:length(outlinepts));
outliney = -1000 * outlinepts(2:2:length(outlinepts));
moreoutlinepts = str2num(moreoutlinedata);
moreoutlinex = 1000 * moreoutlinepts(1:2:length(moreoutlinepts));
moreoutliney = -1000 * moreoutlinepts(2:2:length(moreoutlinepts));

allx = [outlinex moreoutlinex];
ally = [outliney moreoutliney];

%%
flatbit.xyz = yplane * ones(length(allx),3);
flatbit.A = zeros(length(allx)+1);
for ii = 1:length(outlinex)-1
    flatbit.A(ii,ii+1) = 1; flatbit.A(ii+1,ii) = 1;
end
flatbit.A(length(outlinex),1); flatbit.A(1,length(outlinex));
for ii = length(outlinex)+1:length(allx)-1
    flatbit.A(ii,ii+1) = 1; flatbit.A(ii+1,ii) = 1;
end
flatbit.A(length(allx),length(outlinex)+1); flatbit.A(1+length(outlinex),length(allx));
flatbit.xyz(:,1) = allx; flatbit.xyz(:,3) = ally;
%%

neuron_plot(flatbit,varargin{:})