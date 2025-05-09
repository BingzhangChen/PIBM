close all
clear all
warning off
%==========================================================================

%==========================================================================
%% Script to plot the model comparison, the 1D hybrid lagrangian-Eulerian
% model vs a simple 1D IBM NPZD model and al simple 1D Eulerian NPZD model 
%--------------------------------------------------------------------------
% Writen by Iria Sala
% Created on 14.12.2024
% Edited by Bingzhang Chen on 26/04/2025
%==========================================================================

%==========================================================================
%% ----------------------- Load modelled data -------------------------- %%
%==========================================================================

%==========================================================================
%% Load PIBM data:
%==========================================================================
EUL = 'Euler.nc';
%==========================================================================
Z_r  = double(ncread(EUL,'Z_r'));    % Depth (m), intermediate point
Z_w  = double(ncread(EUL,'Z_w'));    % Depth (m), limit point
ZDEP = repmat(Z_r,1,365);
%--------------------------------------------------------------------------
DAYS = double(ncread(EUL,'Day'));
tfin = length(DAYS) - 1;
tini = tfin - 364;
%--------------------------------------------------------------------------
NO3_PIBM = double(ncread(EUL,'NO3')); % NO3 (mmol N m-3)
NO3_PIBM = NO3_PIBM(:,tini:tfin);           % Last year
%--------------------------------------------------------------------------
CHL_PIBM = double(ncread(EUL,'CHL')); % Chl (mg Chl m-3)
CHL_PIBM = CHL_PIBM(:,tini:tfin);           % Last year
%--------------------------------------------------------------------------
NPP_PIBM = double(ncread(EUL,'NPP')); % NPP (mg C m-3 d-1)
NPP_PIBM = NPP_PIBM(:,tini:tfin);           % Last year
%==========================================================================

%==========================================================================
%% Load Eulerian NPZD model data:
%==========================================================================
EUL = 'EulerNPZD_EUL.nc';
%==========================================================================
Z_r  = double(ncread(EUL,'Z_r'));    % Depth (m), intermediate point
Z_w  = double(ncread(EUL,'Z_w'));    % Depth (m), limit point
%--------------------------------------------------------------------------
NO3_ENPZD = double(ncread(EUL,'NO3')); % NO3 (mmol N m-3)
NO3_ENPZD = NO3_ENPZD(:,tini:tfin);           % Last year
%--------------------------------------------------------------------------
CHL_ENPZD = squeeze(ncread(EUL,'CHL')); % Chl (mg Chl m-3)
CHL_ENPZD = CHL_ENPZD(:,tini:tfin);           % Last year
%--------------------------------------------------------------------------
NPP_ENPZD = double(ncread(EUL,'NPP')); % NPP (mg C m-3 d-1)
NPP_ENPZD = NPP_ENPZD(:,tini:tfin);           % Last year
%==========================================================================

%==========================================================================
%% Load Lagrangian NPZD model data:
%==========================================================================
EUL = 'EulerNPZD_IBM.nc';
%==========================================================================
Z_r  = double(ncread(EUL,'Z_r'));    % Depth (m), intermediate point
Z_w  = double(ncread(EUL,'Z_w'));    % Depth (m), limit point
%--------------------------------------------------------------------------
NO3_LNPZD = double(ncread(EUL,'NO3')); % NO3 (mmol N m-3)
NO3_LNPZD = NO3_LNPZD(:,tini:tfin);           % Last year
%--------------------------------------------------------------------------
CHL_LNPZD = double(ncread(EUL,'CHL')); % Chl (mg Chl m-3)
CHL_LNPZD = CHL_LNPZD(:,tini:tfin);           % Last year
%--------------------------------------------------------------------------
NPP_LNPZD = double(ncread(EUL,'NPP')); % NPP (mg C m-3 d-1)
NPP_LNPZD = NPP_LNPZD(:,tini:tfin);           % Last year
%==========================================================================

%==========================================================================
%% Plot time vectors:
%==========================================================================
TIME = 1:365;
TIME = repmat(TIME,100,1);
Tvec = [1 32 60 91 121 152 182 213 244 274 305 335];       % Time ticks
Tout = {'J' 'F' 'M' 'A' 'M' 'J' 'J' 'A' 'S' 'O' 'N' 'D'};  % Time labels
%==========================================================================

%==========================================================================
%% FIGURE
%==========================================================================
make_it_tight = true;
% m = distance between subplots
% n = distance to bottom and upper edges
% p = distance to right and left edges
subplot = @(m,n,p) subtightplot (m, n, p, [0.05 0.04], [0.07 0.05], [0.08 0.08]);
if ~make_it_tight,  clear subplot;  end
%..........................................................................
Fig = figure;
set(gcf, 'Color','white');
set(Fig, 'Position',[900,150,900,800]);
%==========================================================================
subplot(3,3,1);
%..........................................................................
hold on
box on
%..........................................................................
pcolor(TIME,ZDEP,NO3_ENPZD);
shading flat
%..........................................................................
title('(a) Euler-NPZD DIN (mmol N m^{-3})')
%..........................................................................
xlim([1 365]);
% xlabel('Time (months)')
set(gca,'XTick',Tvec,'XTickLabel',[],'FontSize',11)
%..........................................................................
ylim([-250 0]); 
ylabel('Depth (m)');
set(gca,'YTick',[-250:50:0],'YTickLabel',[-250:50:0],'FontSize',11)
%..........................................................................
colormap(jet);
caxis([0 3.0]);
%..........................................................................
set(gca,'FontSize',10,'FontName','Arial'); 
%==========================================================================
subplot(3,3,2);
%..........................................................................
hold on
box on
%..........................................................................
pcolor(TIME,ZDEP,NO3_LNPZD);
shading flat
%..........................................................................
title('(b) IBM-NPZD DIN (mmol N m^{-3})')
%..........................................................................
xlim([1 365]);
% xlabel('Time (months)')
set(gca,'XTick',Tvec,'XTickLabel',[],'FontSize',11)
%..........................................................................
ylim([-250 0]); 
% ylabel('Depth (m)');
set(gca,'YTick',[-250:50:0],'YTickLabel',[],'FontSize',11)
%..........................................................................
colormap(jet);
caxis([0 3.0]);
%..........................................................................
set(gca,'FontSize',10,'FontName','Arial'); 
%==========================================================================
subplot(3,3,3);
%..........................................................................
hold on
box on
%..........................................................................
pcolor(TIME,ZDEP,NO3_PIBM);
shading flat
%..........................................................................
title('(c) PIBM DIN (mmol N m^{-3})')
%..........................................................................
xlim([1 365]);
% xlabel('Time (months)')
set(gca,'XTick',Tvec,'XTickLabel',[],'FontSize',11)
%..........................................................................
ylim([-250 0]); 
% ylabel('Depth (m)');
set(gca,'YTick',[-250:50:0],'YTickLabel',[],'FontSize',11)
%..........................................................................
colormap(jet);
caxis([0 3.0]);
h3 = colorbar('EastOutside');
set(h3, 'Position', [.93 .695 .015 .25]);
set(h3,'FontSize',11);
% set(h3,'ytick',[log10(0.001) log10(0.01) log10(0.1) log10(1)],...
%     'yticklabel',{'0.001' '0.01' '0.1' '1.0'}, 'FontSize',11)
set(h3,'YTickLabel',num2str(get(h3,'YTick')','%.2f'))
%..........................................................................
set(gca,'FontSize',10,'FontName','Arial'); 
%==========================================================================
subplot(3,3,4);
%..........................................................................
hold on
box on
%..........................................................................
pcolor(TIME,ZDEP,CHL_ENPZD);
shading flat
%..........................................................................
title('(d) Euler-NPZD Chl (mg Chl m^{-3})')
%..........................................................................
xlim([1 365]);
% xlabel('Time (months)')
set(gca,'XTick',Tvec,'XTickLabel',[],'FontSize',11)
%..........................................................................
ylim([-250 0]); 
ylabel('Depth (m)');
set(gca,'YTick',[-250:50:0],'YTickLabel',[-250:50:0],'FontSize',11)
%..........................................................................
colormap(jet);
caxis([0 1.0]);
%..........................................................................
set(gca,'FontSize',10,'FontName','Arial'); 
%==========================================================================
subplot(3,3,5);
%..........................................................................
hold on
box on
%..........................................................................
pcolor(TIME,ZDEP,CHL_LNPZD);
shading flat
%..........................................................................
title('(e) IBM-NPZD Chl (mg Chl m^{-3})')
%..........................................................................
xlim([1 365]);
% xlabel('Time (months)')
set(gca,'XTick',Tvec,'XTickLabel',[],'FontSize',11)
%..........................................................................
ylim([-250 0]); 
% ylabel('Depth (m)');
set(gca,'YTick',[-250:50:0],'YTickLabel',[],'FontSize',11)
%..........................................................................
colormap(jet);
caxis([0 1.0]);
%..........................................................................
set(gca,'FontSize',10,'FontName','Arial'); 
%==========================================================================
subplot(3,3,6);
%..........................................................................
hold on
box on
%..........................................................................
pcolor(TIME,ZDEP,CHL_PIBM);
shading flat
%..........................................................................
title('(f) PIBM Chl (mg Chl m^{-3})')
%..........................................................................
xlim([1 365]);
% xlabel('Time (months)')
set(gca,'XTick',Tvec,'XTickLabel',[],'FontSize',11)
%..........................................................................
ylim([-250 0]); 
% ylabel('Depth (m)');
set(gca,'YTick',[-250:50:0],'YTickLabel',[],'FontSize',11)
%..........................................................................
colormap(jet);
caxis([0 1.0]);
h6 = colorbar('EastOutside');
set(h6, 'Position', [.93 .39 .015 .25]);
set(h6,'FontSize',11);
% set(h6,'ytick',[log10(0.001) log10(0.01) log10(0.1) log10(1)],...
%     'yticklabel',{'0.001' '0.01' '0.1' '1.0'}, 'FontSize',11)
set(h6,'YTickLabel',num2str(get(h6,'YTick')','%.2f'))
%..........................................................................
set(gca,'FontSize',10,'FontName','Arial'); 
%==========================================================================
subplot(3,3,7);
%..........................................................................
hold on
box on
%..........................................................................
pcolor(TIME,ZDEP,NPP_ENPZD);
shading flat
%..........................................................................
title('(g) Euler-NPZD NPP (mg C m^{-3} d^{-1})')
%..........................................................................
xlim([1 365]);
xlabel('Time (months)')
set(gca,'XTick',Tvec,'XTickLabel',Tout,'FontSize',11)
%..........................................................................
ylim([-250 0]); 
ylabel('Depth (m)');
set(gca,'YTick',[-250:50:0],'YTickLabel',[-250:50:0],'FontSize',11)
%..........................................................................
colormap(jet);
caxis([0 10.0]);
%..........................................................................
set(gca,'FontSize',10,'FontName','Arial'); 
%==========================================================================
subplot(3,3,8);
%..........................................................................
hold on
box on
%..........................................................................
pcolor(TIME,ZDEP,NPP_LNPZD);
shading flat
%..........................................................................
title('(h) IBM-NPZD NPP (mg C m^{-3} d^{-1})')
%..........................................................................
xlim([1 365]);
xlabel('Time (months)')
set(gca,'XTick',Tvec,'XTickLabel',Tout,'FontSize',11)
%..........................................................................
ylim([-250 0]); 
% ylabel('Depth (m)');
set(gca,'YTick',[-250:50:0],'YTickLabel',[],'FontSize',11)
%..........................................................................
colormap(jet);
caxis([0 10.0]);
%..........................................................................
set(gca,'FontSize',10,'FontName','Arial'); 
%==========================================================================
subplot(3,3,9);
%..........................................................................
hold on
box on
%..........................................................................
pcolor(TIME,ZDEP,NPP_PIBM);
shading flat
%..........................................................................
title('(i) PIBM NPP (mg C m^{-3} d^{-1})')
%..........................................................................
xlim([1 365]);
xlabel('Time (months)')
set(gca,'XTick',Tvec,'XTickLabel',Tout,'FontSize',11)
%..........................................................................
ylim([-250 0]); 
% ylabel('Depth (m)');
set(gca,'YTick',[-250:50:0],'YTickLabel',[],'FontSize',11)
%..........................................................................
colormap(jet);
caxis([0 10.0]);
h9 = colorbar('EastOutside');
set(h9, 'Position', [.93 .075 .015 .25]);
set(h9,'FontSize',11);
% set(h9,'ytick',[log10(0.001) log10(0.01) log10(0.1) log10(1)],...
%     'yticklabel',{'0.001' '0.01' '0.1' '1.0'}, 'FontSize',11)
set(h9,'YTickLabel',num2str(get(h9,'YTick')','%.2f'))
%..........................................................................
set(gca,'FontSize',10,'FontName','Arial'); 
%==========================================================================
%% Save figure:
%..........................................................................
set(gcf,'PaperPositionMode','auto');
print(gcf, '-dpng', 'FIG13_ModelComparisons.png');
%--------------------------------------------------------------------------
print('FIG13_ModelComparisons', '-depsc'); % Save as an EPS file
%--------------------------------------------------------------------------
% Get the current figure position in inches
fig = gcf;
fig.Units = 'inches';
figPosition = fig.Position;
%..........................................................................
% Set PaperSize to match the figure dimensions
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [figPosition(3) figPosition(4)]);
%..........................................................................
% Save the figure as a PDF using the print command
print(gcf, 'FIG13_ModelComparisons.pdf', '-dpdf', '-bestfit');
close all;
%==========================================================================
return
