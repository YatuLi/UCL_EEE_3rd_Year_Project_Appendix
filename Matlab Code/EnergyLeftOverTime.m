% Author: Yatu Li, University College London, 2017
%% Subplots of EnergyAware and Regular of 170, 340 and 510
% 170
% Sec - 510
% Thi - 340

%% Originate the horizontal axis of Time of a whole day.

%% Figure of 1-by-2 for Regular VS EnergyAware 170
Subf1 = figure;
set(Subf1, 'name', 'Regular Energy Model VS Energy Aware Model 170', 'numbertitle', 'off');
% Regular Energy Model with 170 Pedestrains
subplot(1,2,1);

RegularEnergyPlot = plot(Time, PercentFinalAnswerOfDDR, '-blue+', Time, PercentFinalAnswerOfER, '-red*', Time, PercentFinalAnswerOfSAW, '-greenx');
hold on
grid on
% add up xticks in an increment of every 4 hours
xticks ([0, 4, 8, 12, 16, 20, 24]);
% add up y ticks by putting up ticks numerically first, then add up
% ticklabels.
yticks([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]);
yticklabels({'0', '10%','20%', '30%','40%','50%','60%','70%','80%','90%','100%'});
title('Regular Energy Model (170)');
ylabel('Remained Energy Percentage');
xlabel('Time (h)');

legend('DirectDeliveryRouter' , 'EpidemicRouter', 'SprayAndWaitRouter');
legend('Location', 'NorthEast');
% to thicken the curves by using the set() and handlers of the plot
set(RegularEnergyPlot, 'lineWidth' ,0.1);
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

% Energy Aware Model with 170 Pedestrains
subplot(1,2,2)
EnergyAwarePlot = plot(Time, PercentFinalAnswerOfEADR,'-blue+',  Time, PercentFinalAnswerOfEAER, '-red*', Time, PercentFinalAnswerOfEASAW, '-greenx');
hold on
grid on
xticks ([0, 4, 8, 12, 16, 20, 24]);
yticks([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]);
yticklabels({'0', '10%','20%', '30%','40%','50%','60%','70%','80%','90%','100%'});
title('Eneray Aware Model (170)');
ylabel('Remained Energy Percentage');
xlabel('Time (h)');

legend('EnergyAwareDDRouter' , 'EnergyAwareEpideRouter', 'EnergyAwareSAWRouter');
legend('Location', 'NorthEast');
% to thicken the curves by using the set() and handlers of the plot
set(EnergyAwarePlot, 'lineWidth', 0.1);
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

%% Figure of 1-by-2 for Regular VS EnergyAware 510
Subf2 = figure;
set(Subf2, 'name', 'Regular Energy Model VS Energy Aware Model 510', 'numbertitle', 'off');

% Regular Energy Model with 510 Pedestrains
subplot(1,2,1);
RegularEnergyPlotSec = plot(Time, PercentFinalAnswerOfDDRSec, '-blue+', Time, PercentFinalAnswerOfERSec, '-red*', Time, PercentFinalAnswerOfSAWSec, '-greenx');
hold on
grid on
% add up xticks in an increment of every 4 hours
xticks ([0, 4, 8, 12, 16, 20, 24]);
% add up y ticks by putting up ticks numerically first, then add up
% ticklabels.
yticks([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]);
yticklabels({'0', '10%','20%', '30%','40%','50%','60%','70%','80%','90%','100%'});
title('Regular Energy Model (510)');
ylabel('Remained Energy Percentage', 'fontsize', 18);
xlabel('Time (h)', 'fontsize', 18);

legend('DirectDeliveryRouter' , 'EpidemicRouter', 'SprayAndWaitRouter');
legend('Location', 'NorthEast');
% to thicken the curves by using the set() and handlers of the plot
set(RegularEnergyPlotSec, 'lineWidth' ,0.1);
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

% Energy Aware Model with 510 Pedestrains
subplot(1,2,2);
EnergyAwarePlotSec = plot(Time, PercentFinalAnswerOfEADRSec,'-blue+',  Time, PercentFinalAnswerOfEAERSec, '-red*', Time, PercentFinalAnswerOfEASAWSec, '-greenx');
hold on
grid on
xticks ([0, 4, 8, 12, 16, 20, 24]);
yticks([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]);
yticklabels({'0', '10%','20%', '30%','40%','50%','60%','70%','80%','90%','100%'});
title('Energy Aware Model (510)');
ylabel('Remained Energy Percentage', 'fontsize', 18);
xlabel('Time (h)', 'fontsize', 18);

legend('EnergyAwareDDRouter' , 'EnergyAwareEpideRouter', 'EnergyAwareSAWRouter');
legend('Location', 'NorthEast');
% to thicken the curves by using the set() and handlers of the plot
set(EnergyAwarePlotSec, 'lineWidth', 0.1);
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

%% Figure of 1-by-2 for Regular VS EnergyAware 340
Subf3 = figure;
set(Subf3, 'name', 'Regular Energy Model VS Energy Aware Model 340', 'numbertitle', 'off');
% Regular Energy Model with 340 Pedestrains
subplot(1,2,1);
RegularEnergyPlotThi = plot(Time, PercentFinalAnswerOfDDRThi, '-blue+', Time, PercentFinalAnswerOfERThi, '-red*', Time, PercentFinalAnswerOfSAWThi, '-greenx');
hold on
grid on
% add up xticks in an increment of every 4 hours
xticks ([0, 4, 8, 12, 16, 20, 24]);
% add up y ticks by putting up ticks numerically first, then add up
% ticklabels.
yticks([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]);
yticklabels({'0', '10%','20%', '30%','40%','50%','60%','70%','80%','90%','100%'});
title('Regular Energy Model (340)');
ylabel('Remained Energy Percentage');
xlabel('Time (h)');

legend('DirectDeliveryRouter' , 'EpidemicRouter', 'SprayAndWaitRouter');
legend('Location', 'NorthEast');
% to thicken the curves by using the set() and handlers of the plot
set(RegularEnergyPlotThi, 'lineWidth' ,0.1);
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

subplot(1,2,2);
EnergyAwarePlotThi = plot(Time, PercentFinalAnswerOfEADRThi,'-blue+',  Time, PercentFinalAnswerOfEAERThi, '-red*', Time, PercentFinalAnswerOfEASAWThi, '-greenx');
hold on
grid on
xticks ([0, 4, 8, 12, 16, 20, 24]);
yticks([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]);
yticklabels({'0', '10%','20%', '30%','40%','50%','60%','70%','80%','90%','100%'});
title('Energy Aware Model (340)');
ylabel('Remained Energy Percentage');
xlabel('Time (h)');

legend('EnergyAwareDDRouter' , 'EnergyAwareEpideRouter', 'EnergyAwareSAWRouter');
legend('Location', 'NorthEast');
% to thicken the curves by using the set() and handlers of the plot
set(EnergyAwarePlotThi, 'lineWidth', 0.1);
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

%% Figure of EADR, EAER and EASAW across 170, 340 and 510 Seperately
Subf5 = figure;
set(Subf5, 'name', 'Energy Aware Model for EADD', 'numbertitle', 'off');

% EADR
EADRPlot = plot(Time, PercentFinalAnswerOfEADR,'-blue+',  Time, PercentFinalAnswerOfEADRThi, '-red*', Time, PercentFinalAnswerOfEADRSec, '-greenx');
hold on
grid on
xticks ([0, 4, 8, 12, 16, 20, 24]);
yticks([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]);
yticklabels({'0', '10%','20%', '30%','40%','50%','60%','70%','80%','90%','100%'});
title('Energy Aware Direct Delivery');
ylabel('Remained Energy (%)');
xlabel('Time (h)');

legend('170' , '340', '510');
legend('Location', 'NorthEast');
% to thicken the curves by using the set() and handlers of the plot
set(EADRPlot, 'lineWidth', 0.1);
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

%% EAER
Subf6 = figure;
set(Subf6, 'name', 'Energy Aware Model for EAER', 'numbertitle', 'off');

EAERPlot = plot(Time, PercentFinalAnswerOfEAER,'-blue+',  Time, PercentFinalAnswerOfEAERThi, '-red*', Time, PercentFinalAnswerOfEAERSec, '-greenx');
hold on
grid on
xticks ([0, 4, 8, 12, 16, 20, 24]);
yticks([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]);
yticklabels({'0', '10%','20%', '30%','40%','50%','60%','70%','80%','90%','100%'});
title('Energy Aware Epidemic');
ylabel('Remained Energy (%)');
xlabel('Time (h)');

legend('170' , '340', '510');
legend('Location', 'NorthEast');
% to thicken the curves by using the set() and handlers of the plot
set(EAERPlot, 'lineWidth', 0.1);
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off

%% EASAW
% 'postion', [left bottom width height])
% Due to we desire to insert the 3rd sub plot in the 2nd row, where it is
% better to be place in the middle to give a better visual effect. So we
% have to apply for subplot('postion', []); to resolve it.
% subplot('position', [0.35 0.08 0.35 0.35]);
% the Column Vector format suggested by Vasilis 02/03/2017
Subf7 = figure;
set(Subf7, 'name', 'Energy Aware Model for EADD', 'numbertitle', 'off');
EADRPlot = plot(Time, PercentFinalAnswerOfEASAW,'-blue+',  Time, PercentFinalAnswerOfEASAWThi, '-red*', Time, PercentFinalAnswerOfEASAWSec, '-greenx');
hold on
grid on
xticks ([0, 4, 8, 12, 16, 20, 24]);
yticks([0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]);
yticklabels({'0', '10%','20%', '30%','40%','50%','60%','70%','80%','90%','100%'});
title('Energy Aware Spray and Wait');
ylabel('Remained Energy (%)');
xlabel('Time (h)');

legend('170' , '340', '510');
legend('Location', 'NorthEast');
% to thicken the curves by using the set() and handlers of the plot
set(EADRPlot, 'lineWidth', 0.1);
% Adjust the ticks, legends and labels of the plots in terms of their
% fontsize.
set(gca, 'fontsize', 20);
hold off