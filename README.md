# AlgoHIIT

## Context

With the progress and development of connected watchs and heart rate monitors (watchs / bands), the number of studies using these technologies has increased since 20s.

In sports science, these technologies are useful for both researchers and research students who want to monitor heart rate.
Among the most commonly tested exercise programs with both health and performance benefits, HIIT (High Intensity Intervals Training) stands out.

Therefore, to facilitate the analysis of data from a HIIT session from a heart rate monitor (watch / band), I created AlgoHIIT.

## Aims of this study are:

To make you an overall BPM view of your session

AlgoHIIT is divised into 3 separates programs which works both separatly or together as you want.

AlgoHIIT is made for a Polar H10/ Polar Watchs (V/M) and make differents measures and graphics as : 

* The entire condition
* During each intervall (effort high/rest)
* Overview of your time above YOUR BPM zone of interest during your HIIT
* Your max BPM reach during HIIT
* During post effort time
* A graphic representation of your global condition, effort and post effort with mean of your BPM reached during global condition
* A smoother graphic of the global condition with 
* A graphic representation of your HIIT only with 

These data tells you more about your vascular stress, an overall cinetic of your recuperation and if you are reach -or not- your goal in BPM terms.
	
	AlgoHIIT file grouping : 
	
	* `DAT` : data extracted from Polar setup and convert into .csv
	* `PRG` : HIIT, GlobalCondition and RecuperationPostHIIT script and function include in the script 
	* `RES` : Graphic and results report.
	      

## Usage

* Clone or download the repository
* On your computer, open `GlobalCondition.sce` then run the script with F5 or click the button with grey triangle to make an overview of your HIIT protocol + Recuperation post HIIT in terms of BPM
* On your computer, open `HIIT.sce` then run the script with F5 or click the button with grey triangle to make an overview of your HIIT protocol in terms of BPM
* On your computer, open `RecuperationPostHIIT.sce` then run the script with F5 or click the button with grey triangle to make an overview of your recuperation after your HIIT protocol in terms of BPM.

## Examples of display you can have with AlgoHIIT

## GlobalCondition Part

![](https://github.com/Axelvgtf/AlgoHIIT/blob/main/Global%20Condition.png)

## HIIT Part 

![](https://github.com/Axelvgtf/AlgoHIIT/blob/main/HIIT.png)

** Recuperation Part

![](https://github.com/Axelvgtf/AlgoHIIT/blob/main/Recuperation.png)
	  
## Notes 
	  
* Install [Scilab](https://www.scilab.org) scilab on your computer, For mac Users: click [here](https://www.utc.fr/~mottelet/scilab_for_macOS.html)

* Please, convert your .xls or .xlsx data from Polar H10 in .csv and drag it in `DAT`
* The .csv file must be with the first colum is time in seconds and the thirs colums is your BPM recorded by your Polar H10

* Do not modify the names and organisation of the directories.
  The `DAT`+`PRG`+`RES` structure is expected when initialising in `InitTRT.sce`
  
* You should modify in HIIT.sce at line 42 YOUR max BPM and line 43 the coefficient of your BPM zone of interest during Effort 
* Also, you should modify the time of warm-up and effort in `HIIT.sce` (line 54,60), `GlobalCondition.sce` (line 58,64) and `RecuperationPostHIIT.sce` (line 44)


Don't hesitate to tell me if you have any issues with the algorithm or if you want help to make it better 

Enjoy :)

-Axelvgtf
