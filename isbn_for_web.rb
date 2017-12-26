#This program checks a number to see if it follows the requirements for a valid ISBN number
#It starts by defining two functions that are used if the number has either 10 or 13 digits as required for valid numbers
#further down the program it calls one of the functions depending on the number length or aborts the program if the number is neither 10 or 13 digits long
require "sinatra"
#enable :sessions
#sessions[:name] = 'Matt'
get '/' do
    erb  :isbnhome  #calls the erb file isbnhome.erb that is stored in the views folder
end

post '/validate' do

	redirect '/validate?number=' + params[:a_number] 
 	 #assigns the value in 'a_number' to 'number' 
 
end
 
get '/validate' do

@number = params[:number] #creates a variable from the number input
@split_text = @number.split('') #creates a string aray containing the isbn number


@isx = @split_text.last #creates isx that copies the last value of the array

if @isx == "x" #evaluates if the last value of the array is an'x'
 	split_integer = @number.split("").map(&:to_i) #splits the isbn_number into an array of integers

	remove = split_integer.pop #removes the last value of the array, the 'x' 
	@isbn_array = split_integer + [10] #creates the isbn_array by adding a 10 to the end of the split_integer array

else
@isbn_array = @number.split("").map(&:to_i) #if isbn_number does not contain an x this step creates isbn_array containing integers directly from isbn_number

end #ends the if statement


def isbn10(isbn_array) #defines a function used to check a 10 digit number
	counter= 0 #establishes a counter
	total10 = 0 #establishes a check number total
	10.times do #initiates a loop through the 10 digit number
		number  = @isbn_array[counter] #pulls number from the isbn array based on its aray location
		total10 = total10 + (number*(counter+1)) #does multiplication and adds product to total10
		counter = counter +1 #updates counter
	end #ends do loop

	#print "The check total is #{total10}.  \n \n" #prints total10
	if 0 == total10%11 #performs check to see if total10 is evenly divisible by 11 and prints accordingly

	@outcome = "It is a valid 10-digit ISBN number.  \n \n" #creates @outcome that will be forwarded to isbnreport.erb
	else
	@outcome = 	"It is NOT a valid 10-digit ISBN number.  \n \n"	#creates @outcome that will be forwarded to isbnreport.erb
	end #ends if statement
end #ends the isbn10 function

def isbn13(isbn_array) #defines a function to evaluate a 13 dogot number
 	counter= 0 #establishes a counter
 	total13 = 0#establishes a check total
 	multiples_array = [1,3,1,3,1,3,1,3,1,3,1,3,1] #creates array of values to multiply by the 13 digits
 	13.times do #initiates a loop through the 13 digit number
 		number  = @isbn_array[counter] #pulls a number from the isbn array based on its array location
 		multiplier = multiples_array[counter] #pulls a number from the multiples array 
 		total13 = total13 + (number * multiplier) #calculates product of digit and multiplier and adds to total13
 		counter += 1 #updates counter
 	end #ends loop
	

 	if 0 == total13%10 #evaluates if total13 is evenly divisible by 10 and prints output acdordingly
 		@outcome = "It is a valid 13-digit ISBN number.  \n \n" #creates @outcome that will be forwarded to isbnreport.erb
 	else
 		@outcome = 	"It is NOT a valid 13-digit ISBN number.  \n \n" #creates @outcome that will be forwarded to isbnreport.erb
 	end #ends if statement
	
 end #ends the isbn13 function




@digcount = @isbn_array.count #counts the digits in @isbn_arrY

if @digcount == 10 #checks to see if 10 digits are in the number
	@ok = "This number is an acceptable length \n \n" #creates appropriate @ok message to forward to isbnreport.erb
  	isbn10(@isbn_array) #calls the isbn10 function to further evaluate the number
elsif @digcount == 13 #if number is not 10 digits it checks to see if it is 13 digits
	@ok = "This number is an acceptable length" #creates appropriate @ok message to forward to isbnreport.erb
# # 	print "This number is an acceptable length \n \n" #if 13 digits it accepts the number
  	isbn13(@isbn_array)	#calls the isbn13 function to further evaluate the number
else 
	@ok = "This number is NOT the proper length" # 	#creates appropriate @ok message to forward to isbnreport.erb
end



	
    erb :isbnreport, :locals => {:your_number => params[:number]}
#     								  #calls isbnreport.erb and assigns the text 
#    																	  #in 'number' to the variable 'your_number' 
#    																	  #which is needed in show _sandwich.erb 	
end #ends the get started on oine 18