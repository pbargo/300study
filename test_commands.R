mydata <- read.csv('subject_info_Lab_DRS_data_json.csv', header = TRUE)
boxplot(SubjectID~Ethnicity,data = mydata)

