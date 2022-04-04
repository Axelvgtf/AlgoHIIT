// Copyright (C) 2022 - University of Montpellier - NIERDING Axel
//
//
// Date of creation: 9 févr. 2022
//
// **** FIRST : Initialize ****
clear
clc
PRG_PATH = get_absolute_file_path("HIIT.sce");          
FullFileInitTRT = fullfile(PRG_PATH, "InitTRT.sce" );
exec(FullFileInitTRT); 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//OPEN THE FILE HIIT4 AND READ INTO THIS FILE
//

fnameIn = fullfile(DAT_PATH, "HIIT4DT2_01.csv"); // Path of the info file
Data = csvRead(fnameIn, ";", '.' ,'double', [], [], [], 3)            // Read info file and delete the third lines in header to keep numbers only
BPM = Data(:,3) //Extract the BPM wich correspond to the third colonn 
Time = Data(:,1)//Extract the time in seconds wich correspond to the first colonn 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//Plot the condition to get an idea of the condition in terms of BPM during each blocks and the recuperation post effort

scf(2)
// Preparing data for the different axis
x1 = Time                     // Time data 
y1 = BPM                    // BPM data
plot2d(x1,y1,style= color("magenta4"))
gce().children.thickness = 3;               // Enlargement of the plot line

title("BPM Over condition")
xlabel("Time in seconds")
ylabel("BPM")
legend('BPM during condition',opt=4)
//
fnamePDF2 = fullfile(RES_PATH, "Figure 1")
xs2pdf(scf(2),fnamePDF2)

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//MAKE A MEAN OF THE ALL CONDITION  (EFFORT + RECUPERATION)

tBegCondition = min(Data(:,1))         // Set the first second of recording
tEndCondition = max(Data(:,1))        // Set the last second of recording
TimeOfAllCondition = find (Data(:,1) >= tBegCondition & Data(:,1) <= tEndCondition)//Find in Data the duration between the first second of recording and the last one

MeanBPMOverTheCondition = mean(Data(TimeOfAllCondition,3))//Make a mean of BPM during the all condition with a range of time coresponding to the first and the last second of recording
disp('Mean of BPM durin all the Condition',MeanBPMOverTheCondition)//Disp the result

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//MAKE A VECTOR WIHICH CONTAINS THE DURATION OF THE WARM UP, THE EFFORT AND THE RECUPERATION (POST EFFORT) OF THE CONDITION 


TimeWarmUp = Time(8);                           // get the duration in minutes of the warm-up in the info file
TimeWarmUp = TimeWarmUp.*60                   // Convert warm-up time to seconds

lowLimit = find(Data(:,1) >= TimeWarmUp)      // Finds the indexes where the time >= TimeWarmUp
lowLimit = lowLimit(1)                      // Keep only the lowest time value

endEffort = Time(8) + Time(32);               // get the duration in minutes of the warm-up + effort in the info file
endEffort = endEffort.*60                 // Convert endEffort to seconds

highLimit = find(Data(:,1) <= endEffort) // Finds the indexes where the time <= endEffort
highLimit = highLimit(1,$)              // Keep only the last time value

DataEff = Data(lowLimit:highLimit,1:3)   // creates DataEff which contains the data between lowLimit and highLimit, i.e. the data related to the effort phase

tPostEffCondition = (Data(highLimit,1))         // Get the first second after the effort corresponding to the first second of recuperation's period
tEndCondition = max(Data(:,1))         //Get the last second of recuperation's period

TimeOfPostEffCondition = find (Data(:,1) >= tPostEffCondition & Data(:,1) <= tEndCondition)    //Finds the indexes the time of all recuperation's period
TimeOfPostEffCondition = TimeOfPostEffCondition'


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//CALCULATE THE MEAN PER 1 MINUTES (60 seconds) BLOCK DURING EFFORT'S PERIOD 

fullFileMeanPer = fullfile(PRG_PATH, "dataMeanOverPeriod.sci" );
exec(fullFileMeanPer); 


maxTime = max(DataEff(:,1));      // Set the last second of recording 
blockDuration = 60;             // Duration of the block in seconds
tBeg = 0 + DataEff(1,1);         // Start of the first period
tEnd = blockDuration + DataEff(1,1);       // End of the first period

//
n=1                             // Will define a row number in meanValues
while tEnd < maxTime         // Create an iterative loop, as long as tEnd < maxTime  
    meanValues (n,1) = dataMeanOverPeriod(DataEff,tBeg,tEnd) // calculates the mean values for each block and implements, in meanValues, the new mean at each loop 
    tBeg  =  tBeg + blockDuration // redefine the beginning of each block at each loop
    tEnd  = tEnd + blockDuration   // redefine the end of each block at each loop
    n = n + 1                 // Add an extra line to meanValue at each loop
end

disp("Average Values of BPM per 60 s block", meanValues)// ibid than line 109

fullFileName = (RES_PATH + "/Mean_Values_60seconds.csv");    // Define the path and the file name
print(fullFileName,meanValues)                     // save in file

fullFileMeanPer = fullfile(PRG_PATH, "displaySignalAndMean.sci" );
exec(fullFileMeanPer); 

graph=displaySignalAndMean(DataEff,tBeg,tEnd,maxTime,blockDuration)


title(" BPM mean per block duration of 60s")           // Attention, if you change blockDuration, you must corrected title, xlabel, legend of the figure
xlabel("Time in seconds")
ylabel("BPM")
legend("mean BPM (60s Block)",opt=4)
fnamePDF3 = fullfile(RES_PATH, "Figure 2 : BPM Effort (60s blocks)")
xs2pdf(scf(3),fnamePDF3)           //save figure in RES folder

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//CALCULATE THE MEAN PER 20 seconds BLOCK DURING EFFORT'S PERIOD OF THE CONDITION HIIT4

fullFileMeanPer = fullfile(PRG_PATH, "dataMeanOverPeriod.sci" );
exec(fullFileMeanPer); 
maxTime = max(DataEff(:,1));      // Set the last second of recording 
blockDuration = 20;             // Duration of the block in seconds
tBeg = 0 + DataEff(1,1);         // Start of the first period
tEnd = blockDuration + DataEff(1,1);       // End of the first period

//
n=1                             // Will define a row number in meanValues
while tEnd < maxTime         // Create an iterative loop, as long as tEnd < maxTime  
    meanValues (n,1) = dataMeanOverPeriod(DataEff,tBeg,tEnd) // calculates the mean values for each block and implements, in meanValues, the new mean at each loop 
    tBeg  =  tBeg + blockDuration // redefine the beginning of each block at each loop
    tEnd  = tEnd + blockDuration  // redefine the end of each block at each loop
    n = n + 1                 // Add an extra line to meanValue at each loop
end

disp("Average Values of BPM per 20 s block", meanValues)// ibid than line 109

fullFileName = (RES_PATH + "/Mean_Values_20seconds.csv");    // Define the path and the file name
print(fullFileName,meanValues)                     // save in file

fullFileMeanPer = fullfile(PRG_PATH, "displaySignalAndMean.sci" );
exec(fullFileMeanPer); 


graph=displaySignalAndMean(DataEff,tBeg,tEnd,maxTime,blockDuration)


title(" BPM mean per block duration of 20s")           // Attention, if you change blockDuration, you must corrected title, xlabel, legend of the figure
xlabel("Time in seconds")
ylabel("BPM")
legend("mean BPM (20s Block)",opt=4)
fnamePDF4 = fullfile(RES_PATH, "Figure 3 : BPM Effort (60s blocks)")
xs2pdf(scf(4),fnamePDF4)           //save figure in RES folder




