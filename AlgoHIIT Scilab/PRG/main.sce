// Copyright (C) 2022 - Corporation - Author
//
// About your license if you have any
//
// Date of creation: 22 févr. 2022
//
// Copyright (C) 2022 - University of Montpellier - NIERDING Axel
//
//
// Date of creation: 9 févr. 2022
//
// **** FIRST : Initialize ****
clear
clc
PRG_PATH = get_absolute_file_path("main.sce");          
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
//Plot the HIIT4 condition to get an idea of the condition in terms of BPM during each blocks and the recuperation post effort

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



////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//CALCULATE THE MEAN PER 1 MINUTES (60 seconds) BLOCK DURING EFFORT'S PERIOD 

fullFileMeanPer = fullfile(PRG_PATH, "dataMeanOverPeriod.sci" );
exec(fullFileMeanPer); 
maxTime = max(DataEff(:,1));      // Set the last second of recording 
blockDurationEff = 60;             // Duration of the block in seconds
blockDurationRest = 60
tBeg = 0 + DataEff(1,1);         // Start of the first period
tEnd = blockDurationEff + DataEff(1,1);       // End of the first period

//
n=1                             // Will define a row number in meanValues
while tEnd < maxTime         // Create an iterative loop, as long as tEnd < maxTime  
    meanValues1min (n,1) = dataMeanOverPeriod(DataEff,tBeg,tEnd) // calculates the mean values for each block and implements, in meanValues, the new mean at each loop 
    tBeg  =  tBeg + blockDurationEff // redefine the beginning of each block at each loop
    tEnd  = tEnd + blockDurationEff + blockDurationRest   // redefine the end of each block at each loop
    n = n + 1                 // Add an extra line to meanValue at each loop
end

disp("Average Values of BPM per 1 min block", meanValues1min)// You can change the name of variable with your intervall time and the text

fullFileName = (RES_PATH + "/Mean_Values_1min.csv");    // Define the path and the file name
print(fullFileName,meanValues1min)                     // save in file


//plot(DataEff(:,1),meanValues4min)

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
    meanValues20s (n,1) = dataMeanOverPeriod(DataEff,tBeg,tEnd) // calculates the mean values for each block and implements, in meanValues, the new mean at each loop 
    tBeg  =  tBeg + blockDuration // redefine the beginning of each block at each loop
    tEnd  = tEnd + blockDuration  // redefine the end of each block at each loop
    n = n + 1                 // Add an extra line to meanValue at each loop
end

disp("Average Values of BPM per 20 s block", meanValues20s)// ibid than line 109

fullFileName = (RES_PATH + "/Mean_Values_20seconds.csv");    // Define the path and the file name
print(fullFileName,meanValues20s)                     // save in file

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
maxTime = max(Data(:,1));      // Set the last second of recording 
blockDuration = 900;             // Duration of the block in seconds
tBeg = (Data(highLimit,1));         // Start of the first period
tEnd = max(Data(:,1));       // End of the first period

//
n=1                             // Will define a row number in meanValues
while tBeg < maxTime         // Create an iterative loop, as long as tEnd < maxTime  
    meanValues15minPostEff (n,1) = dataMeanOverPeriod(Data,tBeg,tEnd) // calculates the mean values for each block and implements, in meanValues, the new mean at each loop 
    tBeg  =  tBeg + blockDuration // redefine the beginning of each block at each loop
    tEnd  = tEnd + blockDuration  // redefine the end of each block at each loop
    n = n + 1                 // Add an extra line to meanValue at each loop
end

disp("Average Values of BPM per 15 min block Post Effort corresponding to the recuperation period", meanValues15minPostEff)

fullFileName = (RES_PATH + "/Mean_Values_15min.csv");    // Define the path and the file name
print(fullFileName,meanValues15minPostEff)                     // save in file
