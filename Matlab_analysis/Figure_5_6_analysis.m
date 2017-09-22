%% Figure 5 and 6 twig and twig connectivity properties
%
%% First strip off non-dendritic twigs.

twigs_l1_d = cell(12,1); twigs_l1_a = twigs_l1_d;
twigs_l3_d = cell(12,1); twigs_l3_a = twigs_l1_d;

for ii = 1:12
    [ twigs_l1_d{ii}, twigs_l1_a{ii} ] = filter_dendritic_twigs( neurons_l1a_sp(ii), twigs_l1{ii} );
    [ twigs_l3_d{ii}, twigs_l3_a{ii} ] = filter_dendritic_twigs( neurons_l3_sp(ii), twigs_l3{ii} );
end

%% Generate various properties

tw_syns = cell(12,2); tw_lens = cell(12,2); tw_dpts = cell(12,2); tw_bps = cell(12,2);
for ii = 1:12
    [tw_syns{ii,1}, tw_lens{ii,1}, tw_bps{ii,1}, tw_dpts{ii,1}] = twig_properties(neurons_l1a_sp(ii), twigs_l1_d{ii});
    [tw_syns{ii,2}, tw_lens{ii,2}, tw_bps{ii,2}, tw_dpts{ii,2}] = twig_properties(neurons_l3_sp(ii), twigs_l3_d{ii});
end

%%
% Figure 5

%% Dendritic backbone / cable scaleup plots

ld_tw = cellfun(@(x)sum(x)/1000,tw_lens);
ld = len_dend_all/1000;
ld_bb = ld-ld_tw;

ltw_ratio = zeros(5,1);
lbb_ratio = zeros(5,1);

for ii = 1:5
    ltw_ratio(ii) = sum( ld_tw(loc_grps{ii},2) ) / sum( ld_tw(loc_grps{ii},1) );
    lbb_ratio(ii) = sum( ld_bb(loc_grps{ii},2) ) / sum( ld_bb(loc_grps{ii},1) );
end

fid3 = figure('Color','w','Position',[560   791   225   157]); hold on;
plot(1 + [-0.2:0.1:0.2], ltw_ratio,'Marker','d','MarkerSize',10,'LineStyle','none','MarkerFaceColor','k')
plot(2 + [-0.2:0.1:0.2], lbb_ratio,'Marker','d','MarkerSize',10,'LineStyle','none','MarkerFaceColor','k')
set(gca,'YGrid','on','YLim',[0.5 7],'XLim',[0.5 2.5],'TickDir','out','XTick',[1 2],'XTickLabel',{'Dendritic Twig','Dendritic Backbone'})

ltw_frac = ld_tw ./ ld;

figure('Color','w','Position',[   440   472   274   326]); hold on;
x_pl = 1 + 2*[-0.35:0.1:0.35]-0.35;
hpl = barh(x_pl,[[ ltw_frac(inds_pl,1); ltw_frac(inds_pl,2)] 1-[ltw_frac(inds_pl,1); ltw_frac(inds_pl,2)]],'stacked');
hpl(1).FaceColor = clrs.pl; hpl(1).EdgeColor='none';
hpl(2).FaceColor = clrs.none; hpl(2).EdgeColor='none';

x_b2 = 2 + 2*[-0.15:0.1:0.15];
hb2 = barh(x_b2,[[ltw_frac(inds_b2,1); ltw_frac(inds_b2,2)] 1-[ltw_frac(inds_b2,1); ltw_frac(inds_b2,2)]],'stacked')
hb2(1).FaceColor = clrs.b2; hb2(1).EdgeColor='none';
hb2(2).FaceColor = clrs.none; hb2(2).EdgeColor='none';

x_b4 = 3 + 2*[-0.15:0.1:0.15];
hb4 = barh(x_b4,[[ltw_frac(inds_b4,1); ltw_frac(inds_b4,2)] 1-[ltw_frac(inds_b4,1); ltw_frac(inds_b4,2)]],'stacked')
hb4(1).FaceColor = clrs.b4; hb4(1).EdgeColor='none';
hb4(2).FaceColor = clrs.none; hb4(2).EdgeColor='none';

x_dnb = 4 + 2*[-0.15:0.1:0.15];
hdnb = barh(x_dnb,[[ltw_frac(inds_dnb,1); ltw_frac(inds_dnb,2)] 1-[ltw_frac(inds_dnb,1); ltw_frac(inds_dnb,2)]],'stacked')
hdnb(1).FaceColor = clrs.dnb; hdnb(1).EdgeColor='none';
hdnb(2).FaceColor = clrs.none; hdnb(2).EdgeColor='none';

x_chr = 5 + 2*[-0.15:0.1:0.15];
hchr = barh(x_chr,[[ltw_frac(inds_chr,1); ltw_frac(inds_chr,2)] 1-[ltw_frac(inds_chr,1); ltw_frac(inds_chr,2)]],'stacked')
hchr(1).FaceColor = clrs.chr; hchr(1).EdgeColor='none';
hchr(2).FaceColor = clrs.none; hchr(2).EdgeColor='none';

set(gca,'YDir','reverse','XGrid','on','XLim',[0 1],'YLim',[-0.2 5.5],'TickDir','out','YTick',[1:5],'YTickLabel',loc_names)
title('Dendritic cable')
xlabel('Fraction cable')


%%
twig_cable_mean = zeros(5,2);
for ii=1:5
   twig_cable_mean(ii,1) = mean(ltw_frac( loc_grps{ii},1 )); 
  twig_cable_mean(ii,2) = mean(ltw_frac( loc_grps{ii} ,2)); 
end

figure('Color','w','Position',[   440   471   140   327])
paired_plot(twig_cable_mean(:,1),twig_cable_mean(:,2),'Color','k','Marker','o','MarkerFaceColor','k','MarkerSize',10)
set(gca,'XLim',[0.8 2.2],'YLim',[0 1],'XTick',[1 2],'TickDir','out','XTickLabel',{'L1','L3'})
%%
sd_tw = cellfun(@(x)sum(x),tw_syns);
sd = zeros(size(sd_tw));
for ii = 1:12
    sd(ii,1) = sum(neurons_l1a_sp(ii).synsin.is_dendritic);
    sd(ii,2) = sum(neurons_l3_sp(ii).synsin.is_dendritic);
end

sd_bb = sd-sd_tw;
stw_frac = sd_tw ./ sd;

figure('Color','w','Position',[   440   472   274   326]); hold on;
x_pl = 1 + 2*[-0.35:0.1:0.35]-0.35;
hpl = barh(x_pl,[[ stw_frac(inds_pl,1); stw_frac(inds_pl,2)] 1-[stw_frac(inds_pl,1); stw_frac(inds_pl,2)]],'stacked');
hpl(1).FaceColor = clrs.pl; hpl(1).EdgeColor='none';
hpl(2).FaceColor = clrs.none; hpl(2).EdgeColor='none';

x_b2 = 2 + 2*[-0.15:0.1:0.15];
hb2 = barh(x_b2,[[stw_frac(inds_b2,1); stw_frac(inds_b2,2)] 1-[stw_frac(inds_b2,1); stw_frac(inds_b2,2)]],'stacked')
hb2(1).FaceColor = clrs.b2; hb2(1).EdgeColor='none';
hb2(2).FaceColor = clrs.none; hb2(2).EdgeColor='none';

x_b4 = 3 + 2*[-0.15:0.1:0.15];
hb4 = barh(x_b4,[[stw_frac(inds_b4,1); stw_frac(inds_b4,2)] 1-[stw_frac(inds_b4,1); stw_frac(inds_b4,2)]],'stacked')
hb4(1).FaceColor = clrs.b4; hb4(1).EdgeColor='none';
hb4(2).FaceColor = clrs.none; hb4(2).EdgeColor='none';

x_dnb = 4 + 2*[-0.15:0.1:0.15];
hdnb = barh(x_dnb,[[stw_frac(inds_dnb,1); stw_frac(inds_dnb,2)] 1-[stw_frac(inds_dnb,1); stw_frac(inds_dnb,2)]],'stacked')
hdnb(1).FaceColor = clrs.dnb; hdnb(1).EdgeColor='none';
hdnb(2).FaceColor = clrs.none; hdnb(2).EdgeColor='none';

x_chr = 5 + 2*[-0.15:0.1:0.15];
hchr = barh(x_chr,[[stw_frac(inds_chr,1); stw_frac(inds_chr,2)] 1-[stw_frac(inds_chr,1); stw_frac(inds_chr,2)]],'stacked')
hchr(1).FaceColor = clrs.chr; hchr(1).EdgeColor='none';
hchr(2).FaceColor = clrs.none; hchr(2).EdgeColor='none';

set(gca,'YDir','reverse','XGrid','on','XLim',[0 1],'YLim',[-0.2 5.5],'TickDir','out','YTick',[1:5],'YTickLabel',loc_names)
title('Dendritic cable')


twig_syn_mean = zeros(5,2);
for ii=1:5
   twig_syn_mean(ii,1) = mean(stw_frac( loc_grps{ii},1 )); 
  twig_syn_mean(ii,2) = mean(stw_frac( loc_grps{ii} ,2)); 
end

figure('Color','w','Position',[   440   471   140   327])
paired_plot(twig_syn_mean(:,1),twig_syn_mean(:,2),'Color','k','Marker','o','MarkerFaceColor','none','MarkerSize',10)
set(gca,'XLim',[0.8 2.2],'YLim',[0 1],'XTick',[1 2],'TickDir','out','XTickLabel',{'L1','L3'})

%%
% Figure 6
%
%% Twig property histograms

% Twig length

twig_len_l1 = cat( 1, tw_lens{1:12,1} )/1000;
twig_len_l3 = cat( 1, tw_lens{1:12,2} )/1000;

% Twig depth

twig_dpt_l1 = cat( 1, tw_dpts{1:12,1} )/1000;
twig_dpt_l3 = cat( 1, tw_dpts{1:12,2} )/1000;

% # Synapses / twig

twig_syns_l1 = cat( 1, tw_syns{1:12,1} );
twig_syns_l3 = cat( 1, tw_syns{1:12,2} );

%  Twig branch point histogram
twig_bp_l1 = cat(1,bps{1:12,1});
twig_bp_l3 = cat(1,bps{1:12,2});

figure('Color','w','Position',[   560   598   450   350]);
hold on;
bplot(twig_len_l1,0.78,'whisker',5,'width',0.4)
bplot(twig_len_l3,1.22,'whisker',5,'width',0.4)

bplot(twig_dpt_l1,1.78,'whisker',5,'width',0.4)
bplot(twig_dpt_l3,2.22,'whisker',5,'width',0.4)

bplot(twig_bp_l1,2.78,'whisker',5,'width',0.4)
bplot(twig_bp_l3,3.22,'whisker',5,'width',0.4)

bplot(twig_syns_l1,3.78,'whisker',5,'width',0.4)
bplot(twig_syns_l3,4.22,'whisker',5,'width',0.4)

set(gca,'YLim',[-0.1 17],'TickDir','out','YGrid','on','XTick',1:4,'XTickLabel',{'Len','Depth','BPs','Syns'})

%%  Twigs / connection

synapse_matrix_l1 = Aad{1}(1:12,13:18);
synapse_matrix_l3 = Aad{2}(1:12,13:18);

A_twig_l1 = twig_adjacency_matrix( neurons_l1a_sp, twigs_l1 );
A_twig_l3 = twig_adjacency_matrix( neurons_l3_sp, twigs_l3 );
twig_matrix_l1 = A_twig_l1(1:12,13:18);
twig_matrix_l3 = A_twig_l3(1:12,13:18);

% Plot synapses vs. twigs

figure('Color','w','Position',[440   503   473   295]); hold on;
area([0.01 90],[0.01 90],'EdgeColor','none','FaceColor',[0.9 0.9 0.9])
plot(synapse_matrix_l3(:)+0.2*rand(size(synapse_matrix_l3(:))),twig_matrix_l3(:),'rd')
hold on;
plot(synapse_matrix_l1(:)+0.2*rand(size(synapse_matrix_l1(:))),twig_matrix_l1(:),'ko')
set(gca,'XScale','lin','YScale','lin','TickDir','out','XLim',[1 90],'YLim',[1 40] )
axis('square')
xlabel('Synapses'); ylabel('Twigs')

a = polyfit( synapse_matrix_l3(synapse_matrix_l3>3), twig_matrix_l3( synapse_matrix_l3>3), 1);

%% Plot histogram synapses per partner per twig

twig_conns_l3 = cell(12,6);
twig_conns_l1 = cell(12,6);

for ii = 1:12
    for jj = 1:6
        
        twig_conns_l3{ii,jj} = synapses_in_connection_per_twig( neurons_l3_sp(ii), twigs_l3_d{ii}, 12+jj );
        twig_conns_l1{ii,jj} = synapses_in_connection_per_twig( neurons_l1a_sp(ii), twigs_l1_d{ii}, 12+jj );
        
    end
end

tw1 = cat(1,twig_conns_l1{:,:});
tw3 = cat(1,twig_conns_l3{:,:});
figure('Color','w','Position',[560   664   344   284])
hold on;
histogram(tw1(tw1>0),'Normalization','pdf','BinMethod','integers','DisplayStyle','stairs')
histogram(tw3(tw3>0),'Normalization','pdf','BinMethod','integers','DisplayStyle','stairs')
set(gca,'YScale','log')
xlabel('Synapses from specific presynaptic partner per twig')
ylabel('Fraction')
