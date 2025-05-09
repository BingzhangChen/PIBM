close all
clear all
warning off
%==========================================================================

%==========================================================================
%% Script to plot the model physical forcing
%--------------------------------------------------------------------------
% Writen by Iria Sala
% Created on 10.12.2024
%==========================================================================

%==========================================================================
%% Load hybrid-model Eulerian fields:
%==========================================================================
path = 'G:\My Drive\RESEARCH\PROJECT LEVERHULME\CODE\1D-Model\OUTPUTS\v033_RUN048_20K\';
%..........................................................................
EUL = fullfile(path,'Euler.nc');
%==========================================================================
Z_r = double(nc_varget(EUL,'Z_r'));   % Depth (m), intermediate point
Z_w = double(nc_varget(EUL,'Z_w'));   % Depth (m), limit point
DEP = repmat(Z_r',365,1);
%--------------------------------------------------------------------------
DAYS = double(nc_varget(EUL,'Day'));
tfin = length(DAYS) - 1;
tini = tfin - 364;
%--------------------------------------------------------------------------
DAY = 1:365;
DOY = repmat(DAY',1,length(Z_r));
%--------------------------------------------------------------------------
% TEMP = double(nc_varget(EUL,'Temp')); % Temperature (ºC)
% TEMP = TEMP(tini:tfin,:);               % Last year
%--------------------------------------------------------------------------
% KV = double(nc_varget(EUL,'Kv'));     % Kv (m s-2)
% KV = KV(tini:tfin,:);                   % Last year
%--------------------------------------------------------------------------
% NO3 = double(nc_varget(EUL,'NO3'));   % NO3 (mmol N m-3)
% NO3 = NO3(tini:tfin,:);                 % Last year
%--------------------------------------------------------------------------
PHYN  = double(nc_varget(EUL,'PN'));  % Chl (mg Chl m-3)
PHYN  = PHYN(tini:tfin,:);              % Last year
%--------------------------------------------------------------------------
PHYC  = double(nc_varget(EUL,'PC'));  % Chl (mg Chl m-3)
PHYC  = PHYC(tini:tfin,:);              % Last year
%--------------------------------------------------------------------------
% PCHL  = double(nc_varget(EUL,'CHL')); % Chl (mg Chl m-3)
% PCHL  = PCHL(tini:tfin,:);              % Last year
%--------------------------------------------------------------------------
% NPP  = double(nc_varget(EUL,'NPP'));  % NPP (mg C m-3 d-1)
% NPP  = NPP(tini:tfin,:);                % Last year
%--------------------------------------------------------------------------
DET  = double(nc_varget(EUL,'DET'));  % NPP (mg C m-3 d-1)
DET  = DET(tini:tfin,:);                % Last year
%--------------------------------------------------------------------------
ZOO  = double(nc_varget(EUL,'ZOO'));  % Total zoo (mmol N m-3)
ZOOT = squeeze(sum(ZOO,3));
ZOOT = ZOOT(tini:tfin,:);               % Last year
%==========================================================================

%==========================================================================
%% Plot time vectors:
%==========================================================================
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
subplot = @(m,n,p) subtightplot (m, n, p, [0.06 0.08], [0.09 0.06], [0.09 0.08]);
if ~make_it_tight,  clear subplot;  end
%..........................................................................
Fig = figure;
set(gcf, 'Color','white');
set(Fig, 'Position',[900,150,900,600]);
%==========================================================================
F01 = subplot(2,2,1);
%..........................................................................
hold on
box on
%..........................................................................
pcolor(DOY,DEP,PHYC);
shading flat
%..........................................................................
title('(a) Phytoplankton carbon (mmol C m^{-3})')
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
caxis([0 3]);
h1 = colorbar('EastOutside');
set(h1, 'Position',[.475 .55 .015 .38]);
set(h1,'FontSize',11);
set(h1,'ytick',[0:0.5:3],'yticklabel',[0:0.5:3],'FontSize',11)
set(h1, 'YTickLabel', num2str(get(h1, 'YTick')', '%.2f'))
%..........................................................................
set(gca,'FontSize',11,'FontName','Arial');
%==========================================================================
F02 = subplot(2,2,2);
%..........................................................................
hold on
box on
%..........................................................................
pcolor(DOY,DEP,PHYN);
shading flat
%..........................................................................
title('(b) Phytoplankton nitrogen (mmol N m^{-3})')
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
caxis([0 0.5]);
h2 = colorbar('EastOutside');
set(h2, 'Position',[.93 .55 .015 .38]);
set(h2,'FontSize',11);
set(h2,'ytick',[0:0.1:0.5],'yticklabel',[0:0.1:0.5],'FontSize',11)
set(h2, 'YTickLabel', num2str(get(h2, 'YTick')', '%.2f'))
%..........................................................................
set(gca,'FontSize',11,'FontName','Arial');
%==========================================================================
F03 = subplot(2,2,3);
%..........................................................................
hold on
box on
%..........................................................................
pcolor(DOY,DEP,ZOOT);
shading flat
%..........................................................................
title('(c) Zooplankton (mmol N m^{-3})')
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
caxis([0 0.8]);
h3 = colorbar('EastOutside');
set(h3, 'Position',[.475 .095 .015 .38]);
set(h3,'FontSize',11);
set(h3,'ytick',[0:0.2:0.8],'yticklabel',[0:0.2:0.8],'FontSize',11)
set(h3, 'YTickLabel', num2str(get(h3, 'YTick')', '%.2f'))
%..........................................................................
set(gca,'FontSize',11,'FontName','Arial');
%==========================================================================
F04 = subplot(2,2,4);
%..........................................................................
hold on
box on
%..........................................................................
pcolor(DOY,DEP,DET);
shading flat
%..........................................................................
title('(d) Detritus (mmol N m^{-3})')
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
caxis([0 0.2]);
h4 = colorbar('EastOutside');
set(h4, 'Position',[.93 .095 .015 .38]);
set(h4,'FontSize',11);
set(h4,'ytick',[0:0.05:0.2],'yticklabel',[0:0.05:0.2],'FontSize',11)
set(h4, 'YTickLabel', num2str(get(h4, 'YTick')', '%.2f'))
%..........................................................................
set(gca,'FontSize',11,'FontName','Arial');
%==========================================================================
%% Save figure:
%..........................................................................
set(gcf,'PaperPositionMode','auto');
print(gcf, '-dpng', 'FIG06_EULER_PZD.png');
%--------------------------------------------------------------------------
print('FIG06_EULER_PZD', '-depsc'); % Save as an EPS file
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
print(gcf, 'FIG06_EULER_PZD.pdf', '-dpdf', '-bestfit');
%==========================================================================
return
