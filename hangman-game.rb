require "./ascii-art.rb"


class HangmanGame
    attr_reader :words
    attr_reader :choosen_word
    attr_reader :word_state

    MENU_OPTIONS = {
        "1" => "Start new game",
        "2" => "Load game",
        "3" => "Exit"
    }

    def initialize
        read_words
    end

    def start
        print_menu
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
        puts(AsciiArt::HANGMAN_LOGO)
        MENU_OPTIONS.each_pair { |number, text| puts "#{number}. #{text}" }
    end

    def read_menu_option
        loop do
            choice = gets.chomp
            return choice unless !MENU_OPTIONS.keys.include? choice
            puts "Invalid menu option."
        end
    end

    def read_user_input
        print "\nEnter a letter: "
        gets.chomp[0].downcase
    end

    def main_game_loop
        pick_word
        print_word_state

        user_input = read_user_input
    end

    def print_word_state
        puts @word_state.join(" ")
    end
end
