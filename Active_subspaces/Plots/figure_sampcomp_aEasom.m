% -------------------------------------------------------------------- %
% function figure_sampcomp_aEasom(Ds, Ms, seeds, alphas)
%
% input:  Ds     = a vector of dimension of the domain of the function
%         Ms     = a vector of different number of samples M
%         seeds  = a vector of different options of seed
%         alphas = a vector of different value of alpha
% output: .fig and .png plots
% --------------------------------------------------------------------- %
function figure_sampcomp_aEasom(Ds, Ms, seeds, alphas)

[filepart,~,~] = fileparts(pwd);
loadpath = fullfile(filepart,'Results');
addpath(genpath(loadpath));

filename = strcat('sampcomp_aEasom_',num2str(length(seeds)),'seeds_',...
    num2str(length(Ms)),'Ms_',num2str(length(alphas)),'alphas.mat');
data = load(filename);
M_rec = data.(strcat('M_rec'));
d_e = 2;

%% Success for problems vs. constant in M

figure
set(gcf,'position',[10,10,1600,400])
for i_d = 1:length(Ds)
    subplot(1,length(Ds),i_d)
    legendInfo = {};
    Markers = {'o','*','.','+','x','v','d','^','s','>','<'};
    for i_s = 1:length(seeds)
        plot(alphas,M_rec(:,i_s,i_d),strcat('-',Markers{i_s}),'MarkerSize',8,'Linewidth',2)
        hold on
        legendInfo{i_s}=['seed = ' num2str(seeds(i_s))];
    end
    yline(d_e,':',{'\fontsize{16} d_e'}, 'Linewidth', 2,'LabelOrientation','horizontal','LabelVerticalAlignment','top','LabelHorizontalAlignment','left')
    hold off
    ylim([0 Ms(end)])
    xlim([0 1])
    grid on
    title(['D=' num2str(Ds(i_d))], 'Fontsize',18,'Interpreter','latex')
    xlabel('$\alpha$', 'Fontsize',18,'Interpreter','latex')
    ylabel('$M$ samples to guarantee the success', 'Fontsize',18,'Interpreter','latex')
    ax = gca;
    ax.XAxis.FontSize = 18;
    ax.YAxis.FontSize = 18;
    legend(legendInfo, 'Fontsize', 16,'Interpreter','latex')
    saveas(gcf,fullfile(filepart,'Plots',['alpha_M_test', num2str(length(seeds)) 'seeds.png']))
    saveas(gcf,fullfile(filepart,'Plots',['alpha_M_test', num2str(length(seeds)) 'seeds.fig']))
    saveas(gcf,fullfile(filepart,'Plots',['alpha_M_test', num2str(length(seeds)) 'seeds.eps']),'epsc')
end
end

