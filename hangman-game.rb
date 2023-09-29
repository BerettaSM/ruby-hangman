class HangmanGame
    attr_reader :words

    def initialize
        read_words
        
    end

    private

    def read_words
        file_text = File.read("./google-10000-english-no-swears.txt")
        @words = filter_words(file_text)
    end

    def filter_words text
        text.split.filter { |word| word.length >= 5 && word.length <= 12}
    end
end
