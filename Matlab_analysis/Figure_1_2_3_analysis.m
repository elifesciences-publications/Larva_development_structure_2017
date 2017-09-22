%%
% Figure 1 panels
%%%

load neuron_base_data

%% Set up colors
orgs = cbrewer('seq','Oranges',8);
clrs.dda = orgs(8,:);
clrs.vpr = orgs(6,:);
clrs.vda = orgs(4,:);

%% Panel B: Morphology of mdIVs

% Set boundaries to equalize scale. 
l1a_xmin = 34170; l1a_xmax = 78736; l1a_scale = l1a_xmax - l1a_xmin;
l3_xmin = 18000; l3_xmax = 125614; l3_scale = l3_xmax - l3_xmin;

fid = figure('Color','w','Position',[6         158        1428         647]);
subplot(1,2,1);
neuron_plot( neurons_l1a_sp( 13 ), 'LineWidth',2, 'Color', clrs.dda );
neuron_plot( neurons_l1a_sp( 14 ), 'LineWidth',2, 'Color', clrs.dda ); 
neuron_plot( neurons_l1a_sp( 15 ), 'LineWidth',2, 'Color', clrs.vpr ); 
neuron_plot( neurons_l1a_sp( 16 ), 'LineWidth',2, 'Color', clrs.vpr ); 
neuron_plot( neurons_l1a_sp( 17 ), 'LineWidth',2, 'Color', clrs.vda ); 
neuron_plot( neurons_l1a_sp( 18 ), 'LineWidth',2, 'Color', clrs.vda ); 

axis vis3d
set(gca,'Visible','off','XLim',l1a_xmin+l1a_scale/2 - [l3_scale/2 -l3_scale/2])
view(0,0)

subplot(1,2,2);
neuron_plot( neurons_l3( 13 ), 'LineWidth',2, 'Color', clrs.dda ); 
neuron_plot( neurons_l3( 14 ), 'LineWidth',2, 'Color', clrs.dda ); 
neuron_plot( neurons_l3( 15 ), 'LineWidth',2, 'Color', clrs.vpr ); 
neuron_plot( neurons_l3( 16 ), 'LineWidth',2, 'Color', clrs.vpr ); 
neuron_plot( neurons_l3( 17 ), 'LineWidth',2, 'Color', clrs.vda ); 
neuron_plot( neurons_l3( 18 ), 'LineWidth',2, 'Color', clrs.vda ); 

axis vis3d
set(gca,'Visible','off','XLim',[l3_xmin l3_xmax],'ZDir','reverse','XDir','reverse')
view(-8,0)

% export_fig(fid,'morphology_mdiv.pdf')
% close(fid)

%% Panel C / D : Morphology of ppk termianls with synapses.

ppk_ind = 4;
fid = figure('Color','w','Position',[6         158        1428         647]);
subplot(1,2,1);
neuron_plot( neurons_l1a_sp( 12+ppk_ind ),'withsyn', 'LineWidth',2, 'Color', 'k' );
axis vis3d
set(gca,'Visible','off','XLim',l1a_xmin+l1a_scale/2 - [l3_scale/2 -l3_scale/2])
view(0,0)

subplot(1,2,2);
neuron_plot( neurons_l3( 12+ppk_ind ),'withsyn', 'LineWidth',2, 'Color', 'k' );
axis vis3d
set(gca,'Visible','off','XLim',[l3_xmin l3_xmax],'ZDir','reverse','XDir','reverse')
view(-8,0)

%% Panel E: Number of synapses 

figure('Color','w','Position',[   440   472  183   139   ]); hold on;
x_ddaC = 1 + 2*[-0.15:0.1:0.15];
bar(x_ddaC,[ppk_out(1:2,1); ppk_out(1:2,2)]','FaceColor',clrs.dda,'EdgeColor','none')

x_vpda = 2 + 2*[-0.15:0.1:0.15];
bar(x_vpda,[ppk_out(3:4,1); ppk_out(3:4,2)]','FaceColor',clrs.vpr,'EdgeColor','none')

x_vda = 3 + 2*[-0.15:0.1:0.15];
bar(x_vda,[ppk_out(5:6,1); ppk_out(5:6,2)]','FaceColor',clrs.vda,'EdgeColor','none')

set(gca,'YGrid','on','YLim',[0 1000],'XLim',[0.55 3.5],'TickDir','out','XTick',[1:3],'XTickLabel',ppk_names)
title('Axonal outputs')
ylabel('Synapses')

%% Panel F: Ratio

figure('Color','w','Position',[   440   472  103   139   ]); hold on;
plot(0.8,sum(ppk_out(1:2,2))./sum(ppk_out(1:2,1)),'Marker','d','MarkerFaceColor',clrs.dda,'MarkerEdgeColor','none','MarkerSize',10)
plot(1.0,sum(ppk_out(3:4,2))./sum(ppk_out(3:4,1)),'Marker','d','MarkerFaceColor',clrs.vpr,'MarkerEdgeColor','none','MarkerSize',10)
plot(1.2,sum(ppk_out(5:6,2))./sum(ppk_out(5:6,1)),'Marker','d','MarkerFaceColor',clrs.vda,'MarkerEdgeColor','none','MarkerSize',10)
set(gca,'YLim',[1 6],'XLim',[0.7 1.3],'YTick',1:6,'TickDir','out','YGrid','on','XTick',[])
ylabel('L3/L1 synapse ratio')

%% Panel G: Polyadicity

poly_l1 = [];
poly_l3 = [];

for ii = 13:18
    poly_l1 = [poly_l1  neurons_l1a_sp(ii).synsout.numTargs];
    poly_l3 = [poly_l3  neurons_l3_sp(ii).synsout.numTargs];
end

figure('Color','w')
histogram(poly_l3,'Normalization','pdf','DisplayStyle','stairs')
hold on
histogram(poly_l1,'Normalization','pdf','DisplayStyle','stairs')
set(gca,'Box','off','TickDir','out')
xlabel('Number of postsynaptic sites per presynaptic site')

%%
% Figure 2 panels
%%%
%%

%% Figure 2

inds_ppk = [49    50    51    52    53    54];
inds_loc = [3     4     5     6    13    14    15    16    19    20    27    28    29    30    31    32    37    38    39    40    43    44];
inds_reg = [7     8     9    10    21    22    23    24    25    26    33    34];
inds_da = [41    42];
inds_ga = [1     2    11    12    35    36    45    46    47    48];

%% Panel A : L1v Sensory to Sensory+Interneurons
% Without interneurons

figure('Color','w','Position',[   440   400   206   398]); hold on;
neuron_plot( neurons_noci( inds_ppk(1) ), 'LineWidth', 2, 'Color', clrs.vpr );
neuron_plot( neurons_noci( inds_ppk(2) ), 'LineWidth', 2, 'Color', clrs.vpr);
neuron_plot( neurons_noci( inds_ppk(3) ), 'LineWidth', 2, 'Color', clrs.vpr);
neuron_plot( neurons_noci( inds_ppk(4) ), 'LineWidth', 2, 'Color', clrs.vpr);
neuron_plot( neurons_noci( inds_ppk(5) ), 'LineWidth', 2, 'Color', clrs.vpr);
neuron_plot( neurons_noci( inds_ppk(6) ), 'LineWidth', 2, 'Color', clrs.vpr);

plotL1Outline(0,'LineWidth',1,'Color',[0.7 0.7 0.7])
view([180 180]);
set(gca,'Visible','off')
axis vis3d

% With interneurons
figure('Color','w','Position',[   440   400   206   398]); hold on;
neuron_plot( neurons_noci( inds_ppk(1) ), 'LineWidth', 2, 'Color', clrs.vpr );
neuron_plot( neurons_noci( inds_ppk(2) ), 'LineWidth', 2, 'Color', clrs.vpr);
neuron_plot( neurons_noci( inds_ppk(3) ), 'LineWidth', 2, 'Color', clrs.vpr);
neuron_plot( neurons_noci( inds_ppk(4) ), 'LineWidth', 2, 'Color', clrs.vpr);
neuron_plot( neurons_noci( inds_ppk(5) ), 'LineWidth', 2, 'Color', clrs.vpr);
neuron_plot( neurons_noci( inds_ppk(6) ), 'LineWidth', 2, 'Color', clrs.vpr);

inds_interneuron = [inds_loc inds_reg inds_da inds_ga];
for ii = 1:length(inds_interneuron)
        neuron_plot( neurons_noci( inds_interneuron(ii) ), 'LineWidth', 2, 'Color', 0.1+0.5*rand()*[1 1 1]);
end

plotL1Outline(0,'LineWidth',1,'Color',[0.7 0.7 0.7])
view([180 180]);
set(gca,'Visible','off')
axis vis3d

%% Panel B : L3v Sensory to Sensory+Interneurons
figure('Color','w')
hold on;
for ii = 13:18
    neuron_plot( neurons_l3_sp( ii ), 'LineWidth',2, 'Color', clrs.vpr );
end

for ii = 1:12
    neuron_plot( neurons_l3_sp( ii ), 'LineWidth',2, 'Color', 0.1+0.5*rand()*[1 1 1]);
end
neuron_plot( l3_profile, 'LineWidth',1,'Color', [0.7 0.7 0.7])
axis vis3d
set(gca,'Visible','off','XLim',[l3_xmin l3_xmax])
view(-180,3)

%% Panel C : Interneurons

cl = 'k';
cind = 5;
ind = 12;

figure('Color','w','Position',[6         158        1428         647])
subplot(1,2,1);
neuron_plot( neurons_l3_sp( ind ), 'LineWidth',2, 'Color', clrs_ord{cind} );
neuron_plot( l1a_profile, 'LineWidth',1,'Color', [0.7 0.7 0.7])
for ii = 1:6
   neuron_plot( neurons_l3_sp( ii+12 ), 'LineWidth',2, 'Color', clrs.vpr ); 
end
axis vis3d
set(gca,'Visible','off','XLim',l1a_xmin+l1a_scale/2 - [l3_scale/2 -l3_scale/2])
view(8,-85)

subplot(1,2,3);
neuron_plot( neurons_l3( ind ), 'LineWidth',2, 'Color', clrs_ord{cind} );
neuron_plot( l3_profile, 'LineWidth',1,'Color', [0.7 0.7 0.7])
for ii = 1:6
   neuron_plot( neurons_l3( ii+12 ), 'LineWidth',2, 'Color', clrs.vpr ); 
end
axis vis3d
set(gca,'Visible','off','XLim',[l3_xmin l3_xmax])
view(8,-85+180)

%% Compute synaptic inputs/outputs by compartment.

syn_d_in = zeros( length(neurons_l1a_sp), 3);
syn_d_out = zeros( length(neurons_l1a_sp), 3);
syn_a_in = zeros( length(neurons_l1a_sp), 3);
syn_a_out = zeros( length(neurons_l1a_sp), 3);

for ii = 1:length(neurons_l1a_sp)
    syn_d_in(ii,1) = sum( neurons_l1a_sp(ii).synsin.is_dendritic == 1 );
    syn_a_in(ii,1) = sum( neurons_l1a_sp(ii).synsin.is_dendritic == 0 );
    
    syn_d_in(ii,2) = sum( neurons_l1b_sp(ii).synsin.is_dendritic == 1 );
    syn_a_in(ii,2) = sum( neurons_l1b_sp(ii).synsin.is_dendritic == 0 );
    
    syn_d_in(ii,3) = sum( neurons_l3_sp(ii).synsin.is_dendritic == 1 );
    syn_a_in(ii,3) = sum( neurons_l3_sp(ii).synsin.is_dendritic == 0 );
    
    syn_d_out(ii,1) = sum( neurons_l1a_sp(ii).synsout.numTargs( neurons_l1a_sp(ii).synsout.is_dendritic == 1 ) );
    syn_a_out(ii,1) = sum( neurons_l1a_sp(ii).synsout.numTargs( neurons_l1a_sp(ii).synsout.is_dendritic == 0 ) );
    
    syn_d_out(ii,2) = sum( neurons_l1b_sp(ii).synsout.numTargs( neurons_l1b_sp(ii).synsout.is_dendritic == 1 ) );
    syn_a_out(ii,2) = sum( neurons_l1b_sp(ii).synsout.numTargs( neurons_l1b_sp(ii).synsout.is_dendritic == 0 ) );
    
    syn_d_out(ii,3) = sum( neurons_l3_sp(ii).synsout.numTargs( neurons_l3_sp(ii).synsout.is_dendritic == 1 ) );
    syn_a_out(ii,3) = sum( neurons_l3_sp(ii).synsout.numTargs( neurons_l3_sp(ii).synsout.is_dendritic == 0 ) );
    
end

%% 1a) Plot total number of LN synapses as bar plots. Use dots for multiples, not absolute quantities.

figure('Color','w','Position',[   440   626   317   172]); hold on;
x_pl = 1 + 2*[-0.35:0.1:0.35]-0.35;
bar(x_pl,[syn_d_in(inds_pl,1); syn_d_in(inds_pl,3)]','FaceColor',clrs.pl,'EdgeColor','none')

x_b2 = 2 + 2*[-0.15:0.1:0.15];
bar(x_b2,[syn_d_in(inds_b2,1); syn_d_in(inds_b2,3)]','FaceColor',clrs.b2,'EdgeColor','none')

x_b4 = 3 + 2*[-0.15:0.1:0.15];
bar(x_b4,[syn_d_in(inds_b4,1); syn_d_in(inds_b4,3)]','FaceColor',clrs.b4,'EdgeColor','none')

x_dnb = 4 + 2*[-0.15:0.1:0.15];
bar(x_dnb,[syn_d_in(inds_dnb,1); syn_d_in(inds_dnb,3)]','FaceColor',clrs.dnb,'EdgeColor','none')

x_chr = 5 + 2*[-0.15:0.1:0.15];
bar(x_chr,[syn_d_in(inds_chr,1); syn_d_in(inds_chr,3)]','FaceColor',clrs.chr,'EdgeColor','none')

set(gca,'YGrid','on','XLim',[-0.2 5.45],'YLim',[0 1600],'TickDir','out','XTick',[1:5],'XTickLabel',loc_names)
title('Dendritic inputs')
xlabel('Synapses')


%% 1c) Axonal Outputs
figure('Color','w','Position',[   440   626   317   172]); hold on;
x_pl = 1 + 2*[-0.35:0.1:0.35]-0.35;
bar(x_pl,[syn_a_out(inds_pl,1); syn_a_out(inds_pl,3)]','FaceColor',clrs.pl,'EdgeColor','none')

x_b2 = 2 + 2*[-0.15:0.1:0.15];
bar(x_b2,[syn_a_out(inds_b2,1); syn_a_out(inds_b2,3)]','FaceColor',clrs.b2,'EdgeColor','none')

x_b4 = 3 + 2*[-0.15:0.1:0.15];
bar(x_b4,[syn_a_out(inds_b4,1); syn_a_out(inds_b4,3)]','FaceColor',clrs.b4,'EdgeColor','none')

x_dnb = 4 + 2*[-0.15:0.1:0.15];
bar(x_dnb,[syn_a_out(inds_dnb,1); syn_a_out(inds_dnb,3)]','FaceColor',clrs.dnb,'EdgeColor','none')

x_chr = 5 + 2*[-0.15:0.1:0.15];
bar(x_chr,[syn_a_out(inds_chr,1); syn_a_out(inds_chr,3)]','FaceColor',clrs.chr,'EdgeColor','none')

set(gca,'YGrid','on','YLim',[0 1150],'XLim',[-0.15 5.5],'TickDir','out','XTick',[1:5],'XTickLabel',loc_names)
title('Axonal outputs')
xlabel('Synapses')


%% Figure 2 Supplementary figures
% Supplemental Figure 1 : All mdIV neurons from the 
% Figure 1E: Plot local neurons for Figure 1 E

for ind = 1:length(inds_loc)
    h = figure('Color','w','Position',[   440   400   206   398]); hold on;
    neuron_plot( neurons_noci( inds_ppk(1) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(2) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(3) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(4) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(5) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(6) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    
    neuron_plot( neurons_noci( inds_loc(ind) ), 'LineWidth', 3, 'Color', clrs.lcl);
    plotL1Outline(0,'LineWidth',1,'Color',[0.7 0.7 0.7])
    view([180 180]);
    set(gca,'Visible','off')
    export_fig(h,['dorsal_anatomy_loc_' num2str(ind) '.pdf'])
    close(h)
end

% Plot regional neurons

for ind = 1:length(inds_reg)
    h = figure('Color','w','Position',[   440   400   206   398]); hold on;
    neuron_plot( neurons_noci( inds_ppk(1) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(2) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(3) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(4) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(5) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(6) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    
    neuron_plot( neurons_noci( inds_reg(ind) ), 'LineWidth', 3, 'Color', clrs.reg);
    plotL1Outline(0,'LineWidth',1,'Color',[0.7 0.7 0.7])
    view([180 180]);
    set(gca,'Visible','off')
    export_fig(h,['dorsal_anatomy_reg_' num2str(ind) '.pdf'])
    close(h)
end

% Plot long-range neurons

for ind = 1:length(inds_ga)
    h = figure('Color','w','Position',[   440   400   206   398]); hold on;
    neuron_plot( neurons_noci( inds_ppk(1) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(2) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(3) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(4) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(5) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(6) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    
    neuron_plot( neurons_noci( inds_ga(ind) ), 'LineWidth', 3, 'Color', clrs.gbl_a);
    plotL1Outline(0,'LineWidth',1,'Color',[0.7 0.7 0.7])
    view([180 180]);
    set(gca,'Visible','off')
    export_fig(h,['dorsal_anatomy_ga_' num2str(ind) '.pdf'])
    close(h)
end

% Plot descending neurons

for ind = 1:length(inds_da)
    h = figure('Color','w','Position',[   440   400   206   398]); hold on;
    neuron_plot( neurons_noci( inds_ppk(1) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(2) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(3) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(4) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(5) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    neuron_plot( neurons_noci( inds_ppk(6) ), 'LineWidth', 2, 'Color', [ 0.7 0.7 0.7] );
    
    neuron_plot( neurons_noci( inds_da(ind) ), 'LineWidth', 3, 'Color', clrs.gbl_d);
    plotL1Outline(0,'LineWidth',1,'Color',[0.7 0.7 0.7])
    view([180 180]);
    set(gca,'Visible','off')
    export_fig(h,['dorsal_anatomy_da_' num2str(ind) '.pdf'])
    close(h)
end

%% Panels for SuppFig about neuron properties

% 1b) Dendritic Outputs
figure('Color','w','Position',[      440   626   317   172]); hold on;
x_pl = 1 + 2*[-0.35:0.1:0.35]-0.35;
bar(x_pl,[syn_d_out(inds_pl,1); syn_d_out(inds_pl,3)]','FaceColor',clrs.pl,'EdgeColor','none')

x_b2 = 2 + 2*[-0.15:0.1:0.15];
bar(x_b2,[syn_d_out(inds_b2,1); syn_d_out(inds_b2,3)]','FaceColor',clrs.b2,'EdgeColor','none')

x_b4 = 3 + 2*[-0.15:0.1:0.15];
bar(x_b4,[syn_d_out(inds_b4,1); syn_d_out(inds_b4,3)]','FaceColor',clrs.b4,'EdgeColor','none')

x_dnb = 4 + 2*[-0.15:0.1:0.15];
bar(x_dnb,[syn_d_out(inds_dnb,1); syn_d_out(inds_dnb,3)]','FaceColor',clrs.dnb,'EdgeColor','none')

x_chr = 5 + 2*[-0.15:0.1:0.15];
bar(x_chr,[syn_d_out(inds_chr,1); syn_d_out(inds_chr,3)]','FaceColor',clrs.chr,'EdgeColor','none')

set(gca,'YGrid','on','YLim',[0 250],'XLim',[-0.15 5.5],'TickDir','out','XTick',[1:5],'XTickLabel',loc_names)
title('Dendritic outputs')
xlabel('Synapses')

% 1d) Axonal Inputs
figure('Color','w','Position',[ 440   626   317   172]); hold on;
x_pl = 1 + 2*[-0.35:0.1:0.35]-0.35;
bar(x_pl,[syn_a_in(inds_pl,1); syn_a_in(inds_pl,3)]','FaceColor',clrs.pl,'EdgeColor','none')

x_b2 = 2 + 2*[-0.15:0.1:0.15];
bar(x_b2,[syn_a_in(inds_b2,1); syn_a_in(inds_b2,3)]','FaceColor',clrs.b2,'EdgeColor','none')

x_b4 = 3 + 2*[-0.15:0.1:0.15];
bar(x_b4,[syn_a_in(inds_b4,1); syn_a_in(inds_b4,3)]','FaceColor',clrs.b4,'EdgeColor','none')

x_dnb = 4 + 2*[-0.15:0.1:0.15];
bar(x_dnb,[syn_a_in(inds_dnb,1); syn_a_in(inds_dnb,3)]','FaceColor',clrs.dnb,'EdgeColor','none')

x_chr = 5 + 2*[-0.15:0.1:0.15];
bar(x_chr,[syn_a_in(inds_chr,1); syn_a_in(inds_chr,3)]','FaceColor',clrs.chr,'EdgeColor','none')

set(gca,'YGrid','on','YLim',[0 80],'XLim',[-0.15 5.5],'TickDir','out','XTick',[1:5],'XTickLabel',loc_names)
title('Axonal inputs')
xlabel('Synapses')
%%

lens_a_l1 = zeros(12,1); lens_d_l1 = zeros(12,1);
lens_a_l3 = zeros(12,1); lens_d_l3 = zeros(12,1);
lens_dbb_l1 = zeros(12,1); lens_dtw_l1 = zeros(12,1);
lens_dbb_l3 = zeros(12,1); lens_dtw_l3 = zeros(12,1);

for ii = 1:12
    nrn_l1 = neurons_l3_sp(ii);
    lens_a_l1(ii) = fullsum( nrn_l1.Aw( nrn_l1.is_axon==1, nrn_l1.is_axon==1) ) / 1000 / 2;
    lens_d_l1(ii) = fullsum( nrn_l1.Aw( nrn_l1.is_dendrite==1, nrn_l1.is_dendrite==1) ) / 1000 / 2;
    
    is_twig_l1 = zeros(1,size(nrn_l1.Aw,1));
    is_twig_l1( [twigs_l1{ii}{:}] ) = 1;
    lens_dtw_l1(ii) = fullsum( nrn_l1.Aw( and(nrn_l1.is_dendrite==1,is_twig_l1==1),  and(nrn_l1.is_dendrite==1,is_twig_l1==1) ) ) / 1000 / 2;
    lens_dbb_l1(ii) = fullsum( nrn_l1.Aw( and(nrn_l1.is_dendrite==1,is_twig_l1==0),  and(nrn_l1.is_dendrite==1,is_twig_l1==0) ) ) / 1000 / 2;

    nrn_l3 = neurons_l3_sp(ii);
    lens_a_l3(ii) = fullsum( nrn_l3.Aw( nrn_l3.is_axon==1, nrn_l3.is_axon==1) ) / 1000 / 2;
    lens_d_l3(ii) = fullsum( nrn_l3.Aw( nrn_l3.is_dendrite==1, nrn_l3.is_dendrite==1) ) / 1000 / 2;
    
    is_twig_l3 = zeros(1,size(nrn_l3.Aw,1));
    is_twig_l3( [twigs_l3{ii}{:}] ) = 1;
    lens_dtw_l3(ii) = fullsum( nrn_l3.Aw( and(nrn_l3.is_dendrite==1,is_twig_l3==1),  and(nrn_l3.is_dendrite==1,is_twig_l3==1) ) ) / 1000 / 2;
    lens_dbb_l3(ii) = fullsum( nrn_l3.Aw( and(nrn_l3.is_dendrite==1,is_twig_l3==0),  and(nrn_l3.is_dendrite==1,is_twig_l3==0) ) ) / 1000 / 2;

end

%%

syn_ai_ratio = zeros(length(loc_grps),1);
syn_do_ratio = zeros(length(loc_grps),1);
syn_ao_ratio = zeros(length(loc_grps),1);
syn_di_ratio = zeros(length(loc_grps),1);

len_a_ratio = zeros(length(loc_grps),1);
len_d_ratio = zeros(length(loc_grps),1);
len_dtw_ratio = zeros(length(loc_grps),1);
len_dbb_ratio = zeros(length(loc_grps),1);


for ii = 1:length(loc_grps)
    syn_ai_ratio(ii) = sum( syn_a_in(loc_grps{ii},3) ) / sum( syn_a_in(loc_grps{ii},1) );
    syn_ao_ratio(ii) = sum( syn_a_out(loc_grps{ii},3) ) / sum( syn_a_out(loc_grps{ii},1) );
    syn_do_ratio(ii) = sum( syn_d_out(loc_grps{ii},3) ) / sum( syn_d_out(loc_grps{ii},1) );
    syn_di_ratio(ii) = sum( syn_d_in(loc_grps{ii},3) ) / sum( syn_d_in(loc_grps{ii},1) );

    len_a_ratio(ii) = sum( lens_a_l3(loc_grps{ii}) ) / sum( lens_a_l1(loc_grps{ii}));
    len_d_ratio(ii) = sum( lens_d_l3(loc_grps{ii}) ) / sum( lens_d_l1(loc_grps{ii}));
    
    len_dtw_ratio(ii) = sum( lens_dtw_l3(loc_grps{ii})) / sum( lens_dtw_l1(loc_grps{ii}));
    len_dbb_ratio(ii) = sum( lens_dbb_l3(loc_grps{ii})) / sum( lens_dbb_l1(loc_grps{ii}));
     
end

fid = figure('Color','w','Position',[560   791   450   157]); hold on;
x_ac = 1 + [-0.2:0.1:0.2];
x_ao = 2 + [-0.2:0.1:0.2];
x_ai = 3 + [-0.2:0.1:0.2];
x_do = 4 + [-0.2:0.1:0.2];
plot(x_ac,len_a_ratio,'Marker','d','MarkerSize',10,'LineStyle','none','MarkerFaceColor','k')
plot(x_ai,syn_ai_ratio,'Marker','d','MarkerSize',10,'LineStyle','none','MarkerFaceColor','k')
plot(x_ao,syn_ao_ratio,'Marker','d','MarkerSize',10,'LineStyle','none','MarkerFaceColor','k')
plot(x_do,syn_do_ratio,'Marker','d','MarkerSize',10,'LineStyle','none','MarkerFaceColor','k')
set(gca,'YGrid','on','XLim',[0.5 4.5],'TickDir','out','XTick',[1 2 3 4],'XTickLabel',{'Axonal Cable','Axonal Output','Axonal Input','Dendritic Output'})

fid2 = figure('Color','w','Position',[560   791   225   157]); hold on;
plot(x_ac, len_d_ratio,'Marker','d','MarkerSize',10,'LineStyle','none','MarkerFaceColor','k')
plot(x_ao, syn_di_ratio,'Marker','d','MarkerSize',10,'LineStyle','none','MarkerFaceColor','k')
set(gca,'YGrid','on','YLim',[0.5 6.5],'XLim',[0.5 2.5],'TickDir','out','XTick',[1 2],'XTickLabel',{'Dendritic Cable','Dendritic Inputs'})

fid3 = figure('Color','w','Position',[560   791   225   157]); hold on;
plot(x_ac, len_dtw_ratio,'Marker','d','MarkerSize',10,'LineStyle','none','MarkerFaceColor','k')
plot(x_ao, len_dbb_ratio,'Marker','d','MarkerSize',10,'LineStyle','none','MarkerFaceColor','k')
set(gca,'YGrid','on','YLim',[0.5 7],'XLim',[0.5 2.5],'TickDir','out','XTick',[1 2],'XTickLabel',{'Dendritic Twig','Dendritic Backbone'})

%%
% Figure 3 panels
%%
%% Compute adjacency matrices
Add = cell(2,1); Add_n = cell(2,1);
Ada = cell(2,1); Ada_n = cell(2,1);
Aad = cell(2,1); Aad_n = cell(2,1);
Aaa = cell(2,1); Aaa_n = cell(2,1);
nrns{1} = neurons_l1a_sp; nrns{2} = neurons_l3_sp;
for ii = 1:2
    [Add{ii}, Ada{ii}, Aad{ii}, Aaa{ii}] = adjmat_by_type( nrns{ii} );
    [Add_n{ii}, Ada_n{ii}, Aad_n{ii}, Aaa_n{ii}] = adjmat_by_type_normalized( nrns{ii} );
end

%% Total synapse fraction
sens_in_l1 = sum(Aad{1}(1:12,13:18),2);
sens_in_l3 = sum(Aad{2}(1:12,13:18),2);

figure('Color','w','Position',[   440   587   403   211]); hold on;
for ii = 1:5
    if ii == 1
        bar(ii-[0.05:0.1:0.35],sens_in_l1(loc_grps{ii}),'FaceColor',clrs_ord{ii},'EdgeColor','none');
        bar(ii+[0.05:0.1:0.35],sens_in_l3(loc_grps{ii}),'FaceColor',clrs_ord{ii},'EdgeColor','none');
    else
        bar(0.75+ii/2-[0.05:0.1:0.2],sens_in_l1(loc_grps{ii}),'FaceColor',clrs_ord{ii},'EdgeColor','none');
        bar(0.75+ii/2+[0.05:0.1:0.2],sens_in_l3(loc_grps{ii}),'FaceColor',clrs_ord{ii},'EdgeColor','none');
    end
end
set(gca,'TickDir','out','XTick',[1 1.75:0.5:3.25],'XTickLabel',loc_names,'YGrid','on')


%% Normalized input
sens_in_l1_n = sum(Aad_n{1}(1:12,13:18),2);
sens_in_l3_n = sum(Aad_n{2}(1:12,13:18),2);

figure('Color','w','Position',[   440   587   403   211]); hold on;
for ii = 1:5
    if ii == 1
        ax = bar(ii-[0.05:0.1:0.35],[sens_in_l1_n(loc_grps{ii}) 1-sens_in_l1_n(loc_grps{ii})],'stacked','EdgeColor','none');
        ax2 = bar(ii+[0.05:0.1:0.35],[sens_in_l3_n(loc_grps{ii}) 1-sens_in_l3_n(loc_grps{ii})],'stacked','EdgeColor','none');
        ax(1).FaceColor = clrs_ord{ii};
        ax(2).FaceColor = [0.7 0.7 0.7];
        ax2(1).FaceColor = clrs_ord{ii};
        ax2(2).FaceColor = [0.7 0.7 0.7];

    else
        ax = bar(0.75+ii/2-[0.05:0.1:0.2],[sens_in_l1_n(loc_grps{ii}) 1-sens_in_l1_n(loc_grps{ii})],'stacked','EdgeColor','none');
        ax2 = bar(0.75+ii/2+[0.05:0.1:0.2],[sens_in_l3_n(loc_grps{ii}) 1-sens_in_l3_n(loc_grps{ii})],'stacked','EdgeColor','none');
           ax(1).FaceColor = clrs_ord{ii};
        ax(2).FaceColor = [0.7 0.7 0.7];
        ax2(1).FaceColor = clrs_ord{ii};
        ax2(2).FaceColor = [0.7 0.7 0.7];

    end
end
set(gca,'TickDir','out','XTick',[1 1.75:0.5:3.25],'XTickLabel',loc_names,'YGrid','on')

%% Ratios of input synapses and normalized input from mdIVs

l1vals = cell(5,1); l3vals = cell(5,1);
for ii = 1:5
l1vals{ii} = sum(Aad{1}(loc_grps{ii}, [inds_ddaC inds_vpr inds_vdaB]),2);
l3vals{ii} = sum(Aad{2}(loc_grps{ii}, [inds_ddaC inds_vpr inds_vdaB]),2);
end

l1vals_n = cell(5,1); l3vals_n = cell(5,1);
for ii = 1:5
l1vals_n{ii} = [sum(Aad_n{1}(loc_grps{ii}, [inds_ddaC inds_vpr inds_vdaB]),2)];
l3vals_n{ii} = sum(Aad_n{2}(loc_grps{ii}, [inds_ddaC inds_vpr inds_vdaB]),2);
end


figure('Color','w','Position',[440   616   224   182]); hold on;
for ii = 1:5
    plot(ii,mean(l3vals{ii})/mean(l1vals{ii}),'Marker','d','Color','k','MarkerSize',7)
end

for ii = 1:5
    plot(ii,mean(l3vals_n{ii})/mean(l1vals_n{ii}),'Marker','d','Color','k','MarkerSize',7,'MarkerFaceColor','k')
end
set(gca,'YGrid','on','XTick',1:5,'TickDir','out','YTick',1:10,'XLim',[0.5 5.5],'XTickLabel',loc_names,'XTickLabelRotation',45,'FontSize',12)


%% %% L/R asymmetry, measured as coefficient of variance

ppk_grps = {[13 14],[15 16],[17 18]};
A_type_l1_n = zeros(12,3);
A_type_l3_n = zeros(12,3);

for ii = 1:12
    for jj = 1:3
        A_type_l1_n(ii,jj) = fullsum(Aad{1}(ii,ppk_grps{jj})) / sum(neurons_l1a_sp(ii).synsin.is_dendritic);
        A_type_l3_n(ii,jj) = fullsum(Aad{2}(ii,ppk_grps{jj})) / sum(neurons_l3_sp(ii).synsin.is_dendritic);
    end
end

var_ppk_in_l1_n = zeros(5,3);
var_ppk_in_l3_n = zeros(5,3);
A_cell_l1_n = zeros(5,3);
A_cell_l3_n = zeros(5,3);
sA_cell_l1_n = zeros(5,3);
sA_cell_l3_n = zeros(5,3);

for ii = 1:5
    for jj = 1:3
        A_cell_l1_n(ii,jj) = mean(  A_type_l1_n( loc_grps{ii}, jj ) );
        A_cell_l3_n(ii,jj) = mean(  A_type_l3_n( loc_grps{ii}, jj ) );
        sA_cell_l1_n(ii,jj) = std(  A_type_l1_n( loc_grps{ii}, jj ) );
        sA_cell_l3_n(ii,jj) = std(  A_type_l3_n( loc_grps{ii}, jj ) );

        var_ppk_in_l1_n(ii,jj) = std( A_type_l1_n( loc_grps{ii}, jj )) / mean(  A_type_l1_n( loc_grps{ii}, jj ) );
        var_ppk_in_l3_n(ii,jj) = std(  A_type_l3_n( loc_grps{ii}, jj )) / mean(  A_type_l3_n( loc_grps{ii}, jj ) );
    end
end


figure('Color','w','Position',[   560   507   201   441])

paired_plot(var_ppk_in_l1_n(:),var_ppk_in_l3_n(:),'Color','k','Marker','o','MarkerSize',8,'MarkerFaceColor','w')
set(gca,'XLim',[0.8 2.2],'YLim', [-0.1 1.3],'XTick',[1 2],'XTickLabel',{'L1','L3'},'TickDir','out')
