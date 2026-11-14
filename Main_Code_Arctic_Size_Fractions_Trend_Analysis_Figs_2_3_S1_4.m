%% Initialization
addpath(genpath('C:\Users\pernov\Documents\Trend Analysis\Arctic Stations\For Github'))

% Define size ranges
nuc_lower=10;
nuc_upper=25;

aik_lower=25;
aik_upper=100;

acc_lower=100;
acc_upper=360;

% Define temporal resolution
resolution='monthly';
if strcmp(resolution,'daily')
    lwidth=2;
else
    lwidth=4;
end

% Define alpha for SS
alpha=90;
%% load Data VIllum and Calculate size fractions

load Villum_SMPS_2010_2018_QCed.mat
load Villum_SMPS_reinv360_2018_2020_QCed.mat
SMPS_all=[SMPS_all(:,[1 3:57]);SMPS_reinv360_QCed(2:end,:)];
SMPS_all(find(SMPS_all(:,1)>datenum(2020,12,31)):end,:)=[];

vrs_sizes=SMPS_all(1,2:end);

% Fig 2 left panels
Plot_Size_Distribution_daily_for_yearly_average(SMPS_all,35);
yline([nuc_lower aik_lower acc_lower],"--w",{'Nucleation','Aitken','Accumulation'},'LineWidth',2,'FontSize',25)
yline(acc_upper,"--w",'LineWidth',2)

title('(c) Villum PNSD')

% Fig 3
[vrs_sens,vrs_h]=dN_dP_Trend_3PW_LCL_UCL(SMPS_all,alpha,[-10 10],35,{'(b) Villum','(c) Villum','(d) Villum'});

vrs_sf=[SMPS_all(2:end,1) sum_conc_JBP('name',SMPS_all,nuc_lower,acc_upper) sum_conc_JBP('name',SMPS_all,nuc_lower,aik_lower) sum_conc_JBP('name',SMPS_all,aik_lower,aik_upper) sum_conc_JBP('name',SMPS_all,acc_lower,acc_upper)];
vrs_sf(vrs_sf(:,2)==0,2:5)=NaN;
vrs_sf(vrs_sf(:,2)<0.001,2:4)=NaN;
vrs_sf(vrs_sf(:,3)<0.001,2:4)=NaN;
vrs_sf(vrs_sf(:,4)<0.001,2:4)=NaN;
vrs_sf(vrs_sf(:,5)<0.001,2:4)=NaN;
vrs_sf=array2table(vrs_sf);
vrs_sf.(1)=datetime(vrs_sf.(1),'ConvertFrom','datenum');
vrs_sf.Properties.VariableNames={'date','num_tot','num_nuc','num_aik','num_acc'};
vrs_sf=table2timetable(vrs_sf);

%% Data Capture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fig S2
data_capture([datenum(vrs_sf.date) vrs_sf.num_acc],resolution,'(b) Villum',35)
xline(datetime(2018,5,1),'LineWidth',3,'Color','r')

%% Percentile Slopes
% Fig S3
[vrs_sf_Slope,vrs1,vrs2,vrs3,vrs4]=decile_slopes_PanArctic_SizeFractions(vrs_sf,{'(b) Villum','(c) Villum LCL','(d) Villum UCL'},'season',[-6 15],22);

%% Load NYA data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('C:\Users\pernov\Documents\Trend Analysis\Arctic Stations\New Ebas Data\Zeppelin')
dataDir = "C:\Users\pernov\Documents\Trend Analysis\Arctic Stations\New Ebas Data\Zeppelin"; 
ext = '*.nas'; % Change to *.m or any extension

% Get files and extract names into a cell array
files = dir(fullfile(dataDir, ext));
fileNames = {files.name};

all_rows = [];
dp = [];

for i = 1:numel(files)
    d = read_EBAS_NasaAmes(fileNames{i});
    
    if isempty(dp)
        dp = d.dp;  % grab dp from first file
    else
        % Optional safety check
        if ~isequal(dp, d.dp)
            warning('File %d has different dp bins! Skipping.', i);
            continue
        end
    end
    
    all_rows = [all_rows; datenum(d.time_start) d.dNdlogDp d.flags];
end

unique(all_rows(:,end))

all_rows(all_rows(:,end)==0.999,2:end-1)=NaN;

all_rows = sortrows(all_rows, 1);
nya_all = [[0 dp]; all_rows(:,1:end-1)];
nya_all(:,1) = round(nya_all(:,1) * 24) / 24;
nya_sizes=nya_all(1,2:44);

% Calculating the number concentration in the different size fractions
nya_sf=[nya_all(2:end,1) sum_conc_JBP('name',nya_all,nuc_lower,acc_upper) sum_conc_JBP('name',nya_all,nuc_lower,nuc_upper) sum_conc_JBP('name',nya_all,aik_lower,aik_upper) sum_conc_JBP('name',nya_all,acc_lower,acc_upper)];
% Setting zeros to NaNs
nya_sf(nya_sf(:,2)==0,2:5)=NaN;

% Convert to table, assign datetimes and names, and convert to timetable
nya_sf=array2table(nya_sf);
nya_sf.(1)=datetime(nya_sf.(1),'ConvertFrom','datenum');
nya_sf.Properties.VariableNames={'date','num_tot','num_nuc','num_aik','num_acc'};
nya_sf=table2timetable(nya_sf);

Plot_Size_Distribution_daily_for_yearly_average(nya_all,35);
title('(e) Zeppelin PNSD')

yline([nuc_lower aik_lower acc_lower],"--w",{'Nucleation','Aitken','Accumulation'},'LineWidth',2,'FontSize',25)
yline(acc_upper,"--w",'LineWidth',2)

[nya_sens,nya_h]=dN_dP_Trend_3PW_LCL_UCL(nya_all,alpha,[-10 10],35,{'(c) Zeppelin','(e) Zeppelin','(f) Zeppelin'});

data_capture(nya_all,resolution,'(c) Zeppelin',35)

%% Percentile Slopes

[nya_sf_Slope,zs1,zs2,zs3,zs4]=decile_slopes_PanArctic_SizeFractions(nya_sf,{'(c) Zeppelin','(e) Zeppelin LCL','(f) Zeppelin UCL'},'season',[-3 3],22);

%% Pallas
addpath('C:\Users\pernov\Documents\Trend Analysis\Arctic Stations\Pallas')
addpath('C:\Users\pernov\Documents\Trend Analysis\Arctic Stations\Pallas\Ebas_220306_1653')
addpath('C:\Users\pernov\Documents\Trend Analysis\Arctic Stations\Pallas\Ebas_220306_1735')
load Pallas_Sizes10_12.mat

format long

% Import Data from EBAS files for each year
pallas_2010=Pallas_PNSD_EBAS_import('FI0096G.20100113160000.20170830072521.dmps.particle_number_size_distribution.aerosol.12mo.1h.FI01L_FMI_DMPS_25.FI01L_dmps.lev2.nas',[143 inf]);
pallas_2010=table2array(pallas_2010);
pallas_2010=pallas_2010(:,[1 3:3:end]);
dn_2010=pallas_2010(:,1)+1;
dn_2010=doy2date(dn_2010,ones(size(dn_2010,1),size(dn_2010,2))*2010);
pallas_2010(:,1)=dn_2010;
pallas_2010=[[0 Pallas_Sizes10_12 0];pallas_2010];
unique(pallas_2010(:,end))

pallas_2010_no_cloud=pallas_2010;
    pallas_2010_no_cloud(pallas_2010_no_cloud(:,end)==0.390676000000000,2:end-1)=NaN;
    pallas_2010_no_cloud(pallas_2010_no_cloud(:,end)==0.392676000000000,2:end-1)=NaN;
    pallas_2010_no_cloud(pallas_2010_no_cloud(:,end)==0.394676000000000,2:end-1)=NaN;
    pallas_2010_no_cloud(pallas_2010_no_cloud(:,end)==0.675676000000000,2:end-1)=NaN;
    pallas_2010_no_cloud(pallas_2010_no_cloud(:,end)==0.676000000000000,2:end-1)=NaN;


pallas_2011=Pallas_PNSD_EBAS_import('FI0096G.20110101000000.20170830072521.dmps.particle_number_size_distribution.aerosol.1y.1h.FI01L_FMI_DMPS_25.FI01L_dmps.lev2.nas',[143 inf]);
pallas_2011=table2array(pallas_2011);
pallas_2011=pallas_2011(:,[1 3:3:end]);
dn_2011=pallas_2011(:,1)+1;
dn_2011=doy2date(dn_2011,ones(size(dn_2011,1),size(dn_2011,2))*2011);
pallas_2011(:,1)=dn_2011;
pallas_2011=[[0 Pallas_Sizes10_12 0];pallas_2011];
unique(pallas_2011(:,end))

pallas_2011_no_cloud=pallas_2011;
    pallas_2011_no_cloud(pallas_2011_no_cloud(:,end)==0.390676000000000,2:end-1)=NaN;
    pallas_2011_no_cloud(pallas_2011_no_cloud(:,end)==0.392676000000000,2:end-1)=NaN;
    pallas_2011_no_cloud(pallas_2011_no_cloud(:,end)==0.392675676000000,2:end-1)=NaN;
    pallas_2011_no_cloud(pallas_2011_no_cloud(:,end)==0.394676000000000,2:end-1)=NaN;
    pallas_2011_no_cloud(pallas_2011_no_cloud(:,end)==0.394675676000000,2:end-1)=NaN;
    pallas_2011_no_cloud(pallas_2011_no_cloud(:,end)==0.675676000000000,2:end-1)=NaN;
    pallas_2011_no_cloud(pallas_2011_no_cloud(:,end)==0.676000000000000,2:end-1)=NaN;

load Pallas_Sizes13_18.mat
pallas_2012=Pallas_PNSD_EBAS_import2012new('FI0096G.20120101000000.20220222000000.dmps.particle_number_size_distribution.pm10.1y.1h.FI01L_FMI_DMPS_25_pm10.FI01L_dmps.lev2.nas',[165 inf]);
pallas_2012=table2array(pallas_2012);
pallas_2012=pallas_2012(:,[1 3:3:end]);
dn_2012=pallas_2012(:,1)+1;
dn_2012=doy2date(dn_2012,ones(size(dn_2012,1),size(dn_2012,2))*2012);
pallas_2012(:,1)=dn_2012;
pallas_2012=[[0 Pallas_Sizes13_18 0];pallas_2012];
unique(pallas_2012(:,end))
pallas_2012(pallas_2012(:,end)==0.390999000000000,2:end-1)=NaN;
pallas_2012(pallas_2012(:,end)==0.999000000000000,2:end-1)=NaN;

pallas_2012_no_cloud=pallas_2012;
    pallas_2012_no_cloud(pallas_2012_no_cloud(:,end)==0.390676000000000,2:end-1)=NaN;
    pallas_2012_no_cloud(pallas_2012_no_cloud(:,end)==0.392676000000000,2:end-1)=NaN;
    pallas_2012_no_cloud(pallas_2012_no_cloud(:,end)==0.392675676000000,2:end-1)=NaN;
    pallas_2012_no_cloud(pallas_2012_no_cloud(:,end)==0.394676000000000,2:end-1)=NaN;
    pallas_2012_no_cloud(pallas_2012_no_cloud(:,end)==0.394675676000000,2:end-1)=NaN;
    pallas_2012_no_cloud(pallas_2012_no_cloud(:,end)==0.675676000000000,2:end-1)=NaN;
    pallas_2012_no_cloud(pallas_2012_no_cloud(:,end)==0.676000000000000,2:end-1)=NaN;


pallas_2013=Pallas_PNSD_EBAS_import2013('FI0096G.20130101000000.20150519000000.dmps.particle_number_size_distribution.aerosol.1y.1h.FI01L_FMI_DMPS_25_NILU.FI01L_dmps.lev2.nas',[166 inf]);
pallas_2013=table2array(pallas_2013);
pallas_2013=pallas_2013(:,[1 3:3:end]);
dn_2013=pallas_2013(:,1)+1;
dn_2013=doy2date(dn_2013,ones(size(dn_2013,1),size(dn_2013,2))*2013);
pallas_2013(:,1)=dn_2013;
pallas_2013=[[0 Pallas_Sizes13_18 0];pallas_2013];
unique(pallas_2013(:,end))
pallas_2013_no_cloud=pallas_2013;
    pallas_2013_no_cloud(pallas_2013_no_cloud(:,end)==0.390676000000000,2:end-1)=NaN;
    pallas_2013_no_cloud(pallas_2013_no_cloud(:,end)==0.392676000000000,2:end-1)=NaN;
    pallas_2013_no_cloud(pallas_2013_no_cloud(:,end)==0.392675676000000,2:end-1)=NaN;
    pallas_2013_no_cloud(pallas_2013_no_cloud(:,end)==0.394676000000000,2:end-1)=NaN;
    pallas_2013_no_cloud(pallas_2013_no_cloud(:,end)==0.394675676000000,2:end-1)=NaN;
    pallas_2013_no_cloud(pallas_2013_no_cloud(:,end)==0.675676000000000,2:end-1)=NaN;
    pallas_2013_no_cloud(pallas_2013_no_cloud(:,end)==0.676000000000000,2:end-1)=NaN;


pallas_2014=Pallas_PNSD_EBAS_import2013('FI0096G.20140116220000.20150519000000.dmps.particle_number_size_distribution.aerosol.11mo.1h.FI01L_FMI_DMPS_25_NILU.FI01L_dmps.lev2.nas',[166 inf]);
pallas_2014=table2array(pallas_2014);
pallas_2014=pallas_2014(:,[1 3:3:end]);
dn_2014=pallas_2014(:,1)+1;
dn_2014=doy2date(dn_2014,ones(size(dn_2014,1),size(dn_2014,2))*2014);
pallas_2014(:,1)=dn_2014;
pallas_2014=[[0 Pallas_Sizes13_18 0];pallas_2014];
unique(pallas_2014(:,end))
pallas_2014_no_cloud=pallas_2014;
    pallas_2014_no_cloud(pallas_2014_no_cloud(:,end)==0.390676000000000,2:end-1)=NaN;
    pallas_2014_no_cloud(pallas_2014_no_cloud(:,end)==0.392676000000000,2:end-1)=NaN;
    pallas_2014_no_cloud(pallas_2014_no_cloud(:,end)==0.392675676000000,2:end-1)=NaN;
    pallas_2014_no_cloud(pallas_2014_no_cloud(:,end)==0.394676000000000,2:end-1)=NaN;
    pallas_2014_no_cloud(pallas_2014_no_cloud(:,end)==0.394675676000000,2:end-1)=NaN;
    pallas_2014_no_cloud(pallas_2014_no_cloud(:,end)==0.675676000000000,2:end-1)=NaN;
    pallas_2014_no_cloud(pallas_2014_no_cloud(:,end)==0.676000000000000,2:end-1)=NaN;


pallas_2015=Pallas_PNSD_EBAS_import2013('FI0096G.20150101000000.20160628000000.dmps.particle_number_size_distribution.aerosol.1y.1h.FI01L_FMI_DMPS_25.FI01L_dmps.lev2.nas',[166 inf]);
pallas_2015=table2array(pallas_2015);
pallas_2015=pallas_2015(:,[1 3:3:end]);
dn_2015=pallas_2015(:,1)+1;
dn_2015=doy2date(dn_2015,ones(size(dn_2015,1),size(dn_2015,2))*2015);
pallas_2015(:,1)=dn_2015;
pallas_2015=[[0 Pallas_Sizes13_18 0];pallas_2015];
unique(pallas_2015(:,end))
pallas_2015_no_cloud=pallas_2015;
    pallas_2015_no_cloud(pallas_2015_no_cloud(:,end)==0.390676000000000,2:end-1)=NaN;
    pallas_2015_no_cloud(pallas_2015_no_cloud(:,end)==0.392676000000000,2:end-1)=NaN;
    pallas_2015_no_cloud(pallas_2015_no_cloud(:,end)==0.392675676000000,2:end-1)=NaN;
    pallas_2015_no_cloud(pallas_2015_no_cloud(:,end)==0.394676000000000,2:end-1)=NaN;
    pallas_2015_no_cloud(pallas_2015_no_cloud(:,end)==0.394675676000000,2:end-1)=NaN;
    pallas_2015_no_cloud(pallas_2015_no_cloud(:,end)==0.675676000000000,2:end-1)=NaN;
    pallas_2015_no_cloud(pallas_2015_no_cloud(:,end)==0.676000000000000,2:end-1)=NaN;
    pallas_2015_no_cloud(pallas_2015_no_cloud(:,end)==0.999999999999999,2:end-1)=NaN;


pallas_2016=Pallas_PNSD_EBAS_import2013('FI0096G.20160203000000.20191101114105.dmps.particle_number_size_distribution.aerosol.11mo.1h.FI01L_FMI_DMPS_25.FI01L_dmps.lev2.nas',[166 inf]);
pallas_2016=table2array(pallas_2016);
pallas_2016=pallas_2016(:,[1 3:3:end]);
dn_2016=pallas_2016(:,1)+1;
dn_2016=doy2date(dn_2016,ones(size(dn_2016,1),size(dn_2016,2))*2016);
pallas_2016(:,1)=dn_2016;
pallas_2016=[[0 Pallas_Sizes13_18 0];pallas_2016];
unique(pallas_2016(:,end))
pallas_2016(pallas_2016(:,end)>0.999,2:end-1)=NaN;
pallas_2016_no_cloud=pallas_2016;
    pallas_2016_no_cloud(pallas_2016_no_cloud(:,end)==0.390676000000000,2:end-1)=NaN;
    pallas_2016_no_cloud(pallas_2016_no_cloud(:,end)==0.392676000000000,2:end-1)=NaN;
    pallas_2016_no_cloud(pallas_2016_no_cloud(:,end)==0.392675676000000,2:end-1)=NaN;
    pallas_2016_no_cloud(pallas_2016_no_cloud(:,end)==0.394676000000000,2:end-1)=NaN;
    pallas_2016_no_cloud(pallas_2016_no_cloud(:,end)==0.394675676000000,2:end-1)=NaN;
    pallas_2016_no_cloud(pallas_2016_no_cloud(:,end)==0.675676000000000,2:end-1)=NaN;
    pallas_2016_no_cloud(pallas_2016_no_cloud(:,end)==0.676000000000000,2:end-1)=NaN;


pallas_2017=Pallas_PNSD_EBAS_import2013('FI0096G.20170101000000.20191101114105.dmps.particle_number_size_distribution.aerosol.1y.1h.FI01L_FMI_DMPS_25.FI01L_dmps.lev2.nas',[166 inf]);
pallas_2017=table2array(pallas_2017);
pallas_2017=pallas_2017(:,[1 3:3:end]);
dn_2017=pallas_2017(:,1)+1;
dn_2017=doy2date(dn_2017,ones(size(dn_2017,1),size(dn_2017,2))*2017);
pallas_2017(:,1)=dn_2017;
pallas_2017=[[0 Pallas_Sizes13_18 0];pallas_2017];
unique(pallas_2017(:,end))
pallas_2017(pallas_2017(:,end)==0.999000000000000,2:end-1)=NaN;
pallas_2017_no_cloud=pallas_2017;
    pallas_2017_no_cloud(pallas_2017_no_cloud(:,end)==0.390675676999000,2:end-1)=NaN;
    pallas_2017_no_cloud(pallas_2017_no_cloud(:,end)==0.390675999000000,2:end-1)=NaN;
    pallas_2017_no_cloud(pallas_2017_no_cloud(:,end)==0.390676999000000,2:end-1)=NaN;
    pallas_2017_no_cloud(pallas_2017_no_cloud(:,end)==0.390999000000000,2:end-1)=NaN;
    pallas_2017_no_cloud(pallas_2017_no_cloud(:,end)==0.390676000000000,2:end-1)=NaN;
    pallas_2017_no_cloud(pallas_2017_no_cloud(:,end)==0.392676000000000,2:end-1)=NaN;
    pallas_2017_no_cloud(pallas_2017_no_cloud(:,end)==0.392675676000000,2:end-1)=NaN;
    pallas_2017_no_cloud(pallas_2017_no_cloud(:,end)==0.394676000000000,2:end-1)=NaN;
    pallas_2017_no_cloud(pallas_2017_no_cloud(:,end)==0.394675676000000,2:end-1)=NaN;
    pallas_2017_no_cloud(pallas_2017_no_cloud(:,end)==0.675676000000000,2:end-1)=NaN;
    pallas_2017_no_cloud(pallas_2017_no_cloud(:,end)==0.676000000000000,2:end-1)=NaN;


pallas_2018=Pallas_PNSD_EBAS_import2013('FI0096G.20180101000000.20190628000000.dmps.particle_number_size_distribution.aerosol.1y.1h.FI01L_FMI_DMPS_25.FI01L_dmps.lev2.nas',[166 inf]);
pallas_2018=table2array(pallas_2018);
pallas_2018=pallas_2018(:,[1 3:3:end]);
dn_2018=pallas_2018(:,1)+1;
dn_2018=doy2date(dn_2018,ones(size(dn_2018,1),size(dn_2018,2))*2018);
pallas_2018(:,1)=dn_2018;
pallas_2018=[[0 Pallas_Sizes13_18 0];pallas_2018];
unique(pallas_2018(:,end))
pallas_2018(pallas_2018(:,end)>0.999,2:end-1)=NaN;
pallas_2018_no_cloud=pallas_2018;
    pallas_2018_no_cloud(pallas_2018_no_cloud(:,end)==0.390676000000000,2:end-1)=NaN;
    pallas_2018_no_cloud(pallas_2018_no_cloud(:,end)==0.392676000000000,2:end-1)=NaN;
    pallas_2018_no_cloud(pallas_2018_no_cloud(:,end)==0.392675676000000,2:end-1)=NaN;
    pallas_2018_no_cloud(pallas_2018_no_cloud(:,end)==0.394676000000000,2:end-1)=NaN;
    pallas_2018_no_cloud(pallas_2018_no_cloud(:,end)==0.394675676000000,2:end-1)=NaN;
    pallas_2018_no_cloud(pallas_2018_no_cloud(:,end)==0.675676000000000,2:end-1)=NaN;
    pallas_2018_no_cloud(pallas_2018_no_cloud(:,end)==0.676000000000000,2:end-1)=NaN;


pallas_2019=Pallas_PNSD_EBAS_import2013('FI0096G.20190101000000.20200514000000.dmps.particle_number_size_distribution.pm10.1y.1h.FI01L_FMI_DMPS_25_pm10.FI01L_dmps.lev2.nas',[166 inf]);
pallas_2019=table2array(pallas_2019);
pallas_2019=pallas_2019(:,[1 3:3:end]);
dn_2019=pallas_2019(:,1)+1;
dn_2019=doy2date(dn_2019,ones(size(dn_2019,1),size(dn_2019,2))*2019);
pallas_2019(:,1)=dn_2019;
pallas_2019=[[0 Pallas_Sizes13_18 0];pallas_2019];
unique(pallas_2019(:,end))
pallas_2019(pallas_2019(:,end)>0.999,2:end-1)=NaN;
pallas_2019(pallas_2019(:,end)==0.390999000000000,2:end-1)=NaN;
pallas_2019_no_cloud=pallas_2019;
    pallas_2019_no_cloud(pallas_2019_no_cloud(:,end)==0.390676000000000,2:end-1)=NaN;
    pallas_2019_no_cloud(pallas_2019_no_cloud(:,end)==0.392676000000000,2:end-1)=NaN;
    pallas_2019_no_cloud(pallas_2019_no_cloud(:,end)==0.392675676000000,2:end-1)=NaN;
    pallas_2019_no_cloud(pallas_2019_no_cloud(:,end)==0.394676000000000,2:end-1)=NaN;
    pallas_2019_no_cloud(pallas_2019_no_cloud(:,end)==0.394675676000000,2:end-1)=NaN;
    pallas_2019_no_cloud(pallas_2019_no_cloud(:,end)==0.675676000000000,2:end-1)=NaN;
    pallas_2019_no_cloud(pallas_2019_no_cloud(:,end)==0.676000000000000,2:end-1)=NaN;


pallas_2020a=Pallas_PNSD_EBAS_import2013('FI0096G.20200101000000.20200514000000.dmps.particle_number_size_distribution.pm10.15w.1h.FI01L_FMI_DMPS_25_pm10.FI01L_dmps.lev2.nas',[166 inf]);
pallas_2020a=table2array(pallas_2020a);
pallas_2020a=pallas_2020a(:,[1 3:3:end]);
dn_2020=pallas_2020a(:,1)+1;
dn_2020=doy2date(dn_2020,ones(size(dn_2020,1),size(dn_2020,2))*2020);
pallas_2020a(:,1)=dn_2020;
pallas_2020a=[[0 Pallas_Sizes13_18 0];pallas_2020a];
unique(pallas_2020a(:,end))
pallas_2020a(pallas_2020a(:,end)>0.999,2:end-1)=NaN;
pallas_2020a(pallas_2020a(:,end)==0.390999000000000,2:end-1)=NaN;
pallas_2020a_no_cloud=pallas_2020a;
    pallas_2020a_no_cloud(pallas_2020a_no_cloud(:,end)==0.390676000000000,2:end-1)=NaN;
    pallas_2020a_no_cloud(pallas_2020a_no_cloud(:,end)==0.392676000000000,2:end-1)=NaN;
    pallas_2020a_no_cloud(pallas_2020a_no_cloud(:,end)==0.392675676000000,2:end-1)=NaN;
    pallas_2020a_no_cloud(pallas_2020a_no_cloud(:,end)==0.394676000000000,2:end-1)=NaN;
    pallas_2020a_no_cloud(pallas_2020a_no_cloud(:,end)==0.394675676000000,2:end-1)=NaN;
    pallas_2020a_no_cloud(pallas_2020a_no_cloud(:,end)==0.675676000000000,2:end-1)=NaN;
    pallas_2020a_no_cloud(pallas_2020a_no_cloud(:,end)==0.676000000000000,2:end-1)=NaN;



pallas_2020b=Pallas_PNSD_EBAS_import2013('FI0096G.20200416000000.20210122000000.dmps.particle_number_size_distribution.pm10.37w.1h.FI01L_FMI_DMPS_25_pm10.FI01L_dmps.lev2.nas',[166 inf]);
pallas_2020b=table2array(pallas_2020b);
pallas_2020b=pallas_2020b(:,[1 3:3:end]);
dn_2020=pallas_2020b(:,1)+1;
dn_2020=doy2date(dn_2020,ones(size(dn_2020,1),size(dn_2020,2))*2020);
pallas_2020b(:,1)=dn_2020;
pallas_2020b=[[0 Pallas_Sizes13_18 0];pallas_2020b];
unique(pallas_2020b(:,end))
pallas_2020b(pallas_2020b(:,end)>0.999,2:end-1)=NaN;
pallas_2020b_no_cloud=pallas_2020b;
    pallas_2020b_no_cloud(pallas_2020b_no_cloud(:,end)==0.390999000000000,2:end-1)=NaN;
    pallas_2020b_no_cloud(pallas_2020b_no_cloud(:,end)==0.390676000000000,2:end-1)=NaN;
    pallas_2020b_no_cloud(pallas_2020b_no_cloud(:,end)==0.392676000000000,2:end-1)=NaN;
    pallas_2020b_no_cloud(pallas_2020b_no_cloud(:,end)==0.392675676000000,2:end-1)=NaN;
    pallas_2020b_no_cloud(pallas_2020b_no_cloud(:,end)==0.394676000000000,2:end-1)=NaN;
    pallas_2020b_no_cloud(pallas_2020b_no_cloud(:,end)==0.394675676000000,2:end-1)=NaN;
    pallas_2020b_no_cloud(pallas_2020b_no_cloud(:,end)==0.675676000000000,2:end-1)=NaN;
    pallas_2020b_no_cloud(pallas_2020b_no_cloud(:,end)==0.676000000000000,2:end-1)=NaN;



pallas_2021=Pallas_PNSD_EBAS_import2013('FI0096G.20210101000000.20220214000000.dmps.particle_number_size_distribution.pm10.5mo.1h.FI01L_FMI_DMPS_25_pm10.FI01L_dmps.lev2.nas',[166 inf]);
pallas_2021=table2array(pallas_2021);
pallas_2021=pallas_2021(:,[1 3:3:end]);
dn_2020=pallas_2021(:,1)+1;
dn_2020=doy2date(dn_2020,ones(size(dn_2020,1),size(dn_2020,2))*2020);
pallas_2021(:,1)=dn_2020;
pallas_2021=[[0 Pallas_Sizes13_18 0];pallas_2021];
unique(pallas_2021(:,end))
pallas_2021(pallas_2021(:,end)>0.999,2:end-1)=NaN;
pallas_2021(pallas_2021(:,end)==0.390999000000000,2:end-1)=NaN;
pallas_2021_no_cloud=pallas_2021;
    pallas_2021_no_cloud(pallas_2021_no_cloud(:,end)==0.390676000000000,2:end-1)=NaN;
    pallas_2021_no_cloud(pallas_2021_no_cloud(:,end)==0.392676000000000,2:end-1)=NaN;
    pallas_2021_no_cloud(pallas_2021_no_cloud(:,end)==0.392675676000000,2:end-1)=NaN;
    pallas_2021_no_cloud(pallas_2021_no_cloud(:,end)==0.394676000000000,2:end-1)=NaN;
    pallas_2021_no_cloud(pallas_2021_no_cloud(:,end)==0.394675676000000,2:end-1)=NaN;
    pallas_2021_no_cloud(pallas_2021_no_cloud(:,end)==0.675676000000000,2:end-1)=NaN;
    pallas_2021_no_cloud(pallas_2021_no_cloud(:,end)==0.676000000000000,2:end-1)=NaN;


% Combine all years
% 
pallas_all=[pallas_2010(2:end,:);pallas_2011(2:end,:);pallas_2012(2:end,:);pallas_2013(2:end,:);...
    pallas_2014(2:end,:);pallas_2015(2:end,:);pallas_2016(2:end,:);pallas_2017(2:end,:);pallas_2018(2:end,:);pallas_2019(2:end,:);pallas_2020a(2:end,:);pallas_2020b(2:end,:);pallas_2021(2:end,:)];

pallas_all_no_cloud=[pallas_2010_no_cloud(2:end,:);pallas_2011_no_cloud(2:end,:);pallas_2012_no_cloud(2:end,:);pallas_2013_no_cloud(2:end,:);...
    pallas_2014_no_cloud(2:end,:);pallas_2015_no_cloud(2:end,:);pallas_2016_no_cloud(2:end,:);pallas_2017_no_cloud(2:end,:);pallas_2018_no_cloud(2:end,:);pallas_2019_no_cloud(2:end,:);pallas_2020a_no_cloud(2:end,:);pallas_2020b_no_cloud(2:end,:);pallas_2021_no_cloud(2:end,:)];

% Remove all size bins if any are greater than 4E4, an abritray limit chosen based on time series 
for x=1:size(pallas_all,1)
    if any(pallas_all(x,2:end-1)>4e4)
         pallas_all(x,2:end-1)=NaN;
         pallas_all_no_cloud(x,2:end-1)=NaN;
    end
end

% Remove all size bins if only 1 is greater than 3E4
for x=1:size(pallas_all,1)
    if nnz(pallas_all(x,2:end-1)>3e4)==1
         pallas_all(x,2:end-1)=NaN;
         pallas_all_no_cloud(x,2:end-1)=NaN;
    end
end

% Put sizes on top of array, and remove flags
pallas_all=[[0 Pallas_Sizes10_12];pallas_all(:,1:end-1)];
pallas_all(2:end,1)=datenum(dateshift(datetime(pallas_all(2:end,1),'ConvertFrom','datenum'), 'start', 'hour', 'nearest'));

pallas_all_no_cloud=[[0 Pallas_Sizes10_12];pallas_all_no_cloud(:,1:end-1)];
pallas_all_no_cloud(2:end,1)=datenum(dateshift(datetime(pallas_all_no_cloud(2:end,1),'ConvertFrom','datenum'), 'start', 'hour', 'nearest'));

pallas_all(find(pallas_all(:,1)>datenum(2020,12,31)):end,:)=[];
pallas_all_no_cloud(find(pallas_all_no_cloud(:,1)>datenum(2020,12,31)):end,:)=[];

pallas_sizes=Pallas_Sizes10_12;
% save Pallas_SMPS_QCed_2010_2018 pallas_all


%% Make nice plots

REMOVE_STATION_IN_CLOUD=true;

Plot_Size_Distribution_daily_for_yearly_average(pallas_all,35);

if REMOVE_STATION_IN_CLOUD
    Plot_Size_Distribution_daily_for_yearly_average(pallas_all,35);
    title('(g) Pallas PNSD')
    yline([nuc_lower aik_lower acc_lower],"--w",{'Nucleation','Aitken','Accumulation'},'LineWidth',2,'FontSize',25)
    yline(acc_upper,"--w",'LineWidth',2)
else
    Plot_Size_Distribution_daily_for_yearly_average(pallas_all_no_cloud,35);
    title('(a) Pallas PNSD All valid flags')
    yline([nuc_lower aik_lower acc_lower],"--w",{'Nucleation','Aitken','Accumulation'},'LineWidth',2,'FontSize',25)
    yline(acc_upper,"--w",'LineWidth',2)
end


if REMOVE_STATION_IN_CLOUD
    [pallas_sens,pallas_h]=dN_dP_Trend_3PW_LCL_UCL(pallas_all,alpha,[-20 20],35,{'(d) Pallas','(g) Pallas','(h) Pallas'});
else
    [pallas_sens,pallas_h]=dN_dP_Trend_3PW_LCL_UCL(pallas_all_no_cloud,alpha,[-20 20],35,{'(d) Pallas All vaid flags','(a) Pallas All vaid flags','(b) Pallas All vaid flags'});
end

if REMOVE_STATION_IN_CLOUD
    title_dc='(d) Pallas';
    data_capture(pallas_all,resolution,title_dc,35)
else
    title_dc='(e) Pallas All vaid flags';
    data_capture(pallas_all_no_cloud,resolution,title_dc,35)
end

% calculate number fraction in size bins

pallas_sf=[pallas_all(2:end,1) sum_conc_JBP('name',pallas_all,nuc_lower,acc_upper) sum_conc_JBP('name',pallas_all,nuc_lower,nuc_upper) sum_conc_JBP('name',pallas_all,aik_lower,aik_upper) sum_conc_JBP('name',pallas_all,acc_lower,acc_upper)];
pallas_sf(pallas_sf(:,2)==0,2:5)=NaN;
pallas_sf=array2table(pallas_sf);
pallas_sf.(1)=datetime(pallas_sf.(1),'ConvertFrom','datenum');
pallas_sf.Properties.VariableNames={'date','num_tot','num_nuc','num_aik','num_acc'};
pallas_sf=table2timetable(pallas_sf);


pallas_sf_no_cloud=[pallas_all_no_cloud(2:end,1) sum_conc_JBP('name',pallas_all_no_cloud,nuc_lower,acc_upper) sum_conc_JBP('name',pallas_all_no_cloud,nuc_lower,nuc_upper) sum_conc_JBP('name',pallas_all_no_cloud,aik_lower,aik_upper) sum_conc_JBP('name',pallas_all_no_cloud,acc_lower,acc_upper)];
pallas_sf_no_cloud(pallas_sf_no_cloud(:,2)==0,2:5)=NaN;
pallas_sf_no_cloud=array2table(pallas_sf_no_cloud);
pallas_sf_no_cloud.(1)=datetime(pallas_sf_no_cloud.(1),'ConvertFrom','datenum');
pallas_sf_no_cloud.Properties.VariableNames={'date','num_tot','num_nuc','num_aik','num_acc'};
pallas_sf_no_cloud=table2timetable(pallas_sf_no_cloud);
% save('pallas_sf_all.mat','pallas_sf')


%%
addpath('C:\Users\pernov\Documents\Trend Analysis\Arctic Stations\Pallas')
pallas_sf_all=pallas_sf;

sf_frac=pallas_sf;
sf_frac{:,'sum'}=sf_frac{:,1};
sf_frac{:,'frac_nuc'}=sf_frac{:,2}./sf_frac.sum*100;
sf_frac{:,'frac_aik'}=sf_frac{:,3}./sf_frac.sum*100;
sf_frac{:,'frac_acc'}=sf_frac{:,4}./sf_frac.sum*100;
sf_frac.month=month(sf_frac.date);
monthly_sum=grpstats(array2table(sf_frac{:,[2:4 end]},'VariableNames',sf_frac(:,[2:4 end]).Properties.VariableNames),'month','sum');

figure('units','normalized','outerposition',[0 0 1 1])
b=bar(monthly_sum{:,3:end}./sum(monthly_sum{:,3:end},2)*100,1,'stacked');
set(b, 'FaceColor', 'Flat')
b(1).CData = [0     0.60392     0.80392];
b(2).CData = [0.18039      0.5451     0.34118];
b(3).CData = [0.43137     0.48235      0.5451];

hold on
plot(monthly_sum.month,monthly_sum{:,3}./sum(monthly_sum{:,3:end},2)*100,'LineWidth',4,'Color',[0     0.74902           1])
plot(monthly_sum.month,monthly_sum{:,4}./sum(monthly_sum{:,3:end},2)*100,'LineWidth',4,'Color',[0.26275     0.80392     0.50196])
plot(monthly_sum.month,monthly_sum{:,5}./sum(monthly_sum{:,3:end},2)*100,'LineWidth',4,'Color',[0.63529      0.7098     0.80392])

ylim([0 100])
xlim([0.5 12.5])
ax=gca;
ax.XTick=(1:12);
ax.XTickLabel={'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
ax.YLabel.String='Relative contribution / %';
ax.FontSize=30;
ax.FontWeight='bold';
set(gca, 'LineWidth', 1.5)
legend({'Nucleation','Aitken','Accumulation','','',''},'NumColumns',3,'Location','north');
title('(d) Pallas')

%% Percentile Slopes
if REMOVE_STATION_IN_CLOUD
    title_pt={'(d) Pallas','(g) Pallas','(h) Pallas'};
    [pallas_sf_Slope,ps1,ps2,ps3,ps4]=decile_slopes_PanArctic_SizeFractions(pallas_sf,title_pt,'season',[-6 15],22);
else
    title_pt={'(d) Pallas All vaid flags','(g) Pallas All vaid flags','(h) Pallas All vaid flags'};
    [pallas_sf_Slope,ps1,ps2,ps3,ps4]=decile_slopes_PanArctic_SizeFractions(pallas_sf_no_cloud,title_pt,'season',[-6 15],22);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Alert
addpath('C:\Users\pernov\Documents\Trend Analysis\Arctic Stations\Alert')
load Alert_SMPS_2011_2020_Hourly.mat
alt_all1=alt_all;
alt_all1(sum(alt_all1(:,2:end)<25,2)>49,2:end)=NaN;
alt_all=alt_all1;
alt_sizes=alt_all(1,2:end);

Plot_Size_Distribution_daily_for_yearly_average(alt_all,35);
title('(a) Alert PNSD')
yline([nuc_lower aik_lower acc_lower],"--w",{'Nucleation','Aitken','Accumulation'},'LineWidth',2,'FontSize',25)
yline(acc_upper,"--w",'LineWidth',2)

[alt_sens,alt_h]=dN_dP_Trend_3PW_LCL_UCL(alt_all,alpha,[-10 10],35,{'(a) Alert','(a) Alert','(b) Alert'});

data_capture(alt_all,resolution,'(a) Alert',35)

alt_sf=[alt_all(2:end,1) sum_conc_JBP('name',alt_all,nuc_lower,acc_upper) sum_conc_JBP('name',alt_all,nuc_lower,nuc_upper) sum_conc_JBP('name',alt_all,aik_lower,aik_upper) sum_conc_JBP('name',alt_all,acc_lower,acc_upper)];
alt_sf(alt_sf(:,2)==0,2:5)=NaN;
alt_sf=array2table(alt_sf);
alt_sf.(1)=datetime(alt_sf.(1),'ConvertFrom','datenum');
alt_sf.Properties.VariableNames={'date','num_tot','num_nuc','num_aik','num_acc'};
alt_sf=table2timetable(alt_sf);
% save('alt_sf_all.mat','alt_sf')


sf_frac=alt_sf;
sf_frac{:,'sum'}=sf_frac{:,1};
sf_frac{:,'frac_nuc'}=sf_frac{:,2}./sf_frac.sum*100;
sf_frac{:,'frac_aik'}=sf_frac{:,3}./sf_frac.sum*100;
sf_frac{:,'frac_acc'}=sf_frac{:,4}./sf_frac.sum*100;
sf_frac.month=month(sf_frac.date);
monthly_sum=grpstats(array2table(sf_frac{:,[2:4 end]},'VariableNames',sf_frac(:,[2:4 end]).Properties.VariableNames),'month','sum');

figure('units','normalized','outerposition',[0 0 1 1])
b=bar(monthly_sum{:,3:end}./sum(monthly_sum{:,3:end},2)*100,1,'stacked');
set(b, 'FaceColor', 'Flat')
b(1).CData = [0     0.60392     0.80392];
b(2).CData = [0.18039      0.5451     0.34118];
b(3).CData = [0.43137     0.48235      0.5451];

hold on
plot(monthly_sum.month,monthly_sum{:,3}./sum(monthly_sum{:,3:end},2)*100,'LineWidth',4,'Color',[0     0.74902           1])
plot(monthly_sum.month,monthly_sum{:,4}./sum(monthly_sum{:,3:end},2)*100,'LineWidth',4,'Color',[0.26275     0.80392     0.50196])
plot(monthly_sum.month,monthly_sum{:,5}./sum(monthly_sum{:,3:end},2)*100,'LineWidth',4,'Color',[0.63529      0.7098     0.80392])

ylim([0 100])
xlim([0.5 12.5])
ax=gca;
ax.XTick=(1:12);
ax.XTickLabel={'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
ax.YLabel.String='Relative contribution / %';
ax.FontSize=30;
ax.FontWeight='bold';
set(gca, 'LineWidth', 1.5)
legend({'Nucleation','Aitken','Accumulation','','',''},'NumColumns',3,'Location','north');
title('(a) Alert')

%% Percentile Slopes
[alert_sf_Slope,As1,As2,As3,As4]=decile_slopes_PanArctic_SizeFractions(alt_sf,{'(a) Alert','(a) Alert','(b) Alert'},'season',[-3 3],22);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Varrio

addpath('C:\Users\pernov\Documents\Trend Analysis\Arctic Stations\Värriö')

load varrio_sizes.mat

varrio_2010=import_Varrio_EBAS_PNSD('FI0023R.20100101140000.20220228144720.dmps.particle_number_size_distribution.pm10.1y.1h.FI03L_UHEL_DMPS_VAR_01.FI03L__TRY_TDMPS.lev2.nas',[217, Inf]);
varrio_2010=table2array(varrio_2010);
varrio_2010=varrio_2010(:,[1 3:3:end]);
dn_2010=varrio_2010(:,1)+1;
dn_2010=doy2date(dn_2010,ones(size(dn_2010,1),size(dn_2010,2))*2010);
varrio_2010(:,1)=dn_2010;
varrio_2010=[[0 varrio_sizes 0];varrio_2010];
unique(varrio_2010(:,end))
varrio_2010(varrio_2010(:,end)==0.9990,2:end-1)=NaN;

varrio_2011=import_Varrio_EBAS_PNSD('FI0023R.20110101000000.20220228144720.dmps.particle_number_size_distribution.pm10.1y.1h.FI03L_UHEL_DMPS_VAR_01.FI03L__TRY_TDMPS.lev2.nas',[217, Inf]);
varrio_2011=table2array(varrio_2011);
varrio_2011=varrio_2011(:,[1 3:3:end]);
dn_2011=varrio_2011(:,1)+1;
dn_2011=doy2date(dn_2011,ones(size(dn_2011,1),size(dn_2011,2))*2011);
varrio_2011(:,1)=dn_2011;
varrio_2011=[[0 varrio_sizes 0];varrio_2011];
unique(varrio_2011(:,end))
varrio_2011(varrio_2011(:,end)==0.9990,2:end-1)=NaN;


varrio_2012=import_Varrio_EBAS_PNSD('FI0023R.20120101000000.20220228144720.dmps.particle_number_size_distribution.pm10.1y.1h.FI03L_UHEL_DMPS_VAR_01.FI03L__TRY_TDMPS.lev2.nas',[217, Inf]);
varrio_2012=table2array(varrio_2012);
varrio_2012=varrio_2012(:,[1 3:3:end]);
dn_2012=varrio_2012(:,1)+1;
dn_2012=doy2date(dn_2012,ones(size(dn_2012,1),size(dn_2012,2))*2012);
varrio_2012(:,1)=dn_2012;
varrio_2012=[[0 varrio_sizes 0];varrio_2012];
unique(varrio_2012(:,end))
varrio_2012(varrio_2012(:,end)==0.9990,2:end-1)=NaN;


varrio_2013=import_Varrio_EBAS_PNSD('FI0023R.20130101000000.20220228144720.dmps.particle_number_size_distribution.pm10.1y.1h.FI03L_UHEL_DMPS_VAR_01.FI03L__TRY_TDMPS.lev2.nas',[217, Inf]);
varrio_2013=table2array(varrio_2013);
varrio_2013=varrio_2013(:,[1 3:3:end]);
dn_2013=varrio_2013(:,1)+1;
dn_2013=doy2date(dn_2013,ones(size(dn_2013,1),size(dn_2013,2))*2013);
varrio_2013(:,1)=dn_2013;
varrio_2013=[[0 varrio_sizes 0];varrio_2013];
unique(varrio_2013(:,end))
varrio_2013(varrio_2013(:,end)==0.9990,2:end-1)=NaN;


varrio_2014=import_Varrio_EBAS_PNSD('FI0023R.20140101000000.20220228144720.dmps.particle_number_size_distribution.pm10.1y.1h.FI03L_UHEL_DMPS_VAR_01.FI03L__TRY_TDMPS.lev2.nas',[217, Inf]);
varrio_2014=table2array(varrio_2014);
varrio_2014=varrio_2014(:,[1 3:3:end]);
dn_2014=varrio_2014(:,1)+1;
dn_2014=doy2date(dn_2014,ones(size(dn_2014,1),size(dn_2014,2))*2014);
varrio_2014(:,1)=dn_2014;
varrio_2014=[[0 varrio_sizes 0];varrio_2014];
unique(varrio_2014(:,end))
varrio_2014(varrio_2014(:,end)==0.9990,2:end-1)=NaN;


varrio_2015=import_Varrio_EBAS_PNSD('FI0023R.20150101000000.20220228144720.dmps.particle_number_size_distribution.pm10.1y.1h.FI03L_UHEL_DMPS_VAR_01.FI03L__TRY_TDMPS.lev2.nas',[217, Inf]);
varrio_2015=table2array(varrio_2015);
varrio_2015=varrio_2015(:,[1 3:3:end]);
dn_2015=varrio_2015(:,1)+1;
dn_2015=doy2date(dn_2015,ones(size(dn_2015,1),size(dn_2015,2))*2015);
varrio_2015(:,1)=dn_2015;
varrio_2015=[[0 varrio_sizes 0];varrio_2015];
unique(varrio_2015(:,end))
varrio_2015(varrio_2015(:,end)==0.9990,2:end-1)=NaN;


varrio_2016=import_Varrio_EBAS_PNSD('FI0023R.20160101000000.20220228144720.dmps.particle_number_size_distribution.pm10.1y.1h.FI03L_UHEL_DMPS_VAR_01.FI03L__TRY_TDMPS.lev2.nas',[217, Inf]);
varrio_2016=table2array(varrio_2016);
varrio_2016=varrio_2016(:,[1 3:3:end]);
dn_2016=varrio_2016(:,1)+1;
dn_2016=doy2date(dn_2016,ones(size(dn_2016,1),size(dn_2016,2))*2016);
varrio_2016(:,1)=dn_2016;
varrio_2016=[[0 varrio_sizes 0];varrio_2016];
unique(varrio_2016(:,end))
varrio_2016(varrio_2016(:,end)==0.9990,2:end-1)=NaN;


varrio_2017=import_Varrio_EBAS_PNSD('FI0023R.20170101000000.20220228144720.dmps.particle_number_size_distribution.pm10.1y.1h.FI03L_UHEL_DMPS_VAR_01.FI03L__TRY_TDMPS.lev2.nas',[217, Inf]);
varrio_2017=table2array(varrio_2017);
varrio_2017=varrio_2017(:,[1 3:3:end]);
dn_2017=varrio_2017(:,1)+1;
dn_2017=doy2date(dn_2017,ones(size(dn_2017,1),size(dn_2017,2))*2017);
varrio_2017(:,1)=dn_2017;
varrio_2017=[[0 varrio_sizes 0];varrio_2017];
unique(varrio_2017(:,end))
varrio_2017(varrio_2017(:,end)==0.9990,2:end-1)=NaN;


varrio_2018=import_Varrio_EBAS_PNSD('FI0023R.20180101000000.20220228144720.dmps.particle_number_size_distribution.pm10.1y.1h.FI03L_UHEL_DMPS_VAR_01.FI03L__TRY_TDMPS.lev2.nas',[217, Inf]);
varrio_2018=table2array(varrio_2018);
varrio_2018=varrio_2018(:,[1 3:3:end]);
dn_2018=varrio_2018(:,1)+1;
dn_2018=doy2date(dn_2018,ones(size(dn_2018,1),size(dn_2018,2))*2018);
varrio_2018(:,1)=dn_2018;
varrio_2018=[[0 varrio_sizes 0];varrio_2018];
unique(varrio_2018(:,end))
varrio_2018(varrio_2018(:,end)==0.9990,2:end-1)=NaN;


varrio_2019=import_Varrio_EBAS_PNSD('FI0023R.20190101000000.20220228144720.dmps.particle_number_size_distribution.pm10.1y.1h.FI03L_UHEL_DMPS_VAR_01.FI03L__TRY_TDMPS.lev2.nas',[217, Inf]);
varrio_2019=table2array(varrio_2019);
varrio_2019=varrio_2019(:,[1 3:3:end]);
dn_2019=varrio_2019(:,1)+1;
dn_2019=doy2date(dn_2019,ones(size(dn_2019,1),size(dn_2019,2))*2019);
varrio_2019(:,1)=dn_2019;
varrio_2019=[[0 varrio_sizes 0];varrio_2019];
unique(varrio_2019(:,end))
varrio_2019(varrio_2019(:,end)==0.9990,2:end-1)=NaN;


varrio_2020=import_Varrio_EBAS_PNSD('FI0023R.20200101000000.20220228144720.dmps.particle_number_size_distribution.pm10.1y.1h.FI03L_UHEL_DMPS_VAR_01.FI03L__TRY_TDMPS.lev2.nas',[217, Inf]);
varrio_2020=table2array(varrio_2020);
varrio_2020=varrio_2020(:,[1 3:3:end]);
dn_2020=varrio_2020(:,1)+1;
dn_2020=doy2date(dn_2020,ones(size(dn_2020,1),size(dn_2020,2))*2020);
varrio_2020(:,1)=dn_2020;
varrio_2020=[[0 varrio_sizes 0];varrio_2020];
unique(varrio_2020(:,end))
varrio_2020(varrio_2020(:,end)==0.9990,2:end-1)=NaN;
% varrio_2020(varrio_2020(:,end)==0.7980,2:end-1)=NaN;


varrio_2021=import_Varrio_EBAS_PNSD('FI0023R.20210101000000.20220218000000.dmps.particle_number_size_distribution.pm10.1y.1h.FI03L_UHEL_DMPS_VAR_01.FI03L__TRY_TDMPS.lev2.nas',[217, Inf]);
varrio_2021=table2array(varrio_2021);
varrio_2021=varrio_2021(:,[1 3:3:end]);
dn_2021=varrio_2021(:,1)+1;
dn_2021=doy2date(dn_2021,ones(size(dn_2021,1),size(dn_2021,2))*2021);
varrio_2021(:,1)=dn_2021;
varrio_2021=[[0 varrio_sizes 0];varrio_2021];
unique(varrio_2021(:,end))
varrio_2021(varrio_2021(:,end)==0.9990,2:end-1)=NaN;


% Combine all years
varrio_all=[varrio_2010(2:end,:);varrio_2011(2:end,:);varrio_2012(2:end,:);varrio_2013(2:end,:);...
    varrio_2014(2:end,:);varrio_2015(2:end,:);varrio_2016(2:end,:);varrio_2017(2:end,:);varrio_2018(2:end,:);varrio_2018(2:end,:);varrio_2019(2:end,:);varrio_2020(2:end,:);varrio_2021(2:end,:)];

% Remove all size bins if any are greater than 9.9E4, an abritray limit chosen based on time series 
for x=1:size(varrio_all,1)
    if any(varrio_all(x,2:end-1)>=9.9e4)
         varrio_all(x,2:end-1)=NaN;
    end
end


varrio_all(varrio_all(:,end)==0.9990,2:end-1)=NaN;

% Put sizes on top of array, and remove flags
varrio_all=[[0 varrio_sizes];varrio_all(:,1:end-1)];
varrio_all(2:end,1)=datenum(dateshift(datetime(varrio_all(2:end,1),'ConvertFrom','datenum'), 'start', 'hour', 'nearest'));

varrio_all(find(varrio_all(:,1)>datenum(2020,12,31)):end,:)=[];

% save varrio_all varrio_all
%% Make nice plots
Plot_Size_Distribution_daily_for_yearly_average(varrio_all,35);
title('(i) Värriö PNSD')
yline([nuc_lower aik_lower acc_lower],"--w",{'Nucleation','Aitken','Accumulation'},'LineWidth',2,'FontSize',25)
yline(acc_upper,"--w",'LineWidth',2)

[varrio_sens,varrio_h]=dN_dP_Trend_3PW_LCL_UCL(varrio_all,alpha,[-20 20],35,{'(e) Värriö','(i) Värriö','(j) Värriö'});

data_capture(varrio_all,resolution,'(e) Värriö',35)

% calculate number fraction in size bins
varrio_sf=[varrio_all(2:end,1) sum_conc_JBP('name',varrio_all,nuc_lower,acc_upper) sum_conc_JBP('name',varrio_all,nuc_lower,nuc_upper) sum_conc_JBP('name',varrio_all,aik_lower,aik_upper) sum_conc_JBP('name',varrio_all,acc_lower,acc_upper)];
varrio_sf(varrio_sf(:,2)==0,2:5)=NaN;
varrio_sf=array2table(varrio_sf);
varrio_sf.(1)=datetime(varrio_sf.(1),'ConvertFrom','datenum');
varrio_sf.Properties.VariableNames={'date','num_tot','num_nuc','num_aik','num_acc'};
varrio_sf=table2timetable(varrio_sf);
% save('varrio_sf_all.mat','varrio_sf')


%%
addpath('C:\Users\pernov\Documents\Trend Analysis\Arctic Stations\Värriö')
% load varrio_sf_all.mat
varrio_sf_all=varrio_sf;

sf_frac=varrio_sf;
sf_frac{:,'sum'}=sf_frac{:,1};
sf_frac{:,'frac_nuc'}=sf_frac{:,2}./sf_frac.sum*100;
sf_frac{:,'frac_aik'}=sf_frac{:,3}./sf_frac.sum*100;
sf_frac{:,'frac_acc'}=sf_frac{:,4}./sf_frac.sum*100;
sf_frac.month=month(sf_frac.date);
monthly_sum=grpstats(array2table(sf_frac{:,[2:4 end]},'VariableNames',sf_frac(:,[2:4 end]).Properties.VariableNames),'month','sum');

%% Percentile Slopes
[varrio_sf_Slope,Vs1,Vs2,Vs3,Vs4]=decile_slopes_PanArctic_SizeFractions(varrio_sf,{'(e) Värriö','(i) Värriö','(j) Värriö'},'season',[-6 15],22);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plotting annual cycle
% Fig 2 right panels

plot_annual_cycle(alt_sf,'daily',35,'(b) Alert Number Concentration',[1 800],false)

plot_annual_cycle(vrs_sf,'daily',35,'(d) Villum Number Concentration',[1 800],false)

plot_annual_cycle(nya_sf,'daily',35,'(f) Zeppelin Number Concentration',[1 1600],false)

plot_annual_cycle(pallas_sf,'daily',35,'(h) Pallas Number Concentration',[1 2500],false)

plot_annual_cycle(varrio_sf,'daily',35,'(j) Värriö Number Concentration',[1 2500],false)


plot_annual_cycle(alt_sf,'daily',35,'(b) Alert Number Concentration',[1 10000],true)

plot_annual_cycle(vrs_sf,'daily',35,'(d) Villum Number Concentration',[1 10000],true)

plot_annual_cycle(nya_sf,'daily',35,'(f) Zeppelin Number Concentration',[1 10000],true)

plot_annual_cycle(pallas_sf,'daily',35,'(b) Pallas Number Concentration All valid flags',[1 10000],true)

plot_annual_cycle(varrio_sf,'daily',35,'(j) Värriö Number Concentration',[1 10000],true)


%% All Sites on one figure Plotting monthly average
% Fig S1

figure('units','normalized','outerposition',[0 0 1 1]);
months={'Jan' 'Feb' 'Mar' 'Apr' 'May' 'Jun' 'Jul' 'Aug' 'Sep' 'Oct' 'Nov' 'Dec'};
vrs_all=SMPS_all;
lwidth=2;

nrows=4; ncols=3;

ha = tight_subplot(nrows, ncols, [0.025 0.015], [0.09 0.16], [0.08 0.08]);

for x=1:12
    axes(ha(x));   
    row = ceil(x/ncols);
    col = mod(x-1,ncols)+1;

    semilogx(alt_all(1,2:end),median(alt_all(month(alt_all(2:end,1))==x,2:end),'omitnan'),'r','LineWidth',lwidth)
    hold on
    semilogx(vrs_all(1,2:end),median(vrs_all(month(vrs_all(2:end,1))==x,2:end),'omitnan'),'b','LineWidth',lwidth)
    semilogx(nya_all(1,2:end),median(nya_all(month(nya_all(2:end,1))==x,2:end),'omitnan'),'Color',colors('gold'),'LineWidth',lwidth)
    ylim([0 350])
    xlim([5 1010])
    xticks([5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000])
    xticklabels({[],[],[],[],[],'10',[],[],[],[],[],[],[],[],'100',[],[],[],[],[],[],[],[],'1000'})
    text(0.05, 0.95, months{x}, 'Units','normalized', 'HorizontalAlignment','left', ...
        'VerticalAlignment','top', 'FontSize',16, 'FontWeight','bold','EdgeColor', 'black', 'BackgroundColor', 'white');
    ax = gca;
    set(gca, 'LineWidth', 1.25)
    ax.FontSize = 16;
    ax.FontWeight='bold';
    ax.XTickLabelRotation=0;
    grid on
    ax.XMinorTick='off';
    set(gca,'TickDir','out');

    yyaxis right
    semilogx(pallas_all(1,2:end),median(pallas_all(month(pallas_all(2:end,1))==x,2:end),'omitnan'),'c','LineWidth',lwidth)
    hold on
    semilogx(pallas_all(1,2:end),median(pallas_all_no_cloud(month(pallas_all_no_cloud(2:end,1))==x,2:end),'omitnan'),'c','LineWidth',lwidth,'LineStyle',':')
    semilogx(varrio_all(1,2:end),median(varrio_all(month(varrio_all(2:end,1))==x,2:end),'omitnan'),'m','LineWidth',lwidth,'LineStyle','-')
    ax=gca;
    ax.YColor='k';
    ylim([0 1350])
    xlim([5 1000])
    hold off

    % ---- tick-label pruning (labels only; ticks/gridlines stay) ----
    if row ~= nrows
        set(gca,'XTickLabel',[]);
    end
    yyaxis left
    if col ~= 1
        set(gca,'YTickLabel',[]);
    end
    yyaxis right
    if col ~= ncols
        set(gca,'YTickLabel',[]);
    end
    % ------------------------------------------------------------------

    if x==1
        hL = legend({'Alert','Villum','Zeppelin','Pallas In Cloud','Pallas All Valid Flags','Värriö'}, ...
                     'FontSize',18,'NumColumns',6,'Box','off');
    end
end

% ---- move legend to its own row: below main title, above the grid ----
drawnow;                       % force layout so legend has a real size
hL.Units = 'normalized';
w = hL.Position(3);
h = hL.Position(4);
hL.Position = [0.5 - w/2, 0.875, w, h];   % centered horizontally; y tuned to sit under the title
% ------------------------------------------------------------------------

fig_fsize=22;
f1=figtitle_side('dN/dlogDp / cm^{-3}','FontSize',fig_fsize,'FontWeight','bold');
f11=figtitle_side('Pallas & Värriö - dN/dlogDp / cm^{-3}','FontSize',fig_fsize,'FontWeight','bold');
f2=figtitle_bottom('Dp / nm','FontSize',fig_fsize,'FontWeight','bold');
f1.Position=[0.01,0.50 0];
f11.Position=[0.96,0.50 0];
f2.Position=[0.50 0.05 0];

fontsize(gcf, scale=1.2)
fontsize(gcf, scale=1.2)

% 1920 x 1080 screen resolution