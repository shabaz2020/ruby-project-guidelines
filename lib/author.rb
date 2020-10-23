class Author < ActiveRecord::Base
    has_many :books
    has_many :reviews, through: :books
    has_many :genres, through: :books
    #self.find good_reads or create by id  
    def self.find_or_create_by_id(goodreads_id)
        author = Author.find_by goodreads_id: goodreads_id
        if !author
            author = RestClient.get("https://www.goodreads.com/author/show/#{goodreads_id}?format=xml&key=8dQUUUZ8wokkPMjjn2oRxA")
            author_hash = Nokogiri::XML(author)
            author_name = author_hash.css("name").first.text
            author_goodreads_url = author_hash.css("link").first.text
            author = Author.create(name: author_name, goodreads_id: goodreads_id, goodreads_url)
            puts "Adding author and books to database"
            author.add_books_for_new_author(author_hash, author)
        end
        author 
    end

    #good_reads search 
    def self.create_by_goodreads_search(name)
        xml_url = url.split("?")[0] + "?format=xml&key=8dQUUUZ8wokkPMjjn2oRxA"
        author_data = RestClient.get(xml_url)
        author_hash = Nokogiri::XML(author_data)
        author_name = author_hash.css("name").fisrt.text
        goodreads_id = author.hash.css("id").first.text
        goodreads_url = author_hash.css("link").first.text
        author = Author.create(name: author_name, goodreads_id: goodreads_id, goodreads_url: goodreads_url)
        author.add_books_for_new_author(author_hash, author)
    end

    def self.find_url_by_goodreads_search(name)
        formatted_name = name.gsub(" ", "%20")
        results = RestClient.get("https://www.goodreads.com/api/author_url/#{formatted_name}?key=8dQUUUZ8wokkPMjjn2oRxA")
        results_hash = Nokogiri::XML(results)
        url = results_hash.css("author").first.children.css("link").text
    end
    # if the book count is less than 30 count to 1 
    def author_books_pages_count(books_count)
        bookc = books_count.to_i
        if bookc <= 30
            1
        elsif bookc < 30&& bookc <= 60
            2
        else
            3
        end
    end

    #author_hash and instance create an array and get the RestClien 
    def add_books_for_new_author(author_hash, author_instance)
        author_books_pages = author_books_pages_count(author_hash.css("works_count").first.text)
        i = 0
        books_array = []
        author_books_pages.times do
            i += 1
            books = RestClient.get("https://www.goodreads.com/author/list/#{author_instance.goodreads_id}?format=xml&page=#{i}&key=8dQUUUZ8wokkPMjjn2oRxA")
            books_hash.css("book").each do |book|
                books_urls_array << book.children.css("link").first.text
            end
            books_urls_array.each do |url|
                Book.create_book_from_author_and_url(url, author_instance)
            end
            books_array = []
        end
        author_instance
    end
    
    #this is for the avg book rating
    def average_books_rating
        total = 0
        if books.empty?
            return "n/a"
        else
            books.each do |book|
                total += book.average_rating 
            end
        end
        (total / books.count).round(2)
    end

    def most_reviewed_books
        books.sort_by(&:ratings_count)
    end

end