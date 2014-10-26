get_clean_data
==============

Getting &amp; Cleaning Data - Course 3 of Data Science Track

This script and output data is sourced from the "Human Activity Recognition Using Smartphones Data Set" (see 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The Human Activity Recognition database is built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

======= Required Libraries ============<br>
1. dplyr<br>
2. data.table<br>

======== Citation =========<br>
Bache, K. & Lichman, M. (2013). UCI Machine Learning Repository [http://archive.ics.uci.edu/ml]. Irvine, CA: University of California, School of Information and Computer Science.

======= CodeBook ========<br>
See "An Adaptation of UCI HAR Dataset - CodeBook.pdf" for information on how the UCI HAR Dataset has been transformed and for details on the dataset produced by the run_analysis.R script.

======= Output Dataset ========= <br>
UCIHAR.csv

======= Process Steps ========<br>
1. Download zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip<br>
2. Unzip contents to working directory as folder "UCI HAR Dataset"<br>
3. Load and run "run_analysis.R"

======= run_analysis.R Steps ========== <br>
1.	Set working directory<br>
2.	Load libraries <br>
3.	Read in activity labels (walking, etc.) and label the columns of the labels <br>
4.	Read in the features table (e.g. fBodyAccMag-std())<br>
5.	For Training Observations<br>
&nbsp;&nbsp;	a.	Read in the subject list which matches row for row with the features detail table in the x_train.txt table<br>
&nbsp;&nbsp;	b.	Apply column name to subject data<br>
&nbsp;&nbsp;	c.	Read in the features detail table for the training observations<br>
&nbsp;&nbsp;	d.	Apply the feature names to the feature detail table<br>
&nbsp;&nbsp;	e.	Create a table with only the mean and standard deviation columns from the raw table<br>
&nbsp;&nbsp;	f.	Read in the activity list and assign the column name<br>
&nbsp;&nbsp;	g.	Assign activity id to the detail dataset, activity ID is repeated over and over until it labels all the rows<br>
&nbsp;&nbsp;	h.	Add a column with the activity labels, merge will join on like-named column, activity_id<br>
6.	Repeat steps with test observations<br>
7.	Merge training and test observations<br>
8.	Rename columns to prepare "tidy" dataset<br>
9.	Remove Activity_ID and move activitydescription column to second column<br>
10.	Run the mean for all the variables grouping by subjectidentifier, activitydescription<br>
11.	Write tidy dataset out to csv file<br>


======= Author/Contact =========<br>
Script, codebook, and readme constructed by Robin Yeldell (robin@yeldell.com).
