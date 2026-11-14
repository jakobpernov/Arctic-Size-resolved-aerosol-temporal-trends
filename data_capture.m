function data_capture(data,res,site,fsize)

data=array2table(data(2:end,:));
data.(1)=datetime(data.(1),'ConvertFrom','datenum');
data=table2timetable(data);
data=retime(data,'hourly','mean');
smps_c=retime(data,res,'count');

disp([num2str(round(sum(any(~isnan(data{:,1:end}),2))./length(data{:,1})*100,2)) ' % Total Data Coverage at ' site])

disp([num2str(round(sum(any(~isnan(data{data.Var1(month(data.Var1)==12 | month(data.Var1)==1 | month(data.Var1)==2),1:end}),2))./length(data{data.Var1(month(data.Var1)==12 | month(data.Var1)==1 | month(data.Var1)==2),1})*100,2)) ' % Winter Data Coverage at ' site])

disp([num2str(round(sum(any(~isnan(data{data.Var1(month(data.Var1)==3 | month(data.Var1)==4 | month(data.Var1)==5),1:end}),2))./length(data{data.Var1(month(data.Var1)==3 | month(data.Var1)==4 | month(data.Var1)==5),1})*100,2)) ' % Spring Data Coverage at ' site])

disp([num2str(round(sum(any(~isnan(data{data.Var1(month(data.Var1)==6 | month(data.Var1)==7 | month(data.Var1)==8),1:end}),2))./length(data{data.Var1(month(data.Var1)==6 | month(data.Var1)==7 | month(data.Var1)==8),1})*100,2)) ' % Summer Data Coverage at ' site])

disp([num2str(round(sum(any(~isnan(data{data.Var1(month(data.Var1)==9 | month(data.Var1)==10 | month(data.Var1)==11),1:end}),2))./length(data{data.Var1(month(data.Var1)==9 | month(data.Var1)==10 | month(data.Var1)==11),1})*100,2)) ' % Autumn Data Coverage at ' site])

smps_c.season(:)=NaN;
smps_c.season(smps_c.Var1(month(smps_c.Var1)==12 | month(smps_c.Var1)==1 | month(smps_c.Var1)==2))=1;
smps_c.season(smps_c.Var1(month(smps_c.Var1)==3 | month(smps_c.Var1)==4 | month(smps_c.Var1)==5))=2;
smps_c.season(smps_c.Var1(month(smps_c.Var1)==6 | month(smps_c.Var1)==7 | month(smps_c.Var1)==8))=3;
smps_c.season(smps_c.Var1(month(smps_c.Var1)==9 | month(smps_c.Var1)==10 | month(smps_c.Var1)==11))=4;


if strcmp(res,'yearly')
   maxLimit=duration((31*24*12),0,0)/unique(diff(data.Var1));
elseif strcmp(res,'monthly')
    maxLimit=duration((31*24),0,0)/unique(diff(data.Var1));
end

figure('units','normalized','outerposition',[0 0 0.9 0.9])

b=bar(smps_c.Var1,max(smps_c{1:end,1:end-1},[],2)./maxLimit*100,0.9);

for x=1:height(smps_c)
    if smps_c.season(x)==1
       b.FaceColor='flat';
       b.CData(x,:)=[0 0 0];
    elseif smps_c.season(x)==2
       b.FaceColor='flat';
       b.CData(x,:)=[0     0.80392         0.4];
    elseif smps_c.season(x)==3
       b.FaceColor='flat';
       b.CData(x,:)=[0.11765     0.56471           1];
       
    elseif smps_c.season(x)==4
       b.FaceColor='flat';
       b.CData(x,:)=[1     0.72549    0.058824];
    end   
end


ylabel('Data Coverage / %')
        ax=gca;
        ax.Box='on';
        ax.LineWidth=1.25;
        ax.FontSize = fsize;
        ax.FontWeight='bold';
        ax.XGrid='on';
        ax.YGrid='on';
        xlim([datetime(2010,1,1) datetime(2021,1,1)])
        xticks([datetime(2010,1,1) datetime(2011,1,1) datetime(2012,1,1) datetime(2013,1,1)  datetime(2014,1,1) ...
                datetime(2015,1,1) datetime(2016,1,1) datetime(2017,1,1) datetime(2018,1,1)  datetime(2019,1,1) datetime(2020,1,1)])
        ylim([0 100])
         title(site)
ax.TitleHorizontalAlignment = 'left';
 text(((datetime(2021,1,1)-datetime(2010,1,1))/2)+datetime(2010,1,1),105,{'\color[rgb]{0,0,0} Winter \color[rgb]{0,0.80392,0.4} Spring \color[rgb]{0.11765,0.56471,1} Summer \color[rgb]{1,0.72549,0.058824} Autumn'}...
     ,'FontSize',fsize,'FontWeight','bold','HorizontalAlignment','center')
end