#### run the main function by typing:
# success_rate = test_venter(rounds, n)

#n is the number of people in each group
#rounds is the number of simulation rounds.
#success_rate is the identifiability power of demographic iddentifiers

# The function runs a simple procedure that matches the Venter et al.
# definition of identifiability.
# In each round, the function genreates sex, age, and self-reported ethnicity labels
# for n people according to the distributions of the Venter paper. 
# It then takes the first person to be the person of interest
# and compares whether this person is unique in the n people. 
# If the combination of labels for this person is unique, it says: "Success!"

# Venter had a team of 30 researchers that developed fancy face morphology predictions, 
# voice signatures, and many other sophisticated algorithms. Using the same success creterion, 
# they had a success rate of 80%.

# You are about to test a procedure that uses age, sex, and ethnic group which are not protected by 
#HIPAA and took me less than an hour to develop. 
# Try running test_venter(1000, 10)
# and see the success rate.


library(reshape)
freq <- function(x){
  return (x/sum(x))
}

inverse_cdf<-function(cdf) {
  p = runif(1, 0, 1)

  for (i in 1:length(cdf)) {
    if (p < cdf[i]) {
        return (i)
    }
  }
  return (length(cdf))
}




test_venter<-function(rounds, n) {
  #rounds: the number of times to run the procedure
  #n: the group of individuals to re-identify the sample
  
  #lading data
  male = c(381,	126,	39,	39,	8,	39)
  female = c(188, 147, 24, 24, 10, 36)
  people = data.frame(male,female)
  row.names(people) = c('African', 'European','Latino','East Asian','South Asian', 'Other')
  age = c(295, 190, 130, 90, 95, 120, 100, 35, 5, 1)
  
  #calculating pdfs
  people.freq = freq(people)
  age.freq = freq(age)
  
  people.freq_v = melt(people.freq) #table to a long vector
  people.cdf = cumsum(people.freq_v$value)
  age.cdf = cumsum(age.freq)
  
  
  success = 0
  #start sampling
  for (i in 1:rounds){
    #let draw n people from the distribution
    a_group_of_people = (simulate_a_group_of_people(n, people.cdf, age.cdf))
    our_person = a_group_of_people[1] # we decided arbitrarly that the person of interest is always first
    z = length(grep(our_person, a_group_of_people))
    
    if (z == 1) {
      success = success + 1
    }
  }
  return(success/rounds)
  
}


simulate_a_group_of_people<-function(n, people.cdf, age.cdf) {
  
  take_n_people = c()
  
  #let's generate a group of n people from Venter's cohort
  for (i in 1:n){
    sex_ethnicity_label = inverse_cdf(people.cdf)
    age_label =  inverse_cdf(age.cdf)
    final_label = paste(sex_ethnicity_label, age_label, sep='_')
    take_n_people = rbind(take_n_people, final_label)
  }
  colnames(take_n_people)[1] <- 'labels' #the name of the column
  return(take_n_people)
}

