
function [result,data1]=PW3_nofig(file,name,time_seg,res,method,alpha,p)
file=array2table(file);
file.(1)=datetime(file.(1),'ConvertFrom','datenum');
file.Properties.VariableNames={'Time','param'};
file=table2timetable(file);

file_c=retime(file,res,'count');
if strcmp(method,'median')
    file=retime(file,res,@med);
elseif strcmp(method,'mean')
    file=retime(file,res,'mean');
elseif strcmp(method,'sum')
    file=retime(file,res,'sum');
elseif strcmp(method,'percentile')
    file=retime(file,res,@(x) perctile(x,p));
end

for x=1:size(file_c,1)    
    if max(file_c.param(x))<floor(max(file_c.param)/2)
        file.param(x)=NaN;
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
elseif strcmp(time_seg,'none')==1
    data1=file;
end
resolution=0.0001;

result=MK_tempAggr(data1,resolution,'PW_method','3PW','alpha_MK',alpha,'alpha_ak',95, 'alpha_CL',95, 'alpha_Xhomo',90);

end