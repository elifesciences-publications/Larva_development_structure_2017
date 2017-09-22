twig_conns_l3 = cell(12,6);
twig_conns_l1 = cell(12,6);

for ii = 1:12
    for jj = 1:6
        
        twig_conns_l3{ii,jj} = synapses_in_connection_per_twig( neurons_l3_sp(ii), twigs_l3_d{ii}, 12+jj );
        twig_conns_l1{ii,jj} = synapses_in_connection_per_twig( neurons_l1a_sp(ii), twigs_l1_d{ii}, 12+jj );
        
    end
end

%% plot effect of different error rates on observed connectivity

p_es = [0:0.005:1];
ntimes = 5000;
conn_effect_l3 = cell(12,6); conn_effect_norm_l3 = cell(12,6);
conn_effect_l1 = cell(12,6); conn_effect_norm_l1 = cell(12,6);

for mm = 1:12
    for nn = 1:6
        conn_effect_l3{mm,nn} = cell(1,length(p_es));
        conn_effect_norm_l3{mm,nn} = conn_effect_l3{mm,nn};
        
        for ii = 1:length(p_es)
            conn_effect_l3{mm,nn}{ii} = remove_twigs_at_random( twig_conns_l3{mm,nn}, p_es(ii), ntimes);
            conn_effect_norm_l3{mm,nn}{ii} = (conn_effect_l3{mm,nn}{ii} + (synapse_matrix_l3(mm,nn)-sum(twig_conns_l3{mm,nn}))) / synapse_matrix_l3(mm,nn);
            
            conn_effect_l1{mm,nn}{ii} = remove_twigs_at_random( twig_conns_l1{mm,nn}, p_es(ii), ntimes);
            conn_effect_norm_l1{mm,nn}{ii} = (conn_effect_l1{mm,nn}{ii} + (synapse_matrix_l1a(mm,nn)-sum(twig_conns_l1{mm,nn}))) / synapse_matrix_l1a(mm,nn);
            
        end
    end
end

%% Plot the 5-95 interval for a specific connection

ii = 5;
jj = 3;

figure('Color','w'); hold on;

shadedErrorBar( p_es, cellfun(@(x)median(x),conn_effect_norm_l1{ii,jj}),...
    [cellfun(@(x)prctile(x,95),conn_effect_norm_l1{ii,jj})-cellfun(@(x)median(x),conn_effect_norm_l1{ii,jj});...
    cellfun(@(x)median(x),conn_effect_norm_l1{ii,jj})-cellfun(@(x)prctile(x,5),conn_effect_norm_l1{ii,jj})],'k')

shadedErrorBar( p_es, cellfun(@(x)median(x),conn_effect_norm_l3{ii,jj}),...
    [cellfun(@(x)prctile(x,95),conn_effect_norm_l3{ii,jj})-cellfun(@(x)median(x),conn_effect_norm_l3{ii,jj});...
    cellfun(@(x)median(x),conn_effect_norm_l3{ii,jj})-cellfun(@(x)prctile(x,5),conn_effect_norm_l3{ii,jj})],'r')

axis square

%% Necessary error rate for a 5% chance of missing 3/4 of all synapses.
n_orig = synapse_matrix_l3;
p_50 = zeros(12,6);

for ii = 1:12
    for jj = 1:6
        prc5 = cellfun(@(x)prctile(x,5),conn_effect_norm_l3{ii,jj});
        ind = find( and(prc5(1:end-1)>=0.25, prc5(2:end)<0.25));
        if ~isempty( ind)
            p_50(ii,jj) = mean(p_es(ind));
        else
            p_50(ii,jj) = 1;
        end
    end
end

n_orig_l1 = synapse_matrix_l1;
p_50_l1 = zeros(12,6);

for ii = 1:12
    for jj = 1:6
        prc5 = cellfun(@(x)prctile(x,5),conn_effect_norm_l1{ii,jj});
        ind = find( and(prc5(1:end-1)>=0.25, prc5(2:end)<0.25));
        if ~isempty( ind)
            p_50_l1(ii,jj) = mean(p_es(ind));
        else
            p_50_l1(ii,jj) = 1;
        end
    end
end

figure('Color','w');
hold on;
jitterplot(p_50_l1(:),n_orig_l1(:),0.0025,'or','MarkerSize',10)
jitterplot(p_50(:),n_orig(:),0.0025,'dk','MarkerSize',10)
plot([0.12 0.12],[1 100],'LineStyle','--','Color',[0.5 0.5 0.5])
set(gca,'YScale','log','TickDir','out','FontSize',14,'XLim',[0 0.65],'YLim',[1 100])
axis square
