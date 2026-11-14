function [all_results,s1,s2,s3,s4]=decile_slopes_PanArctic_SizeFractions(file,site,time_seg,clims,fsize)
% site='(b) Villum' 
% time_seg='season'
% fsize=25

file1=[datenum(file.date) file.num_tot];

%     File Name    title/label  Units          cm^{-3}
% name={'ozone','Ozone','ppbv'};
name={'number','Total Number','cm^{-3}'};
% time_seg='month';
res='daily';
method='percentile';
alpha=90;

if strcmp(time_seg,'season')
    h_TS0=NaN(5,4);
    sig_TS0=NaN(5,4);
    sen_TS0=NaN(5,4);
    CIlower_TS0=NaN(5,4);
    CIupper_TS0=NaN(5,4);
elseif strcmp(time_seg,'month')
    h_TS0=NaN(5,12);
    sig_TS0=NaN(5,12);
    sen_TS0=NaN(5,12);
    CIlower_TS0=NaN(5,12);
    CIupper_TS0=NaN(5,12);
end

pcts=[5,25,50,75,95];

for x=1:length(pcts)
p=pcts(x);
result1=PW3_nofig(file1,name,time_seg,res,method,alpha,p);    
            h_TS0(x,:)=[result1(1:end-1).ss];
            sig_TS0(x,:)=[result1(1:end-1).P];
            sen_TS0(x,:)=[result1(1:end-1).slope];
            CIlower_TS0(x,:)=[result1(1:end-1).LCL];
            CIupper_TS0(x,:)=[result1(1:end-1).UCL];     
            disp([num2str(x) ' out of 5 for Total for ' site{1}])
end

results_tot=struct();
results_tot.h=h_TS0;
results_tot.sig=sig_TS0;
results_tot.sen=sen_TS0;
results_tot.ciL=CIlower_TS0;
results_tot.ciU=CIupper_TS0;



file1=[datenum(file.date) file.num_nuc];

%     File Name    title/label  Units          cm^{-3}
% name={'ozone','Ozone','ppbv'};
name={'number','Nucleation Mode Number','cm^{-3}'};
% time_seg='month';
res='daily';
method='percentile';
alpha=90;

if strcmp(time_seg,'season')
    h_TS1=NaN(5,4);
    sig_TS1=NaN(5,4);
    sen_TS1=NaN(5,4);
    CIlower_TS1=NaN(5,4);
    CIupper_TS1=NaN(5,4);
elseif strcmp(time_seg,'month')
    h_TS1=NaN(5,12);
    sig_TS1=NaN(5,12);
    sen_TS1=NaN(5,12);
    CIlower_TS1=NaN(5,12);
    CIupper_TS1=NaN(5,12);
end

pcts=[5,25,50,75,95];

for x=1:length(pcts)
p=pcts(x);
result1=PW3_nofig(file1,name,time_seg,res,method,alpha,p);    
            h_TS1(x,:)=[result1(1:end-1).ss];
            sig_TS1(x,:)=[result1(1:end-1).P];
            sen_TS1(x,:)=[result1(1:end-1).slope];
            CIlower_TS1(x,:)=[result1(1:end-1).LCL];
            CIupper_TS1(x,:)=[result1(1:end-1).UCL];     
            disp([num2str(x) ' out of 5 for Nucleation for ' site{1}])
end

results_nuc=struct();
results_nuc.h=h_TS1;
results_nuc.sig=sig_TS1;
results_nuc.sen=sen_TS1;
results_nuc.ciL=CIlower_TS1;
results_nuc.ciU=CIupper_TS1;


file2=[datenum(file.date) file.num_aik];

%     File Name    title/label  Units          cm^{-3}
% name={'ozone','Ozone','ppbv'};
name={'number','Nucleation Mode Number','cm^{-3}'};
% time_seg='season';
res='daily';
method='percentile';
alpha=90;

if strcmp(time_seg,'season')
    h_TS2=NaN(5,4);
    sig_TS2=NaN(5,4);
    sen_TS2=NaN(5,4);
    CIlower_TS2=NaN(5,4);
    CIupper_TS2=NaN(5,4);
elseif strcmp(time_seg,'month')
    h_TS2=NaN(5,12);
    sig_TS2=NaN(5,12);
    sen_TS2=NaN(5,12);
    CIlower_TS2=NaN(5,12);
    CIupper_TS2=NaN(5,12);
end


pcts=[5,25,50,75,95];

for x=1:length(pcts)
p=pcts(x);

result2=PW3_nofig(file2,name,time_seg,res,method,alpha,p);    
            h_TS2(x,:)=[result2(1:end-1).ss];
            sig_TS2(x,:)=[result2(1:end-1).P];
            sen_TS2(x,:)=[result2(1:end-1).slope];
            CIlower_TS2(x,:)=[result2(1:end-1).LCL];
            CIupper_TS2(x,:)=[result2(1:end-1).UCL];     
            disp([num2str(x) ' out of 5 for Aikten ' site{1}])

end

results_aik=struct();
results_aik.h=h_TS2;
results_aik.sig=sig_TS2;
results_aik.sen=sen_TS2;
results_aik.ciL=CIlower_TS2;
results_aik.ciU=CIupper_TS2;

file3=[datenum(file.date) file.num_acc];

%     File Name    title/label  Units          cm^{-3}
% name={'ozone','Ozone','ppbv'};
name={'number','Nucleation Mode Number','cm^{-3}'};
% time_seg='season';
res='daily';
method='percentile';
alpha=90;

if strcmp(time_seg,'season')
    h_TS3=NaN(5,4);
    sig_TS3=NaN(5,4);
    sen_TS3=NaN(5,4);
    CIlower_TS3=NaN(5,4);
    CIupper_TS3=NaN(5,4);
elseif strcmp(time_seg,'month')
    h_TS3=NaN(5,12);
    sig_TS3=NaN(5,12);
    sen_TS3=NaN(5,12);
    CIlower_TS3=NaN(5,12);
    CIupper_TS3=NaN(5,12);
end


pcts=[5,25,50,75,95];

for x=1:length(pcts)
p=pcts(x);

result3=PW3_nofig(file3,name,time_seg,res,method,alpha,p);    
            h_TS3(x,:)=[result3(1:end-1).ss];
            sig_TS3(x,:)=[result3(1:end-1).P];
            sen_TS3(x,:)=[result3(1:end-1).slope];
            CIlower_TS3(x,:)=[result3(1:end-1).LCL];
            CIupper_TS3(x,:)=[result3(1:end-1).UCL];     
            disp([num2str(x) ' out of 5 for Accumulation ' site{1}])
           
end
results_acc=struct();
results_acc.h=h_TS3;
results_acc.sig=sig_TS3;
results_acc.sen=sen_TS3;
results_acc.ciL=CIlower_TS3;
results_acc.ciU=CIupper_TS3;

all_results=struct();
all_results.results_tot=results_tot;
all_results.results_nuc=results_nuc;
all_results.results_aik=results_aik;
all_results.results_acc=results_acc;

min_sen=min(min([results_tot.sen,results_nuc.sen,results_aik.sen,results_acc.sen]));
max_sen=max(max([results_tot.sen,results_nuc.sen,results_aik.sen,results_acc.sen]));
% clims=[min_sen max_sen];

min_lcl=min(min([results_tot.ciL,results_nuc.ciL,results_aik.ciL,results_acc.ciL]));
max_ucl=max(max([results_tot.ciU,results_nuc.ciU,results_aik.ciU,results_acc.ciU]));
clims_lcl_ucl=[min_lcl max_ucl];




%% Sens Slope
addpath('C:\Users\pernov\Documents\MATLAB\hfill_vfill\hfill_and_vfill')

figure('units','normalized','outerposition',[0 0 1 1])
% if ~strcmp(site,'Zeppelin')


s1=subplot(4,1,1);

if strcmp(time_seg,'season')
    i=imagesc(1:4,1:5,flipud(sen_TS0));
elseif strcmp(time_seg,'month')
    i=imagesc(1:12,1:5,flipud(sen_TS0));
end

h=colorbar;%('Location','northoutside','AxisLocation','out');
% h.Label.String=['Slope / ' name{3} ' yr^{-1}'];
h.TickDirection='out';
h.TickLength=0.05;

hold on

ss_array=flipud(logical(h_TS0==90));
ss_array(flipud(sen_TS0)==0)=0;

for x=1:4
    for y=1:5
        
        if ss_array(y,x)==1
            vert = 0.5+[x-1 y-1; x y-1; x y; x-1 y]; % x and y vertex coordinates
            fac = [1 2 3 4];              % vertices to connect to make square
            ptch=patch('Faces',fac,'Vertices',vert,'FaceColor','none','LineWidth',1);
            htch=hatchfill(ptch, 'cross', 45, 10);
            set(htch, 'Color', 'white')
        end
    end
end

% 
% if strcmp(time_seg,'season')
%     hold on;stipple(1:4,1:5,flipud(logical(h_TS0==90)),'density',40,'markersize',5)
% elseif strcmp(time_seg,'month')
%     hold on;stipple(1:12,1:5,flipud(logical(h_TS0==90)),'density',100,'markersize',10)
% end


% hold on;stipple(1:4,1:100,flipud(logical(h_TS0==90)),'density',100,'markersize',10)
% hold on;stipple(1:4,1:100,flipud(logical(h_TS0==90)),'density',100,'markersize',10)

if strcmp(time_seg,'season')
    xticks([1 2 3 4])
elseif strcmp(time_seg,'month')
    xticks([1 2 3 4 5 6 7 8 9 10 11 12])
end

% xticks([1 2 3 4])
% xticks([1 2 3 4 5 6 7 8 9 10 11 12])

if strcmp(time_seg,'season')
    % xticklabels({'Winter','Spring','Summer','Autumn'})
    xticklabels('')
elseif strcmp(time_seg,'month')
    xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
end


% xticklabels({'Winter','Spring','Summer','Autumn'})
% xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
ylim([0.5 5.5])
yticks([1 : 5])
% yticks([1 10:10: 100])
yticklabels({'95','75','50','25','5'})
% yticklabels({'100','90','80','70','60','50','40','30','20','10','0'})
% ylabel('Percentile')
    ax=gca;
    ax.Box='on';
    ax.FontWeight='bold';
    ax.FontSize=fsize;
    ax.XAxis.TickLength = [0 0];
set(gca,'TickDir','out');
    ax.CLim=[clims(1) clims(2)];
%     if strcmp('Pallas',site)
%        
%     end
colormap(s1,cmocean('balance','zero'));

if strcmp(time_seg,'season')
    % text(2.5, -10.5,site,'FontSize',30,'FontWeight','bold','HorizontalAlignment','center')
    text(1, -0.5,site{1},'FontSize',fsize+5,'FontWeight','bold','HorizontalAlignment','center')
elseif strcmp(time_seg,'month')
    text(6.5, -35,site{1},'FontSize',fsize,'FontWeight','bold','HorizontalAlignment','center')
end

% text(2.5, -35,site,'FontSize',25,'FontWeight','bold','HorizontalAlignment','center')
% text(6.5, -35,site,'FontSize',25,'FontWeight','bold','HorizontalAlignment','center')


%  h.Position=[0.9111    0.1103    0.0184    0.8148];
if strcmp(time_seg,'season')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
elseif strcmp(time_seg,'month')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
end


% vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
% vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
title('Total Number')
% end

s2=subplot(4,1,2);

if strcmp(time_seg,'season')
    i=imagesc(1:4,1:5,flipud(sen_TS1));
elseif strcmp(time_seg,'month')
    i=imagesc(1:12,1:5,flipud(sen_TS1));
end

h=colorbar;%('Location','northoutside','AxisLocation','out');
% h.Label.String=['Slope / ' name{3} ' yr^{-1}'];
h.TickDirection='out';
h.TickLength=0.05;

hold on

ss_array=flipud(logical(h_TS1==90));
ss_array(flipud(sen_TS1)==0)=0;

for x=1:4
    for y=1:5
        
        if ss_array(y,x)==1
            vert = 0.5+[x-1 y-1; x y-1; x y; x-1 y]; % x and y vertex coordinates
            fac = [1 2 3 4];              % vertices to connect to make square
            ptch=patch('Faces',fac,'Vertices',vert,'FaceColor','none','LineWidth',0.75);
            htch=hatchfill(ptch, 'cross', 45, 10);
            set(htch, 'Color', 'white')
        end
    end
end

% 
% if strcmp(time_seg,'season')
%     hold on;stipple(1:4,1:5,flipud(logical(h_TS1==90)),'density',40,'markersize',5)
% elseif strcmp(time_seg,'month')
%     hold on;stipple(1:12,1:5,flipud(logical(h_TS1==90)),'density',100,'markersize',10)
% end


% hold on;stipple(1:4,1:100,flipud(logical(h_TS1==90)),'density',100,'markersize',10)
% hold on;stipple(1:4,1:100,flipud(logical(h_TS1==90)),'density',100,'markersize',10)

if strcmp(time_seg,'season')
    xticks([1 2 3 4])
elseif strcmp(time_seg,'month')
    xticks([1 2 3 4 5 6 7 8 9 10 11 12])
end

% xticks([1 2 3 4])
% xticks([1 2 3 4 5 6 7 8 9 10 11 12])

if strcmp(time_seg,'season')
    % xticklabels({'Winter','Spring','Summer','Autumn'})
    xticklabels('')
elseif strcmp(time_seg,'month')
    xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
end


% xticklabels({'Winter','Spring','Summer','Autumn'})
% xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
ylim([0.5 5.5])
yticks([1 : 5])
% yticks([1 10:10: 100])
yticklabels({'95','75','50','25','5'})
% yticklabels({'100','90','80','70','60','50','40','30','20','10','0'})
% ylabel('Percentile')
    ax=gca;
    ax.Box='on';
    ax.FontWeight='bold';
    ax.FontSize=fsize;
    ax.XAxis.TickLength = [0 0];
set(gca,'TickDir','out');
    ax.CLim=[clims(1) clims(2)];
%     if strcmp('Pallas',site)
%        
%     end
colormap(s2,cmocean('balance','zero'));
% 
% if strcmp(time_seg,'season')
%     % text(2.5, -10.5,site,'FontSize',30,'FontWeight','bold','HorizontalAlignment','center')
%     text(1, -0.5,site,'FontSize',30,'FontWeight','bold','HorizontalAlignment','center')
% elseif strcmp(time_seg,'month')
%     text(6.5, -35,site,'FontSize',30,'FontWeight','bold','HorizontalAlignment','center')
% end

% text(2.5, -35,site,'FontSize',25,'FontWeight','bold','HorizontalAlignment','center')
% text(6.5, -35,site,'FontSize',25,'FontWeight','bold','HorizontalAlignment','center')


%  h.Position=[0.9111    0.1103    0.0184    0.8148];
if strcmp(time_seg,'season')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
elseif strcmp(time_seg,'month')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
end


% vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
% vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
title('Nucleation Mode Number')
% end


s3=subplot(4,1,3);

if strcmp(time_seg,'season')
    i=imagesc(1:4,1:5,flipud(sen_TS2));
elseif strcmp(time_seg,'month')
    i=imagesc(1:12,1:5,flipud(sen_TS2));
end

cbar=colorbar;%('Location','northoutside','AxisLocation','out');
% cbar.Label.String=['Slope / ' name{3} ' yr^{-1}'];
cbar.TickDirection='out';
cbar.TickLength=0.05;

hold on;

ss_array=flipud(logical(h_TS2==90));
ss_array(flipud(sen_TS2)==0)=0;

for x=1:4
    for y=1:5
        
        if ss_array(y,x)==1
            vert = 0.5+[x-1 y-1; x y-1; x y; x-1 y]; % x and y vertex coordinates
            fac = [1 2 3 4];              % vertices to connect to make square
            ptch=patch('Faces',fac,'Vertices',vert,'FaceColor','none','LineWidth',0.75);
            htch=hatchfill(ptch, 'cross', 45, 10);
            set(htch, 'Color', 'white')
        end
    end
end

% if strcmp(time_seg,'season')
%     hold on;stipple(1:4,1:5,flipud(logical(h_TS2==90)),'density',100,'markersize',10)
% elseif strcmp(time_seg,'month')
%     hold on;stipple(1:12,1:5,flipud(logical(h_TS2==90)),'density',100,'markersize',10)
% end

if strcmp(time_seg,'season')
    xticks([1 2 3 4])
elseif strcmp(time_seg,'month')
    xticks([1 2 3 4 5 6 7 8 9 10 11 12])
end

if strcmp(time_seg,'season')
    % xticklabels({'Winter','Spring','Summer','Autumn'})
    xticklabels('')
elseif strcmp(time_seg,'month')
    xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
end

ylim([0.5 5.5])
yticks([1 :5])
% yticks([1 10:10: 100])
yticklabels({'95','75','50','25','5'})
% yticklabels({'100','90','80','70','60','50','40','30','20','10','0'})
% yl=ylabel('Percentile');

    ax=gca;
    ax.Box='on';
    ax.FontWeight='bold';
    ax.FontSize=fsize;    
    ax.XAxis.TickLength = [0 0];
    ax.CLim=[clims(1) clims(2)];
set(gca,'TickDir','out');
%     if strcmp('Pallas',site)
%        ax.CLim=[-2 37];
%     end
colormap(s3,cmocean('balance','zero'))

%  h.Position=[0.9111    0.1103    0.0184    0.8148];
if strcmp(time_seg,'season')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
elseif strcmp(time_seg,'month')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
end

title('Aitken Mode Number')


s4=subplot(4,1,4);

if strcmp(time_seg,'season')
    i=imagesc(1:4,1:5,flipud(sen_TS3));
elseif strcmp(time_seg,'month')
    i=imagesc(1:12,1:5,flipud(sen_TS3));
end

h=colorbar;%('Location','northoutside','AxisLocation','out');
% h.Label.String=['Slope / ' name{3} ' yr^{-1}'];
h.TickDirection='out';
h.TickLength=0.05;

hold on;

ss_array=flipud(logical(h_TS3==90));
ss_array(flipud(sen_TS3)==0)=0;

for x=1:4
    for y=1:5
        
        if ss_array(y,x)==1
            vert = 0.5+[x-1 y-1; x y-1; x y; x-1 y]; % x and y vertex coordinates
            fac = [1 2 3 4];              % vertices to connect to make square
            ptch=patch('Faces',fac,'Vertices',vert,'FaceColor','none','LineWidth',0.75);
            htch=hatchfill(ptch, 'cross', 45, 10);
            set(htch, 'Color', 'white')
        end
    end
end
% 
% if strcmp(time_seg,'season')
%     hold on;stipple(1:4,1:100,flipud(logical(h_TS3==90)),'density',100,'markersize',10)
% elseif strcmp(time_seg,'month')
%     hold on;stipple(1:12,1:100,flipud(logical(h_TS3==90)),'density',100,'markersize',10)
% end

if strcmp(time_seg,'season')
    xticks([1 2 3 4])
elseif strcmp(time_seg,'month')
    xticks([1 2 3 4 5 6 7 8 9 10 11 12])
end

if strcmp(time_seg,'season')
    xticklabels({'Winter','Spring','Summer','Autumn'})
elseif strcmp(time_seg,'month')
    xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
end

ylim([0.5 5.5])
yticks([1 :5])
% yticks([1 10:10: 100])
yticklabels({'95','75','50','25','5'})
% yticklabels({'100','90','80','70','60','50','40','30','20','10','0'})
% ylabel('Percentile')
    ax=gca;
    ax.Box='on';
    ax.FontWeight='bold';
    ax.FontSize=fsize;
    ax.XAxis.FontSize = fsize+4;
    ax.XAxis.TickLength = [0 0];
    ax.CLim=[clims(1) clims(2)];
%     if strcmp('Pallas',site)
%        ax.CLim=[-2 37];
%     end
set(gca,'TickDir','out');
colormap(s4,cmocean('balance','zero'))

%  h.Position=[0.9111    0.1103    0.0184    0.8148];

if strcmp(time_seg,'season')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
elseif strcmp(time_seg,'month')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
end

title('Accumulation Mode Number')
% 
% s1.Position(4)=s1.Position(4)+0.05;
% s2.Position(4)=s2.Position(4)+0.05;
% s3.Position(4)=s3.Position(4)+0.05;



% ---- reposition subplots (season mode only) ----
if strcmp(time_seg,'season')
    drawnow   % let colorbar auto-resize finish before we override positions

    s1.Position(4)=s1.Position(4)+0.05;
    s2.Position(4)=s2.Position(4)+0.05;
    s3.Position(4)=s3.Position(4)+0.05;
    s4.Position(4)=s4.Position(4)+0.05;

    s1.Position(2)=s1.Position(2)-0.02;
    s2.Position(2)=s2.Position(2)-0.02;
    s3.Position(2)=s3.Position(2)-0.02;
    s4.Position(2)=s4.Position(2)-0.02;

    % cbar.Label.Position=[3.3883 18.5 0];
    % yl.Position=[0.3044 -0.25 2.0000];

    f1=figtitle_side(['Slope / ' name{3} ' yr^{-1}'],'fontweight','bold');
    f1.Position=[0.925,0.50 0];
    f1=figtitle_side('Percentile','fontweight','bold');
    f1.Position=[0.075,0.50 0];
end
% -------------------------------------------------






%% %% LCL
addpath('C:\Users\pernov\Documents\MATLAB\hfill_vfill\hfill_and_vfill')

figure('units','normalized','outerposition',[0 0 1 1])
% if ~strcmp(site,'Zeppelin')


s1=subplot(4,1,1);

if strcmp(time_seg,'season')
    i=imagesc(1:4,1:5,flipud(CIlower_TS0));
elseif strcmp(time_seg,'month')
    i=imagesc(1:12,1:5,flipud(CIlower_TS0));
end

h=colorbar;%('Location','northoutside','AxisLocation','out');
% h.Label.String=['Slope / ' name{3} ' yr^{-1}'];
h.TickDirection='out';
h.TickLength=0.05;

hold on

ss_array=flipud(logical(h_TS0==90));
ss_array(flipud(CIlower_TS0)==0)=0;

for x=1:4
    for y=1:5
        
        if ss_array(y,x)==1
            vert = 0.5+[x-1 y-1; x y-1; x y; x-1 y]; % x and y vertex coordinates
            fac = [1 2 3 4];              % vertices to connect to make square
            ptch=patch('Faces',fac,'Vertices',vert,'FaceColor','none','LineWidth',1);
            htch=hatchfill(ptch, 'cross', 45, 10);
            set(htch, 'Color', 'white')
        end
    end
end

% 
% if strcmp(time_seg,'season')
%     hold on;stipple(1:4,1:5,flipud(logical(h_TS0==90)),'density',40,'markersize',5)
% elseif strcmp(time_seg,'month')
%     hold on;stipple(1:12,1:5,flipud(logical(h_TS0==90)),'density',100,'markersize',10)
% end


% hold on;stipple(1:4,1:100,flipud(logical(h_TS0==90)),'density',100,'markersize',10)
% hold on;stipple(1:4,1:100,flipud(logical(h_TS0==90)),'density',100,'markersize',10)

if strcmp(time_seg,'season')
    xticks([1 2 3 4])
elseif strcmp(time_seg,'month')
    xticks([1 2 3 4 5 6 7 8 9 10 11 12])
end

% xticks([1 2 3 4])
% xticks([1 2 3 4 5 6 7 8 9 10 11 12])

if strcmp(time_seg,'season')
    % xticklabels({'Winter','Spring','Summer','Autumn'})
    xticklabels('')
elseif strcmp(time_seg,'month')
    xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
end


% xticklabels({'Winter','Spring','Summer','Autumn'})
% xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
ylim([0.5 5.5])
yticks([1 : 5])
% yticks([1 10:10: 100])
yticklabels({'95','75','50','25','5'})
% yticklabels({'100','90','80','70','60','50','40','30','20','10','0'})
% ylabel('Percentile')
    ax=gca;
    ax.Box='on';
    ax.FontWeight='bold';
    ax.FontSize=fsize;
    ax.XAxis.TickLength = [0 0];
set(gca,'TickDir','out');
    ax.CLim=[clims_lcl_ucl(1) clims_lcl_ucl(2)];
%     if strcmp('Pallas',site)
%        
%     end
colormap(s1,cmocean('balance','zero'));

if strcmp(time_seg,'season')
    % text(2.5, -10.5,site,'FontSize',30,'FontWeight','bold','HorizontalAlignment','center')
    text(1, -0.5,site{2},'FontSize',fsize+5,'FontWeight','bold','HorizontalAlignment','center')
elseif strcmp(time_seg,'month')
    text(6.5, -35,site{2},'FontSize',fsize,'FontWeight','bold','HorizontalAlignment','center')
end

% text(2.5, -35,site,'FontSize',25,'FontWeight','bold','HorizontalAlignment','center')
% text(6.5, -35,site,'FontSize',25,'FontWeight','bold','HorizontalAlignment','center')


%  h.Position=[0.9111    0.1103    0.0184    0.8148];
if strcmp(time_seg,'season')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
elseif strcmp(time_seg,'month')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
end


% vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
% vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
title('Total Number')
% end

s2=subplot(4,1,2);

if strcmp(time_seg,'season')
    i=imagesc(1:4,1:5,flipud(CIlower_TS1));
elseif strcmp(time_seg,'month')
    i=imagesc(1:12,1:5,flipud(CIlower_TS1));
end

h=colorbar;%('Location','northoutside','AxisLocation','out');
% h.Label.String=['Slope / ' name{3} ' yr^{-1}'];
h.TickDirection='out';
h.TickLength=0.05;

hold on

ss_array=flipud(logical(h_TS1==90));
ss_array(flipud(CIlower_TS1)==0)=0;

for x=1:4
    for y=1:5
        
        if ss_array(y,x)==1
            vert = 0.5+[x-1 y-1; x y-1; x y; x-1 y]; % x and y vertex coordinates
            fac = [1 2 3 4];              % vertices to connect to make square
            ptch=patch('Faces',fac,'Vertices',vert,'FaceColor','none','LineWidth',0.75);
            htch=hatchfill(ptch, 'cross', 45, 10);
            set(htch, 'Color', 'white')
        end
    end
end

% 
% if strcmp(time_seg,'season')
%     hold on;stipple(1:4,1:5,flipud(logical(h_TS1==90)),'density',40,'markersize',5)
% elseif strcmp(time_seg,'month')
%     hold on;stipple(1:12,1:5,flipud(logical(h_TS1==90)),'density',100,'markersize',10)
% end


% hold on;stipple(1:4,1:100,flipud(logical(h_TS1==90)),'density',100,'markersize',10)
% hold on;stipple(1:4,1:100,flipud(logical(h_TS1==90)),'density',100,'markersize',10)

if strcmp(time_seg,'season')
    xticks([1 2 3 4])
elseif strcmp(time_seg,'month')
    xticks([1 2 3 4 5 6 7 8 9 10 11 12])
end

% xticks([1 2 3 4])
% xticks([1 2 3 4 5 6 7 8 9 10 11 12])

if strcmp(time_seg,'season')
    % xticklabels({'Winter','Spring','Summer','Autumn'})
    xticklabels('')
elseif strcmp(time_seg,'month')
    xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
end


% xticklabels({'Winter','Spring','Summer','Autumn'})
% xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
ylim([0.5 5.5])
yticks([1 : 5])
% yticks([1 10:10: 100])
yticklabels({'95','75','50','25','5'})
% yticklabels({'100','90','80','70','60','50','40','30','20','10','0'})
% ylabel('Percentile')
    ax=gca;
    ax.Box='on';
    ax.FontWeight='bold';
    ax.FontSize=fsize;
    ax.XAxis.TickLength = [0 0];
set(gca,'TickDir','out');
    ax.CLim=[clims_lcl_ucl(1) clims_lcl_ucl(2)];
%     if strcmp('Pallas',site)
%        
%     end
colormap(s2,cmocean('balance','zero'));
% 
% if strcmp(time_seg,'season')
%     % text(2.5, -10.5,site,'FontSize',30,'FontWeight','bold','HorizontalAlignment','center')
%     text(1, -0.5,site,'FontSize',30,'FontWeight','bold','HorizontalAlignment','center')
% elseif strcmp(time_seg,'month')
%     text(6.5, -35,site,'FontSize',30,'FontWeight','bold','HorizontalAlignment','center')
% end

% text(2.5, -35,site,'FontSize',25,'FontWeight','bold','HorizontalAlignment','center')
% text(6.5, -35,site,'FontSize',25,'FontWeight','bold','HorizontalAlignment','center')


%  h.Position=[0.9111    0.1103    0.0184    0.8148];
if strcmp(time_seg,'season')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
elseif strcmp(time_seg,'month')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
end


% vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
% vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
title('Nucleation Mode Number')
% end


s3=subplot(4,1,3);

if strcmp(time_seg,'season')
    i=imagesc(1:4,1:5,flipud(CIlower_TS2));
elseif strcmp(time_seg,'month')
    i=imagesc(1:12,1:5,flipud(CIlower_TS2));
end

cbar=colorbar;%('Location','northoutside','AxisLocation','out');
% cbar.Label.String=['Slope / ' name{3} ' yr^{-1}'];
cbar.TickDirection='out';
cbar.TickLength=0.05;

hold on;

ss_array=flipud(logical(h_TS2==90));
ss_array(flipud(CIlower_TS2)==0)=0;

for x=1:4
    for y=1:5
        
        if ss_array(y,x)==1
            vert = 0.5+[x-1 y-1; x y-1; x y; x-1 y]; % x and y vertex coordinates
            fac = [1 2 3 4];              % vertices to connect to make square
            ptch=patch('Faces',fac,'Vertices',vert,'FaceColor','none','LineWidth',0.75);
            htch=hatchfill(ptch, 'cross', 45, 10);
            set(htch, 'Color', 'white')
        end
    end
end

% if strcmp(time_seg,'season')
%     hold on;stipple(1:4,1:5,flipud(logical(h_TS2==90)),'density',100,'markersize',10)
% elseif strcmp(time_seg,'month')
%     hold on;stipple(1:12,1:5,flipud(logical(h_TS2==90)),'density',100,'markersize',10)
% end

if strcmp(time_seg,'season')
    xticks([1 2 3 4])
elseif strcmp(time_seg,'month')
    xticks([1 2 3 4 5 6 7 8 9 10 11 12])
end

if strcmp(time_seg,'season')
    % xticklabels({'Winter','Spring','Summer','Autumn'})
    xticklabels('')
elseif strcmp(time_seg,'month')
    xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
end

ylim([0.5 5.5])
yticks([1 :5])
% yticks([1 10:10: 100])
yticklabels({'95','75','50','25','5'})
% yticklabels({'100','90','80','70','60','50','40','30','20','10','0'})
% yl=ylabel('Percentile');

    ax=gca;
    ax.Box='on';
    ax.FontWeight='bold';
    ax.FontSize=fsize;    
    ax.XAxis.TickLength = [0 0];
    ax.CLim=[clims_lcl_ucl(1) clims_lcl_ucl(2)];
set(gca,'TickDir','out');
%     if strcmp('Pallas',site)
%        ax.CLim=[-2 37];
%     end
colormap(s3,cmocean('balance','zero'))

%  h.Position=[0.9111    0.1103    0.0184    0.8148];
if strcmp(time_seg,'season')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
elseif strcmp(time_seg,'month')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
end

title('Aitken Mode Number')


s4=subplot(4,1,4);

if strcmp(time_seg,'season')
    i=imagesc(1:4,1:5,flipud(CIlower_TS3));
elseif strcmp(time_seg,'month')
    i=imagesc(1:12,1:5,flipud(CIlower_TS3));
end

h=colorbar;%('Location','northoutside','AxisLocation','out');
% h.Label.String=['Slope / ' name{3} ' yr^{-1}'];
h.TickDirection='out';
h.TickLength=0.05;

hold on;

ss_array=flipud(logical(h_TS3==90));
ss_array(flipud(CIlower_TS3)==0)=0;

for x=1:4
    for y=1:5
        
        if ss_array(y,x)==1
            vert = 0.5+[x-1 y-1; x y-1; x y; x-1 y]; % x and y vertex coordinates
            fac = [1 2 3 4];              % vertices to connect to make square
            ptch=patch('Faces',fac,'Vertices',vert,'FaceColor','none','LineWidth',0.75);
            htch=hatchfill(ptch, 'cross', 45, 10);
            set(htch, 'Color', 'white')
        end
    end
end
% 
% if strcmp(time_seg,'season')
%     hold on;stipple(1:4,1:100,flipud(logical(h_TS3==90)),'density',100,'markersize',10)
% elseif strcmp(time_seg,'month')
%     hold on;stipple(1:12,1:100,flipud(logical(h_TS3==90)),'density',100,'markersize',10)
% end

if strcmp(time_seg,'season')
    xticks([1 2 3 4])
elseif strcmp(time_seg,'month')
    xticks([1 2 3 4 5 6 7 8 9 10 11 12])
end

if strcmp(time_seg,'season')
    xticklabels({'Winter','Spring','Summer','Autumn'})


elseif strcmp(time_seg,'month')
    xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
end

ylim([0.5 5.5])
yticks([1 :5])
% yticks([1 10:10: 100])
yticklabels({'95','75','50','25','5'})
% yticklabels({'100','90','80','70','60','50','40','30','20','10','0'})
% ylabel('Percentile')
    ax=gca;
    ax.Box='on';
    ax.FontWeight='bold';
    ax.FontSize=fsize;
    ax.XAxis.TickLength = [0 0];    
    ax.XAxis.FontSize = fsize+4;
    ax.CLim=[clims_lcl_ucl(1) clims_lcl_ucl(2)];
%     if strcmp('Pallas',site)
%        ax.CLim=[-2 37];
%     end
set(gca,'TickDir','out');
colormap(s4,cmocean('balance','zero'))

%  h.Position=[0.9111    0.1103    0.0184    0.8148];

if strcmp(time_seg,'season')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
elseif strcmp(time_seg,'month')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
end

title('Accumulation Mode Number')
% 
% s1.Position(4)=s1.Position(4)+0.05;
% s2.Position(4)=s2.Position(4)+0.05;
% s3.Position(4)=s3.Position(4)+0.05;



% ---- reposition subplots (season mode only) ----
if strcmp(time_seg,'season')
    drawnow   % let colorbar auto-resize finish before we override positions

    s1.Position(4)=s1.Position(4)+0.05;
    s2.Position(4)=s2.Position(4)+0.05;
    s3.Position(4)=s3.Position(4)+0.05;
    s4.Position(4)=s4.Position(4)+0.05;

    s1.Position(2)=s1.Position(2)-0.02;
    s2.Position(2)=s2.Position(2)-0.02;
    s3.Position(2)=s3.Position(2)-0.02;
    s4.Position(2)=s4.Position(2)-0.02;

    f1=figtitle_side(['Slope / ' name{3} ' yr^{-1}'],'fontweight','bold');
    f1.Position=[0.925,0.50 0];
    f1=figtitle_side('Percentile','fontweight','bold');
    f1.Position=[0.075,0.50 0];
end
% -------------------------------------------------







%% %% UCL
addpath('C:\Users\pernov\Documents\MATLAB\hfill_vfill\hfill_and_vfill')

figure('units','normalized','outerposition',[0 0 1 1])
% if ~strcmp(site,'Zeppelin')


s1=subplot(4,1,1);

if strcmp(time_seg,'season')
    i=imagesc(1:4,1:5,flipud(CIupper_TS0));
elseif strcmp(time_seg,'month')
    i=imagesc(1:12,1:5,flipud(CIupper_TS0));
end

h=colorbar;%('Location','northoutside','AxisLocation','out');
% h.Label.String=['Slope / ' name{3} ' yr^{-1}'];
h.TickDirection='out';
h.TickLength=0.05;

hold on

ss_array=flipud(logical(h_TS0==90));
ss_array(flipud(CIupper_TS0)==0)=0;

for x=1:4
    for y=1:5
        
        if ss_array(y,x)==1
            vert = 0.5+[x-1 y-1; x y-1; x y; x-1 y]; % x and y vertex coordinates
            fac = [1 2 3 4];              % vertices to connect to make square
            ptch=patch('Faces',fac,'Vertices',vert,'FaceColor','none','LineWidth',1);
            htch=hatchfill(ptch, 'cross', 45, 10);
            set(htch, 'Color', 'white')
        end
    end
end

% 
% if strcmp(time_seg,'season')
%     hold on;stipple(1:4,1:5,flipud(logical(h_TS0==90)),'density',40,'markersize',5)
% elseif strcmp(time_seg,'month')
%     hold on;stipple(1:12,1:5,flipud(logical(h_TS0==90)),'density',100,'markersize',10)
% end


% hold on;stipple(1:4,1:100,flipud(logical(h_TS0==90)),'density',100,'markersize',10)
% hold on;stipple(1:4,1:100,flipud(logical(h_TS0==90)),'density',100,'markersize',10)

if strcmp(time_seg,'season')
    xticks([1 2 3 4])
elseif strcmp(time_seg,'month')
    xticks([1 2 3 4 5 6 7 8 9 10 11 12])
end

% xticks([1 2 3 4])
% xticks([1 2 3 4 5 6 7 8 9 10 11 12])

if strcmp(time_seg,'season')
    % xticklabels({'Winter','Spring','Summer','Autumn'})
    xticklabels('')
elseif strcmp(time_seg,'month')
    xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
end


% xticklabels({'Winter','Spring','Summer','Autumn'})
% xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
ylim([0.5 5.5])
yticks([1 : 5])
% yticks([1 10:10: 100])
yticklabels({'95','75','50','25','5'})
% yticklabels({'100','90','80','70','60','50','40','30','20','10','0'})
% ylabel('Percentile')
    ax=gca;
    ax.Box='on';
    ax.FontWeight='bold';
    ax.FontSize=fsize;
    ax.XAxis.TickLength = [0 0];
set(gca,'TickDir','out');
    ax.CLim=[clims_lcl_ucl(1) clims_lcl_ucl(2)];
%     if strcmp('Pallas',site)
%        
%     end
colormap(s1,cmocean('balance','zero'));

if strcmp(time_seg,'season')
    % text(2.5, -10.5,site,'FontSize',30,'FontWeight','bold','HorizontalAlignment','center')
    text(1, -0.5,site{3},'FontSize',fsize+5,'FontWeight','bold','HorizontalAlignment','center')
elseif strcmp(time_seg,'month')
    text(6.5, -35,site{3},'FontSize',fsize,'FontWeight','bold','HorizontalAlignment','center')
end

% text(2.5, -35,site,'FontSize',25,'FontWeight','bold','HorizontalAlignment','center')
% text(6.5, -35,site,'FontSize',25,'FontWeight','bold','HorizontalAlignment','center')


%  h.Position=[0.9111    0.1103    0.0184    0.8148];
if strcmp(time_seg,'season')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
elseif strcmp(time_seg,'month')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
end


% vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
% vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
title('Total Number')
% end

s2=subplot(4,1,2);

if strcmp(time_seg,'season')
    i=imagesc(1:4,1:5,flipud(CIupper_TS1));
elseif strcmp(time_seg,'month')
    i=imagesc(1:12,1:5,flipud(CIupper_TS1));
end

h=colorbar;%('Location','northoutside','AxisLocation','out');
% h.Label.String=['Slope / ' name{3} ' yr^{-1}'];
h.TickDirection='out';
h.TickLength=0.05;

hold on

ss_array=flipud(logical(h_TS1==90));
ss_array(flipud(CIupper_TS1)==0)=0;

for x=1:4
    for y=1:5
        
        if ss_array(y,x)==1
            vert = 0.5+[x-1 y-1; x y-1; x y; x-1 y]; % x and y vertex coordinates
            fac = [1 2 3 4];              % vertices to connect to make square
            ptch=patch('Faces',fac,'Vertices',vert,'FaceColor','none','LineWidth',0.75);
            htch=hatchfill(ptch, 'cross', 45, 10);
            set(htch, 'Color', 'white')
        end
    end
end

% 
% if strcmp(time_seg,'season')
%     hold on;stipple(1:4,1:5,flipud(logical(h_TS1==90)),'density',40,'markersize',5)
% elseif strcmp(time_seg,'month')
%     hold on;stipple(1:12,1:5,flipud(logical(h_TS1==90)),'density',100,'markersize',10)
% end


% hold on;stipple(1:4,1:100,flipud(logical(h_TS1==90)),'density',100,'markersize',10)
% hold on;stipple(1:4,1:100,flipud(logical(h_TS1==90)),'density',100,'markersize',10)

if strcmp(time_seg,'season')
    xticks([1 2 3 4])
elseif strcmp(time_seg,'month')
    xticks([1 2 3 4 5 6 7 8 9 10 11 12])
end

% xticks([1 2 3 4])
% xticks([1 2 3 4 5 6 7 8 9 10 11 12])

if strcmp(time_seg,'season')
    % xticklabels({'Winter','Spring','Summer','Autumn'})
    xticklabels('')
elseif strcmp(time_seg,'month')
    xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
end


% xticklabels({'Winter','Spring','Summer','Autumn'})
% xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
ylim([0.5 5.5])
yticks([1 : 5])
% yticks([1 10:10: 100])
yticklabels({'95','75','50','25','5'})
% yticklabels({'100','90','80','70','60','50','40','30','20','10','0'})
% ylabel('Percentile')
    ax=gca;
    ax.Box='on';
    ax.FontWeight='bold';
    ax.FontSize=fsize;
    ax.XAxis.TickLength = [0 0];
set(gca,'TickDir','out');
    ax.CLim=[clims_lcl_ucl(1) clims_lcl_ucl(2)];
%     if strcmp('Pallas',site)
%        
%     end
colormap(s2,cmocean('balance','zero'));
% 
% if strcmp(time_seg,'season')
%     % text(2.5, -10.5,site,'FontSize',30,'FontWeight','bold','HorizontalAlignment','center')
%     text(1, -0.5,site,'FontSize',30,'FontWeight','bold','HorizontalAlignment','center')
% elseif strcmp(time_seg,'month')
%     text(6.5, -35,site,'FontSize',30,'FontWeight','bold','HorizontalAlignment','center')
% end

% text(2.5, -35,site,'FontSize',25,'FontWeight','bold','HorizontalAlignment','center')
% text(6.5, -35,site,'FontSize',25,'FontWeight','bold','HorizontalAlignment','center')


%  h.Position=[0.9111    0.1103    0.0184    0.8148];
if strcmp(time_seg,'season')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
elseif strcmp(time_seg,'month')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
end


% vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
% vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
title('Nucleation Mode Number')
% end


s3=subplot(4,1,3);

if strcmp(time_seg,'season')
    i=imagesc(1:4,1:5,flipud(CIupper_TS2));
elseif strcmp(time_seg,'month')
    i=imagesc(1:12,1:5,flipud(CIupper_TS2));
end

cbar=colorbar;%('Location','northoutside','AxisLocation','out');
% cbar.Label.String=['Slope / ' name{3} ' yr^{-1}'];
cbar.TickDirection='out';
cbar.TickLength=0.05;

hold on;

ss_array=flipud(logical(h_TS2==90));
ss_array(flipud(CIupper_TS2)==0)=0;

for x=1:4
    for y=1:5
        
        if ss_array(y,x)==1
            vert = 0.5+[x-1 y-1; x y-1; x y; x-1 y]; % x and y vertex coordinates
            fac = [1 2 3 4];              % vertices to connect to make square
            ptch=patch('Faces',fac,'Vertices',vert,'FaceColor','none','LineWidth',0.75);
            htch=hatchfill(ptch, 'cross', 45, 10);
            set(htch, 'Color', 'white')
        end
    end
end

% if strcmp(time_seg,'season')
%     hold on;stipple(1:4,1:5,flipud(logical(h_TS2==90)),'density',100,'markersize',10)
% elseif strcmp(time_seg,'month')
%     hold on;stipple(1:12,1:5,flipud(logical(h_TS2==90)),'density',100,'markersize',10)
% end

if strcmp(time_seg,'season')
    xticks([1 2 3 4])
elseif strcmp(time_seg,'month')
    xticks([1 2 3 4 5 6 7 8 9 10 11 12])
end

if strcmp(time_seg,'season')
    % xticklabels({'Winter','Spring','Summer','Autumn'})
    xticklabels('')
elseif strcmp(time_seg,'month')
    xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
end

ylim([0.5 5.5])
yticks([1 :5])
% yticks([1 10:10: 100])
yticklabels({'95','75','50','25','5'})
% yticklabels({'100','90','80','70','60','50','40','30','20','10','0'})
% yl=ylabel('Percentile');

    ax=gca;
    ax.Box='on';
    ax.FontWeight='bold';
    ax.FontSize=fsize;    
    ax.XAxis.TickLength = [0 0];
    ax.CLim=[clims_lcl_ucl(1) clims_lcl_ucl(2)];
set(gca,'TickDir','out');
%     if strcmp('Pallas',site)
%        ax.CLim=[-2 37];
%     end
colormap(s3,cmocean('balance','zero'))

%  h.Position=[0.9111    0.1103    0.0184    0.8148];
if strcmp(time_seg,'season')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
elseif strcmp(time_seg,'month')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
end

title('Aitken Mode Number')


s4=subplot(4,1,4);

if strcmp(time_seg,'season')
    i=imagesc(1:4,1:5,flipud(CIupper_TS3));
elseif strcmp(time_seg,'month')
    i=imagesc(1:12,1:5,flipud(CIupper_TS3));
end

h=colorbar;%('Location','northoutside','AxisLocation','out');
% h.Label.String=['Slope / ' name{3} ' yr^{-1}'];
h.TickDirection='out';
h.TickLength=0.05;

hold on;

ss_array=flipud(logical(h_TS3==90));
ss_array(flipud(CIupper_TS3)==0)=0;

for x=1:4
    for y=1:5
        
        if ss_array(y,x)==1
            vert = 0.5+[x-1 y-1; x y-1; x y; x-1 y]; % x and y vertex coordinates
            fac = [1 2 3 4];              % vertices to connect to make square
            ptch=patch('Faces',fac,'Vertices',vert,'FaceColor','none','LineWidth',0.75);
            htch=hatchfill(ptch, 'cross', 45, 10);
            set(htch, 'Color', 'white')
        end
    end
end
% 
% if strcmp(time_seg,'season')
%     hold on;stipple(1:4,1:100,flipud(logical(h_TS3==90)),'density',100,'markersize',10)
% elseif strcmp(time_seg,'month')
%     hold on;stipple(1:12,1:100,flipud(logical(h_TS3==90)),'density',100,'markersize',10)
% end

if strcmp(time_seg,'season')
    xticks([1 2 3 4])
elseif strcmp(time_seg,'month')
    xticks([1 2 3 4 5 6 7 8 9 10 11 12])
end

if strcmp(time_seg,'season')
    xticklabels({'Winter','Spring','Summer','Autumn'})
elseif strcmp(time_seg,'month')
    xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
end

ylim([0.5 5.5])
yticks([1 :5])
% yticks([1 10:10: 100])
yticklabels({'95','75','50','25','5'})
% yticklabels({'100','90','80','70','60','50','40','30','20','10','0'})
% ylabel('Percentile')
    ax=gca;
    ax.Box='on';
    ax.FontWeight='bold';
    ax.FontSize=fsize;
    ax.XAxis.FontSize = fsize+4;
    ax.XAxis.TickLength = [0 0];
    ax.CLim=[clims_lcl_ucl(1) clims_lcl_ucl(2)];
%     if strcmp('Pallas',site)
%        ax.CLim=[-2 37];
%     end
set(gca,'TickDir','out');
colormap(s4,cmocean('balance','zero'))

%  h.Position=[0.9111    0.1103    0.0184    0.8148];

if strcmp(time_seg,'season')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
elseif strcmp(time_seg,'month')
    vfill([0.5 1.5 1.5 2.5 2.5 3.5 3.5 4.5 4.5 5.5 5.5 6.5 6.5 7.5 7.5 8.5 8.5 9.5 9.5 10.5 10.5 11.5 11.5 12.5],'w','facealpha',0,'edgecolor','k','linewidth',1)
end

title('Accumulation Mode Number')
% 
% s1.Position(4)=s1.Position(4)+0.05;
% s2.Position(4)=s2.Position(4)+0.05;
% s3.Position(4)=s3.Position(4)+0.05;



% ---- reposition subplots (season mode only) ----
if strcmp(time_seg,'season')
    drawnow   % let colorbar auto-resize finish before we override positions

    s1.Position(4)=s1.Position(4)+0.05;
    s2.Position(4)=s2.Position(4)+0.05;
    s3.Position(4)=s3.Position(4)+0.05;
    s4.Position(4)=s4.Position(4)+0.05;

    s1.Position(2)=s1.Position(2)-0.02;
    s2.Position(2)=s2.Position(2)-0.02;
    s3.Position(2)=s3.Position(2)-0.02;
    s4.Position(2)=s4.Position(2)-0.02;

    f1=figtitle_side(['Slope / ' name{3} ' yr^{-1}'],'fontweight','bold');
    f1.Position=[0.925,0.50 0];
    f1=figtitle_side('Percentile','fontweight','bold');
    f1.Position=[0.075,0.50 0];
end
% -------------------------------------------------




end