%% Test Paneltable class
% function paneltable_demo 
%%
clc;clear; close all;
%%
Name = ["a";"b";"c"];
Province = ["北京";"浙江";"浙江"];
City = ["天台";"杭州";"天台"];
Grade = [1;2;3];
Time = ["1990-1-2";"1990-2-2";"1991-1-6"];
Datenum= datenum(Time);
T = table(Province, City,Name,Grade,Time,Datenum);
it = ["City","Name","Time"];
% Tp = panelTable(T,it);


T = bygroupRetimeMonthlyEom(T,'Datenum',{'Province','City'});
T.Datestr = datestr(T.Datenum);
T.ID = T.Province+"-"+T.City;
return;

%% Publish the function code
options.codeToEvaluate = 'Name = ["a";"b";"c"];Province = ["北京";"浙江";"浙江"];City = ["天台";"杭州";"天台"];Grade = [1;2;3];Time = ["1990-1-2";"1990-2-2";"1991-1-6"];Datenum= datenum(Time);T = table(Province, City,Name,Grade,Time,Datenum);'; 
options.format = 'html'; 
publish('bygroupRetimeMonthlyEom.m',options);
 
%%

Name = ["a";"b";"c"];
Province = ["浙江";"浙江";"浙江"];
City = ["杭州";"杭州";"杭州"];
Grade = [1;2;3];
Time = ["1990-1-2";"1990-2-2";"1991-1-6"];
Datenum= datenum(Time);
T = table(Province, City,Name,Grade,Time,Datenum);
it = ["City","Name","Time"];
T = bygroupRetimeMonthlyEom(T,'Datenum',{'Province','City'});
T.Datestr = datestr(T.Datenum);
 