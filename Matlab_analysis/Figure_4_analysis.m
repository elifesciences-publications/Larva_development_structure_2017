%% Figure 4
% Compute filling fraction for each connection

fill_frac_l1 = zeros(12,6);
fill_frac_l3 = zeros(12,6);

nfill_l1 = zeros(12,6);
nfill_l3 = zeros(12,6);

nprox_l1 = zeros(12,6);
nprox_l3 = zeros(12,6);

min_strahler = 2; % Strip neurons down to this strahler value when deciding proximity
d = 2; % In microns, distance for which to consider a synapse 'proximate'

for ii = 1:12
    for jj = 1:6
        disp(['ii = ' num2str(ii) '; jj = ' num2str(jj) ])
        [fill_frac_l1(ii,jj), nfill_l1(ii,jj), nprox_l1(ii,jj)] = filling_fraction( neurons_l1a_sp(12+jj), neurons_l1a_sp(ii), d, min_strahler );
        [fill_frac_l3(ii,jj), nfill_l3(ii,jj), nprox_l3(ii,jj)] = filling_fraction( neurons_l3_sp(12+jj), neurons_l3_sp(ii), d, min_strahler );
    end
end

ppk_grps = {[13 14],[15 16],[17 18]};
ff_ppk_in_l1 = zeros(5,3); ff_ppk_in_l3 = zeros( 5, 3);
var_ff_l1 = zeros(5,3); var_ff_l3 = zeros(5,3);

for ii = 1:5
    for jj = 1:3
        ff_ppk_in_l1(ii,jj) = fullsum( nfill_l1( loc_grps{ii}, ppk_grps{jj}-12 ) ) / fullsum( nprox_l1( loc_grps{ii}, ppk_grps{jj}-12 ) );
        ff_ppk_in_l3(ii,jj) = fullsum( nfill_l3( loc_grps{ii}, ppk_grps{jj}-12 ) ) / fullsum( nprox_l3( loc_grps{ii}, ppk_grps{jj}-12 ) );
    end
end

ppk_grps = {[13 14],[15 16],[17 18]};
ff_ppk_in_l1 = zeros(5,3); ff_ppk_in_l3 = zeros( 5, 3);

ff_prox_l1 = zeros(5,3);
ff_prox_l3 = zeros(5,3);

ff_act_l1 = zeros(5,3);
ff_act_l3 = zeros(5,3);


for ii = 1:5
    for jj = 1:3

        ff_ppk_in_l1(ii,jj) = fullsum( nfill_l1( loc_grps{ii}, ppk_grps{jj}-12 ) ) / fullsum( nprox_l1( loc_grps{ii}, ppk_grps{jj}-12 ) );
        ff_ppk_in_l3(ii,jj) = fullsum( nfill_l3( loc_grps{ii}, ppk_grps{jj}-12 ) ) / fullsum( nprox_l3( loc_grps{ii}, ppk_grps{jj}-12 ) );
    
        var_ff_l1(ii,jj) = coefficient_of_variation( sum(  nfill_l1( loc_grps{ii}, ppk_grps{jj}-12 ), 2) ./ sum( nprox_l1( loc_grps{ii}, ppk_grps{jj}-12 ), 2) );
        var_ff_l3(ii,jj) = coefficient_of_variation( sum(  nfill_l3( loc_grps{ii}, ppk_grps{jj}-12 ), 2) ./ sum( nprox_l3( loc_grps{ii}, ppk_grps{jj}-12 ), 2) );

        ff_prox_l1(ii,jj) = fullsum( nprox_l1( loc_grps{ii}, ppk_grps{jj}-12 ) );
        ff_prox_l3(ii,jj) = fullsum( nprox_l3( loc_grps{ii}, ppk_grps{jj}-12 ) );

        ff_act_l1(ii,jj) = fullsum( nfill_l1( loc_grps{ii}, ppk_grps{jj}-12 ) );
        ff_act_l3(ii,jj) = fullsum( nfill_l3( loc_grps{ii}, ppk_grps{jj}-12 ) );

    end
end


%% Filling fraction plots

figure('Color','w','Position',[         560         1200        1022         353]);
subplot(1,3,1)
hold on;
plot(A_cell_l1(:), ff_ppk_in_l1(:),'ko')
set(gca,'XLim',[0 25],'YTick',0:0.1:0.5)
axis square
title('L1')

subplot(1,3,2)
hold on;
plot(A_cell_l3(:), ff_ppk_in_l3(:),'ko')
set(gca,'XLim',[0 105],'YTick',0:0.1:0.5)
axis square
title('L3')

subplot(1,3,3)
hold on;
plot([0 0.5],[0 0.5],'k--')
plot(ff_ppk_in_l1(:), ff_ppk_in_l3(:),'ko')
set(gca,'XTick',0:0.1:0.5,'YTick',0:0.1:0.5)
axis square
title('L1 v L3 ff')


%% Test different distances for filling fraction

ds = 0.5:0.5:4;
fill_frac_dtest_l1_a = zeros(1,length(ds) );
fill_frac_dtest_l3_a = zeros(1,length(ds) );

nfill_dtest_l1 = zeros(1,length(ds) );
nfill_dtest_l3 = zeros(1,length(ds) );
nprox_dtest_l1 = zeros(1,length(ds) );
nprox_dtest_l3 = zeros(1,length(ds) );

min_strahler = 2; % Strip neurons down to this strahler value when deciding proximity

ii = 7;
jj = 5;

for dind = 1:length(ds)
    disp(num2str(ds(dind)))
[fill_frac_dtest_l1_a(dind), nfill_dtest_l1(dind), nprox_dtest_l1(dind)] = filling_fraction(  neurons_l1a_sp(12+jj), neurons_l1a_sp(ii), ds(dind), min_strahler );
[fill_frac_dtest_l3_a(dind), nfill_dtest_l3(dind), nprox_dtest_l3(dind)] = filling_fraction( neurons_l3_sp(12+jj), neurons_l3_sp(ii), ds(dind), min_strahler );

end

figure('Color','w')
hold on;
plot(ds,fill_frac_dtest_l1,'k-o')
plot(ds,fill_frac_dtest_l3,'r-o')
plot(ds,fill_frac_dtest_l1_a,'k--o')
plot(ds,fill_frac_dtest_l3_a,'r--o')
set(gca,'TickDir','out','FontSize',14)
axis square