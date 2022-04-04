// Copyright (C) 2022 - Corporation - Author
//
// About your license if you have any
//
// Date of creation: 3 avr. 2022
//
// **** FIRST : Initialize ****
clear
clc
PRG_PATH = get_absolute_file_path("RecoveryPostHIIT.sce");          
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
//MAKE A MEAN OF BPM DURING THE RECUPERATION'S PERIOD OF THE CONDITION 

MeanBPMPostEffCondition = mean(Data(TimeOfPostEffCondition,3))//Mean of the recuperation's period
disp('Mean of BPM Post Effort in Condition corresponding to the recuperation period',MeanBPMPostEffCondition)//Disp the mean of recuperation's period


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//MAKE THE MEAN PER 15 MINUTES (900 seconds) BLOCK DURING RECUPERATION'S PERIOD OF THE CONDITION 

fullFileMeanPer = fullfile(PRG_PATH, "dataMeanOverPeriod.sci" );
exec(fullFileMeanPer); 
DataRec = Data(highLimit:$,1:3)
maxTime = max(DataRec(:,1));      // Set the last second of recording 
blockDuration = 900;             // Duration of the block in seconds
tBeg = 0 + (DataRec(1,1));         // Start of the first period
tEnd = max(DataRec(:,1)) + blockDuration  ;       // End of the first period

//
n=1                             // Will define a row number in meanValues
while tBeg < maxTime         // Create an iterative loop, as long as tEnd < maxTime  
    meanValues (n,1) = dataMeanOverPeriod(DataRec,tBeg,tEnd) // calculates the mean values for each block and implements, in meanValues, the new mean at each loop 
    tBeg  =  tBeg + blockDuration // redefine the beginning of each block at each loop
    tEnd  = tEnd + blockDuration  // redefine the end of each block at each loop
    n = n + 1                 // Add an extra line to meanValue at each loop
end

disp("Average Values of BPM per 15 min block Post Effort corresponding to the recuperation period", meanValues)


fullFileName = (RES_PATH + "/Mean_Values_15min.csv");    // Define the path and the file name
print(fullFileName,meanValues)                     // save in file

fullFileMeanPer = fullfile(PRG_PATH, "displaySignalAndMean.sci" );
exec(fullFileMeanPer); 


graph=displaySignalAndMean(DataRec,tBeg,tEnd,maxTime,blockDuration)


title(" BPM mean per block duration of 15min")           // Attention, if you change blockDuration, you must corrected title, xlabel, legend of the figure
xlabel("Time per 15min block")
ylabel("BPM")
legend("mean BPM (15min Block)",opt=4)
fnamePDF = fullfile(RES_PATH, "Figure 1 : BPM Recuperation (15min blocks)")
xs2pdf(scf(0),fnamePDF)           //save figure in RES folder
