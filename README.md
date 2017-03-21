The Appendix consists of three parts
=======================
1. The ONE Simulator Source Codes
2. Scripts of Configurations for the One Simualtor
3. Matlab Scripts for importing data from reports generated from simulation of ONE and data analysis.
=======================
1. The ONE Simulator Source Codes



###########################################################
README.mb



The Appendix consists of three parts:
• The ONE Simulator Source Codes
• Scripts of Configurations for the One Simualtor
• Matlab Scripts for importing data from reports generated from simulation of ONE and data analysis

=======================

1. The ONE Simulator Source Codes Based on the original source code of the ONE, I created three new classes in the routing package. These are
• EnergyAwareDDRouter.java
• EnergyAwareEpidRouter.java
• EnergyAwareSAWRouter.java

#Reference https://github.com/akeranen/the-one/tree/v1.6.0

2. Scripts of Configurations for the One Simualtor. Here are some acronyms meanings,
• DR: Direct Delivery
• ER: Epidemic Router
• SAW: Spray and Wait
• DRNE: Direct Delivery No Energy (ideal benchmarks)
• ERNE: Epidemic Router No Energy (ideal benchmarks)
• SAWNE: Spray and Wait No Energy (ideal benchmarks)
• 170/340/510: The number of pedestrians with energy consumption on their mobile devices in a DTN.
• WorkDay: WorkingDayMovement (a type of movement model applied across all of simualtions)

3. Matlab Scripts for importing data from reports are generated from simulations of ONE and data analysis.
• Those scripts named with 'Final' are used to import energy levels data from the EnergyLevelReport generated after each round of simualtion and make analysis of them, which are then applied for plotting graphs.
• DelPro_AveLat_AveOver_AveBuffTime.m has to run before importing the numerical results from MessStatReport into a numerical matrix in dimension of 9-by-8.



