require "./ascii-art.rb"


class HangmanGame
    attr_reader :words
    attr_reader :choosen_word
    attr_reader :word_state
    attr_reader :lives

    MENU_OPTIONS = {
        "1" => "Start new game",
        "2" => "Load game",
        "3" => "Exit"
    }

    def initialize
        read_words
        @lives = 5
    end

    def start
        print_menu
        
        print "Enter option: "
        user_input = read_menu_option

        case user_input
        when "1"
            main_game_loop
        when "2"
            raise NotImplementedError
        end
    end

    private

    def read_words
        file_text = File.read("./google-10000-english-no-swears.txt")
        @words = filter_words(file_text)
    end

    def filter_words text
        text.split.filter { |word| word.length >= 5 && word.length <= 12}
    end

    def pick_word
        @choosen_word = @words.sample(1)[0].downcase
        @word_state = Array.new(@choosen_word.length) { "_" }
    end

    def print_menu
        system "clear"
        puts AsciiArt::HANGMAN_LOGO
        MENU_OPTIONS.each_pair { |number, text| puts "#{number}. #{text}" }
    end

    def read_menu_option
        loop do
            choice = gets.chomp
            return choice unless !MENU_OPTIONS.keys.include? choice
            puts "Invalid menu option."
            print "Enter option again: "
        end
    end

    def read_user_input
        print "Lives remaining: #{@lives}"
        print "\nEnter a letter, or \"exit\" to save and exit: "
        gets.chomp.downcase
    end

    def main_game_loop
        pick_word

        loop do

            system "clear"

            puts AsciiArt::HANGMAN_LOGO

            puts "Pssst! word is \"#{@choosen_word}\""

            print_word_state

            if @lives < 1
                print "\nGAME OVER!\n"
                break
            end

            user_input = read_user_input

            if user_input == "exit"
                raise NotImplementedError
            else
                letter = user_input[0]
                process_letter letter

            end
        end
    end

    def print_word_state
        print "#{@word_state.join(" ")}\n\n"
    end

    def process_letter chosen_letter
        match = false
        @choosen_word.split("").each_with_index do |letter, index|
            if letter == chosen_letter && @word_state[index] == "_"
                @word_state[index] = chosen_letter
                match = true
            end
        end

        if !match
            @lives -= 1
        end
    end
end
