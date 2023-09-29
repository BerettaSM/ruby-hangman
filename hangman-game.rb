class HangmanGame
    attr_reader :words

    def initialize
        read_words
    end

    private

    def read_words
        file_text = File.read("./google-10000-english-no-swears.txt")
        @words = file_text
    end

end
