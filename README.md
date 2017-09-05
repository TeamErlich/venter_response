

In R:
source('no_face_value.R')
success_rate = test_venter(rounds, n)

n is the number of people in each group
rounds is the number of simulation rounds.
success_rate is the identifiability power of demographic iddentifiers

The function runs a simple procedure that matches the Venter et al.
definition of identifiability.
In each round, the function genreates sex, age, and self-reported ethnicity labels for n people according to the distributions of the Venter paper. It then takes the first person to be the person of interest and compares whether this person is unique in the n people. If the combination of labels for this person is unique, it says: "Success!"

Venter had a team of 30 researchers that developed fancy face morphology predictions, voice signatures, and many other sophisticated algorithms. Using the same success creterion as above, they reported a success rate of 80% fof a group of n=10.

You are about to test a reidentiability procedure that uses age, sex, and ethnic group. These data labels are not protected by HIPAA and took me less than an hour to develop. Try running test_venter(1000, 10) and see the success rate of my simple procedure.




