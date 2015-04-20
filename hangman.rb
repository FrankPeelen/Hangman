puts "Welcome to Hangman!"

def random_word(min, max)
	words = File.open("5desk.txt", "r").readlines.select do |word|
		word.chomp!
		word.length <= max && word.length >= min
	end
	words[0 + rand(words.length)].upcase
end

def display_status
	guessed = @guessed_letters.dup
	print "\nWord: "
	game_over = true
	@secret_word.each_char do |letter|
		if guessed.include?(letter)
			print "#{letter} "
		else
			print "_ "
			game_over = false
		end
	end

	return "\n\nCongratulations, you have won!!" if game_over 

	misses = 0
	print "\nMisses: "
	guessed.chars.sort.each do |letter|
		unless @secret_word.include?(letter)
			print "#{letter} " 
			misses += 1
		end
	end
	print "\nGuesses: #{9 - misses}"

	return "\n\nYou have lost" if misses == 9

	return nil
end

def ask_input
	puts "\n\nPlease enter a single letter for your next guess:"

	loop do
		input = gets.chomp
		input.scan(/[[:alpha:]]/) { |char|
			return char.upcase unless char.nil? || @guessed_letters.include?(char.upcase)
		} unless input.length != 1

		puts "Your input was unacceptable. Please enter a single letter that you have not guessed yet."
	end
end


@secret_word = random_word(5, 12)
@guessed_letters = ""

display_status

won = nil
while won.nil?
	@guessed_letters += ask_input
	won = display_status
end

puts won
puts "The secret word was: #{@secret_word}"
