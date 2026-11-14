
function []=Plot_Size_Distribution_daily_for_yearly_average(file,fsize)

sizes=file(1,2:end);
file=array2table(file);
file.(1)=datetime(file.(1),'ConvertFrom','datenum');

file=table2timetable(file(2:end,:));

file_c=retime(file,'daily','count');
file=retime(file,'daily',@med);


    for x=1:size(file_c,1)    
        if min(file_c{x,:})<floor(max(file_c.file2)/2)
            file{x,:}=NaN;
        end
    end
file2=file;
% file(isnan(file.file2),:)=[];

file_doy=findgroups(doy(file.file1));
clim_dg=[];
for x=1:size(file,2)
    clim_dg=[clim_dg splitapply(@med,file{:,x},file_doy)];
end
file1 = clim_dg;


file=[[1:size(file1,1)]' file1];

file=[[0 sizes]; file];

date_time=file(2:end,1);%+datenum(1900,00,00)-1;

sizes=file(1,2:end);

% reading the size distribution data
dN_dlogdp=file(2:end,2:end);

dN_dlogdp_save = dN_dlogdp;

for i=1:size(dN_dlogdp,1) % going through the rows
    for j=1:size(dN_dlogdp,2) % going through the columns
        if dN_dlogdp(i,j)<=0
            dN_dlogdp(i,j)=1e-15;
        else
            dN_dlogdp(i,j)=log10(dN_dlogdp(i,j));
        end
    end
end
dN_dlogdp0 = dN_dlogdp;




% first clearing all figure data to avoid errors
figure('units','normalized','outerposition',[0 0 1 1]);clf;
% then defining orientation of figure when you plot (landscape/portrait)
set(gcf,'paperorientation','portrait')
% then definint paper units if you would like to print your graph
set(gcf,'paperunits','centimeters');
% then setting the size of the paper in your printer
set(gcf,'papertype','a4letter');
% then setting where on the paper you will print (in this case the whole a4
% paper)
set(gcf,'paperposition',[0 0 25 15]);

% the actual plot
pcolor(date_time,sizes,dN_dlogdp')
crameri('davos')
% holding your plot, so that previous entries don't dissapear
hold
% selecting fontsize of your axes, text labels, etc
fontsizes=fsize;
% selecting a smooth interpolation of your color graph (you can remove
% this)
shading interp
% selecting which y-axis sizes should be visible as ticks on the plot
yaxis=[8 9 10 20 30 40 50 60 70 80 90 100 200 300 400 500 ...
     600 700 800 900 1000];
  % selecting the border of the y-axis
set(gca,'ylim',[yaxis(1) yaxis(length(yaxis))])
% the actual ticking
set(gca,'ytick',[yaxis],'yticklabel',{[],[],[10],[],[],[], ...
       [],[],[],[],[],[100],[],[],[], ...
       [],[],[],[],[],[1000]})
  % the same but for x-axis
 xti=eomday(2018,(1:12));
 set(gca,'xticklabelmode','manual')
 set(gca,'xlim',[1 sum(xti)+1])
set(gca,'xtick',[1 cumsum(xti(1:end-1)+1)],'xticklabel',{'Jan' 'Feb' 'Mar' 'Apr' 'May' 'Jun' 'Jul' 'Aug' 'Sep' 'Oct' 'Nov' 'Dec'})
  % setting the fontsize of the axes to "fontsizes"
set(gca,'fontsize',fontsizes);
% making the y-scale logarithmic
set(gca,'yscale','log');
set(gca,'FontWeight','bold');
% writing label on the y-axis
ylabel('Dp / nm','fontsize',fontsizes);
set(gca,'LineWidth',1.25);
% set(gca,'Box','on');
set(gca,'TickDir','out');
% setting the position of the figure inside your printable area, which you
% selected previously with the set(gcf,'paperposition'...) command
set(gca,'position',[0.1 0.11 0.8 0.8])
% setting the colorscale of the number concentration
baraxis=[0 1 2 3];

clim([baraxis(1) baraxis(length(baraxis))]);
% showing the color scale of the number concentration
h=colorbar('vert');
% and the fontsize of the text for the number concentration
set(h,'fontsize',fontsizes)
% setting the axis of the color scale
set(h,'ylim',[baraxis(1) baraxis(length(baraxis))],'ytick',[baraxis])
set(h,'yticklabel',{'1';'10';'100';'1000'})
h.TickDirection='out';
h.TickLength=0.025;
h.Label.String='dN/dlogDp / cm^{-3}';
ax=gca;
ax.XRuler.TickLabelGapOffset = -8;
hold off

end