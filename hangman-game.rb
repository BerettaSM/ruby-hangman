require "./ascii-art.rb"


class HangmanGame
    attr_reader :words
    attr_reader :choosen_word

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
        user_input = read_input MENU_OPTIONS.keys, "Invalid menu option."
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
    end

    def print_menu
        system "clear"
        puts(AsciiArt::HANGMAN_LOGO)
        MENU_OPTIONS.each_pair { |number, text| puts "#{number}. #{text}" }
    end

    def read_input valid_choices, err_message
        loop do
            choice = gets.chomp
            return choice unless !valid_choices.include? choice
            puts err_message
        end
    end
end
