function neuron_plot( neuron, varargin)
% Makes a 3d plot of the input neuron, with several options.
%     neuron_plot( neuron, 'withsyn' ) plots synapses with inputs as blue and outputs as red.
%     neuron_plot( neuron, '

% Sets the size of a synapse marker
d_syn = 1*10^3;

set(gcf,'Renderer','OpenGL'); hold on;
if any(strcmp(varargin,'withsyn'))
    varargin(strcmp(varargin,'withsyn')) = [];
    x0 = neuron.xyz(neuron.synsin.treeinds,:);
    x1 = neuron.synsin.xyz;
    syn_len = sqrt(sum((x1-x0).^2,2));
    x1_scaled = x0 + d_syn * (x1-x0+0.0) ./ repmat(syn_len,1,3);
    for ii = 1:size(x0,1);
        plot3([x0(ii,1), x1_scaled(ii,1)],...
            [x0(ii,2), x1_scaled(ii,2)],...
            [x0(ii,3), x1_scaled(ii,3)],...
            'LineWidth',3,'Color',[39 170 225]/255);
    end
    
    x0 = neuron.xyz(neuron.synsout.treeinds,:);
    x1 = neuron.synsout.xyz;
    syn_len = sqrt(sum((x1-x0).^2,2));
    x1_scaled = x0 + d_syn * (x1-x0) ./ repmat(syn_len,1,3);
    for ii = 1:size(x0,1)
        plot3([x0(ii,1), x1_scaled(ii,1)],...
            [x0(ii,2), x1_scaled(ii,2)],...
            [x0(ii,3), x1_scaled(ii,3)],...
            'LineWidth',3,'Color','r');
    end
elseif any(strcmp(varargin,'compartments'))
    varargin(strcmp(varargin,'compartments')) = [];
    x0 = neuron.xyz(neuron.synsin.treeinds,:);
    x1 = neuron.synsin.xyz;
    syn_len = sqrt(sum((x1-x0).^2,2));
    x1_scaled = x0 + d_syn * (x1-x0) ./ repmat(syn_len,1,3);
    for ii = 1:size(x0,1);
        if neuron.synsin.is_dendritic(ii)
            syncolor = 'g';
        else
            syncolor = 'm';
        end
        plot3([x0(ii,1), x1_scaled(ii,1)],...
            [x0(ii,2), x1_scaled(ii,2)],...
            [x0(ii,3), x1_scaled(ii,3)],...
            'LineWidth',3,'Color',syncolor);
    end
    
    x0 = neuron.xyz(neuron.synsout.treeinds,:);
    x1 = neuron.synsout.xyz;
    syn_len = sqrt(sum((x1-x0).^2,2));
    x1_scaled = x0 + d_syn * (x1-x0) ./ repmat(syn_len,1,3);
    for ii = 1:size(x0,1)
        if neuron.synsout.is_dendritic(ii)
            syncolor = 'g';
        else
            syncolor = 'm';
        end
        
        plot3([x0(ii,1), x1_scaled(ii,1)],...
            [x0(ii,2), x1_scaled(ii,2)],...
            [x0(ii,3), x1_scaled(ii,3)],...
            'LineWidth',6,'Color',syncolor);
    end
            

end

partition_limit = Inf;
if any(strcmp(varargin,'PartitionLimit'))
    part_limit_ind = find(strcmp(varargin,'PartitionLimit'));
    partition_limit = varargin{part_limit_ind+1};
    varargin(part_limit_ind:part_limit_ind+1) = [];
end


P = partition_skeleton( neuron.Adir );
if any(strcmp(varargin,'CData'))
    cdat = varargin{1+find(strcmp(varargin,'CData'))};
    varargin{1+find(strcmp(varargin,'CData'))} = [];
    varargin{find(strcmp(varargin,'CData'))} = [];
    
    for ii = 1:min(length(P),partition_limit)
        color_line3(neuron.xyz(P{ii},1), neuron.xyz(P{ii},2), neuron.xyz(P{ii},3), cdat(P{ii},:), 2 );
    end
else
    for ii = 1:min(length(P),partition_limit)
        plot3(neuron.xyz(P{ii},1), neuron.xyz(P{ii},2), neuron.xyz(P{ii},3), varargin{:});
    end
end

if any(strcmp(varargin,'Color'))
    clr = varargin{1+find(strcmp(varargin,'Color'))};
else
    clr = 'b';
end

axis image;

if neuron.soma ~= -1
    [X, Y, Z] = sphere(8);
    X = 2500*X + neuron.xyz(neuron.soma(1),1);
    Y= 2500*Y + neuron.xyz(neuron.soma(1),2);
    Z = 2500*Z + neuron.xyz(neuron.soma(1),3);
    surf(X,Y,Z,'FaceColor',clr,'LineStyle','none')
end
