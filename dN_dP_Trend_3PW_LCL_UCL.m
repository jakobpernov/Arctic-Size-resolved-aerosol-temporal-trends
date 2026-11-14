function [sens,h]=dN_dP_Trend_3PW_LCL_UCL(file,alpha,clims,fsize,ttitle)

N=file;
dndp=N(2:end,:);
sizes=N(1,2:end);
dndp=array2table(dndp);
dndp.(1)=datetime(dndp.(1),'ConvertFrom','datenum');
dndp=table2timetable(dndp);
dndp=retime(dndp,'daily',@med);
dndp(all(isnan(dndp{:,2:end}),2),:)=[];
dndp1=[datenum(dndp.dndp1) dndp{:,1:end}];

for x=2:size(dndp1,2)
    eval(['x' num2str(x-1) '=dndp1(:,[1 ' num2str(x) ']);']);
end


%%

for x=1:size(dndp1,2)-1
    eval(['file=x' num2str(x) ';']);
    eval(['name={''x' num2str(x) '''};']);
    time_seg='month';
    res='daily';
    file=array2table(file);
    file.(1)=datetime(file.(1),'ConvertFrom','datenum');
    file.Properties.VariableNames={'Time','param'};
    file=table2timetable(file);

    file_c=retime(file,res,'count');
    file=retime(file,res,@med);

    for xx=1:size(file_c,1)    
        if max(file_c.param(xx))<floor(max(file_c.param)/2)
            file.param(xx)=NaN;
        end
    end
    file(isnan(file.param),:)=[];
    file.(1)=round(file.(1),3);
    data1=[];
    if strcmp(time_seg,'month')==1
            jan=file(file.Time.Month==1,:);
            feb=file(file.Time.Month==2,:);
            mar=file(file.Time.Month==3,:);
            apr=file(file.Time.Month==4,:);
            may=file(file.Time.Month==5,:);
            jun=file(file.Time.Month==6,:);
            jul=file(file.Time.Month==7,:);
            aug=file(file.Time.Month==8,:);
            sep=file(file.Time.Month==9,:);
            oct=file(file.Time.Month==10,:);
            nov=file(file.Time.Month==11,:);
            dec=file(file.Time.Month==12,:);

            data1(1).obs=jan;
            data1(2).obs=feb;
            data1(3).obs=mar;
            data1(4).obs=apr;
            data1(5).obs=may;
            data1(6).obs=jun;
            data1(7).obs=jul;
            data1(8).obs=aug;
            data1(9).obs=sep;
            data1(10).obs=oct;
            data1(11).obs=nov;
            data1(12).obs=dec;

    elseif strcmp(time_seg,'season')==1
            file_djf=file(file.Time.Month==12 ...
                        | file.Time.Month==1 ...
                        | file.Time.Month==2,:);
            file_mam=file(file.Time.Month==3 ...
                        | file.Time.Month==4 ...
                        | file.Time.Month==5,:);
            file_jja=file(file.Time.Month==6 ...
                        | file.Time.Month==7 ...
                        | file.Time.Month==8,:);
            file_son=file(file.Time.Month==9 ...
                        | file.Time.Month==10 ...
                        | file.Time.Month==11,:);

            data1(1).obs=file_djf;
            data1(2).obs=file_mam;
            data1(3).obs=file_jja;
            data1(4).obs=file_son;
    end
    resolution=0.001;
    alpha=alpha;
    result=MK_tempAggr(data1,resolution,'PW_method','3PW','alpha_MK',alpha,'alpha_ak',95, 'alpha_CL',95, 'alpha_Xhomo',90);
    eval([name{1} '_3PW=result;']);
end

sens=NaN(12,size(dndp1,2)-1);
h=   NaN(12,size(dndp1,2)-1);
statsig=   NaN(12,size(dndp1,2)-1);
lcl= NaN(12,size(dndp1,2)-1);
ucl= NaN(12,size(dndp1,2)-1);


for x=1:size(dndp1,2)-1
    eval(['f=[x' num2str(x) '_3PW.slope];'])
    sens(:,x)=f(1,1:12)';
    
    eval(['f1=[x' num2str(x) '_3PW.ss];'])
    h(:,x)=f1(1,1:12)';    
    
    eval(['f11=[x' num2str(x) '_3PW.P];'])
    statsig(:,x)=f11(1,1:12)';
    
    eval(['f2=[x' num2str(x) '_3PW.LCL];'])
    lcl(:,x)=f2(1,1:12)';    
    
    eval(['f3=[x' num2str(x) '_3PW.UCL];'])
    ucl(:,x)=f3(1,1:12)';
end

hh=statsig;
hh(hh>0.1)=0;
hh(hh<0.05)=1;
hh(hh<0.1)=0.5;

h(h~=alpha)=0;
h(h==alpha)=1;
h(sens==0)=0;
sens=[sens; sens(1,:)];
lcl= [lcl; lcl(1,:)];
ucl= [ucl; ucl(1,:)];
h=[h;h(1,:)];
statsig=[statsig;statsig(1,:)];

%%
figure('units','normalized','outerposition',[0 0 1 1])
contourf((1:13),sizes,movmean(sens,1)',11,'LineWidth',1.25)
hold on
% contour((1:13),sizes,(statsig<0.05)',1,'Color','k','LineStyle','-','LineWidth',2)
contour((1:13),sizes,logical(h==1)',1,'Color','k','LineStyle','-','LineWidth',3)
ax=gca;
ax.YScale='Log';
shading interp

ax.XTick=(1:12);
ax.XTickLabel={'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
ax.YLabel.String='Dp / nm';
ax.YLim=[5 1000];
ax.YTick=([10 100 1000]);
ax.XLim=[1 13];
ax.YTickLabel={'10','100','1000'};
ax.FontSize=fsize;
ax.FontWeight='bold';
ax.LineWidth=1.25;
ax.Box='on';
ax.XGrid='on';
ax.YGrid='on';
ax.YMinorGrid='on';
set(gca,'TickDir','out');

c=colorbar;
c.Label.String='dN/dlogDp (cm^{-3}) yr^{-1}';
c.TickDirection='out';
c.TickLength=0.025;
ax.CLim=[clims(1) clims(2)];
[X_grid, Y_grid] = meshgrid((1:13),sizes);
stipple(X_grid, Y_grid,(h==1)','density',250,'color','k','marker','.','markersize',12)
title(ttitle{1})
cmocean('balance',50,'Pivot','zero')


%%

figure('units','normalized','outerposition',[0 0 1 1])
contourf((1:13),sizes,movmean(lcl,1)',11,'LineWidth',1.25)
hold on
contour((1:13),sizes,h',1,'Color','k','LineStyle','-','LineWidth',3)
ax=gca;
ax.YScale='Log';
shading interp

ax.XTick=(1:12);
ax.XTickLabel={'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
ax.YLabel.String='Dp / nm';
ax.YLim=[5 1000];
ax.YTick=([10 100 1000]);
ax.XLim=[1 13];
ax.YTickLabel={'10','100','1000'};
ax.FontSize=fsize;
ax.FontWeight='bold';
ax.LineWidth=1.25;
ax.Box='on';
ax.XGrid='on';
ax.YGrid='on';
ax.YMinorGrid='on';
set(gca,'TickDir','out');

c=colorbar;
c.Label.String='dN/dlogDp (cm^{-3}) yr^{-1}';
c.TickDirection='out';
c.TickLength=0.025;
stipple(X_grid, Y_grid,(h==1)','density',250,'color','k','marker','.','markersize',12)
cmocean('balance',50,'Pivot','zero')
title([ttitle{2} ' Lower Confidence Level'])

figure('units','normalized','outerposition',[0 0 1 1])
contourf((1:13),sizes,movmean(ucl,1)',11,'LineWidth',1.25)
hold on
contour((1:13),sizes,h',1,'Color','k','LineStyle','-','LineWidth',3)
ax=gca;
ax.YScale='Log';
shading interp

ax.XTick=(1:12);
ax.XTickLabel={'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
ax.YLabel.String='Dp / nm';
ax.YLim=[5 1000];
ax.YTick=([10 100 1000]);
ax.XLim=[1 13];
ax.YTickLabel={'10','100','1000'};
ax.FontSize=fsize;
ax.FontWeight='bold';
ax.LineWidth=1.25;
ax.Box='on';
ax.XGrid='on';
ax.YGrid='on';
ax.YMinorGrid='on';
set(gca,'TickDir','out');

c=colorbar;
c.Label.String='dN/dlogDp (cm^{-3}) yr^{-1}';
c.TickDirection='out';
c.TickLength=0.025;

stipple(X_grid, Y_grid,(h==1)','density',250,'color','k','marker','.','markersize',12)
title([ttitle{3} ' Upper Confidence Level'])
cmocean('balance',50,'Pivot','zero')
end

