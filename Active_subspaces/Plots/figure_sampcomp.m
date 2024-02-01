% ------------------------------------------------------------------------- %
% function figure_sampcomp(D, Ms, seeds, problems, varargin)
%
% input:  Ds       = a vector of dimension of the domain of the function
%         Ms       = a vector of different number of samples M
%         seeds    = a vector of options of seed
%         problems = a set of test problems selected from the test set with
%                    default effective dimension
%         varargin  = a vector of different value of alpha
% output: .fig and .png plots
% ------------------------------------------------------------------------- %
function figure_sampcomp(Ds, Ms, seeds, problems, varargin)

[filepart,~,~] = fileparts(pwd);
loadpath = fullfile(filepart,'Results');
addpath(genpath(loadpath));

if any(strcmp(problems, 'aEasom'))
    alphas = varargin{1};
    filename = strcat('sampcomp_', num2str(length(problems)),'problems_',...
        num2str(length(seeds)),'seeds_',num2str(length(Ms)),'Ms_',num2str(length(alphas)),...
        'alphas.mat');
    data = load(filename);
    succ_pp = data.(strcat('succ_pp'));
    d_e = data.(strcat('d_e'));
    succ_pp_aEasom = data.(strcat('succ_pp_aEasom'));
else
    filename = strcat('Results/sampcomp_', num2str(length(problems)),'problems_',...
        num2str(length(seeds)),'seeds_',num2str(length(Ms)),'Ms.mat');
    data = load(filename);
    succ_pp = data.(strcat('succ_pp'));
    d_e = data.(strcat('d_e'));
end

i_np = 1;
for i_p = 1:length(problems)
    index = find(Ms == d_e(i_p));
    M_est = Ms(index(1));
    if strcmp(problems{i_p}, 'aEasom')
        for i_a = 1:length(alphas)
            figure
            set(gcf,'position',[10,10,1600,400])
            for i_d = 1:length(Ds)
                subplot(1,length(Ds),i_d)
                plot(Ms,squeeze(succ_pp_aEasom(i_a,:,i_d)),'-o','MarkerSize',8,'Linewidth',2)
                hold on
                xline(M_est,':',{'$d_e$'}, 'Linewidth', 2,'LabelOrientation','horizontal','LabelVerticalAlignment','top','LabelHorizontalAlignment','right', 'Interpreter','latex','Fontsize',18)
                hold off
                ylim([0 1])
                grid on
                title(strcat('$\alpha$','Easom ($\alpha$=',num2str(alphas(i_a)),') D=',num2str(Ds(i_d))), 'Fontsize',18,'Interpreter','latex')
                xlabel('$M$', 'Fontsize',18,'Interpreter','latex')
                ylabel('Probablity of success for $d=d_{e}$', 'Fontsize',18,'Interpreter','latex')
                ax = gca;
                ax.XAxis.FontSize = 18;
                ax.YAxis.FontSize = 18;
            end
            saveas(gcf,fullfile(filepart,'Plots', ['pos_M_test' problems{i_p} num2str(i_a) '_' num2str(length(seeds)) 'seeds' num2str(length(problems)) 'problems.fig']))
            saveas(gcf,fullfile(filepart,'Plots', ['pos_M_test' problems{i_p} num2str(i_a) '_' num2str(length(seeds)) 'seeds' num2str(length(problems)) 'problems.png']))
            saveas(gcf,fullfile(filepart,'Plots', ['pos_M_test' problems{i_p} num2str(i_a) '_' num2str(length(seeds)) 'seeds' num2str(length(problems)) 'problems.eps']),'epsc')
        end
    else
        figure
        set(gcf,'position',[10,10,1600,400])
        for i_d = 1:length(Ds)
            subplot(1,length(Ds),i_d)
            plot(Ms,squeeze(succ_pp(i_np,:,i_d)),'-o','MarkerSize',8,'Linewidth',2)
            hold on
            xline(M_est,':',{'$d_e$'}, 'Linewidth', 2,'LabelOrientation','horizontal','LabelVerticalAlignment','top','LabelHorizontalAlignment','right', 'Interpreter','latex','Fontsize',18)
            hold off
            ylim([0 1])
            grid on
            title(strcat(problems(i_p),' D=',num2str(Ds(i_d))), 'Fontsize',18,'Interpreter','latex')
            xlabel('$M$', 'Fontsize',18,'Interpreter','latex')
            ylabel('Probablity of success for $d=d_{e}$', 'Fontsize',18,'Interpreter','latex')
            ax = gca;
            ax.XAxis.FontSize = 18;
            ax.YAxis.FontSize = 18;
        end
        saveas(gcf,fullfile(filepart,'Plots', ['pos_M_test' problems{i_p} '_' num2str(length(seeds)) 'seeds' num2str(length(problems)) 'problems.fig']))
        saveas(gcf,fullfile(filepart,'Plots', ['pos_M_test',problems{i_p} '_' num2str(length(seeds)) 'seeds' num2str(length(problems)) 'problems.png']))
        saveas(gcf,fullfile(filepart,'Plots', ['pos_M_test',problems{i_p} '_' num2str(length(seeds)) 'seeds' num2str(length(problems)) 'problems.eps']),'epsc')
        i_np = i_np+1;
    end
end
end

