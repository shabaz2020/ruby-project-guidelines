class CommandLineInterface
    attr_accessor :session

    def initialize
        @session = nil
    end

    #command line scripts
    def greet 
        puts "Welcome! please enter your user ID number to login, or 'new' to create an account"
        User.list _users
        parse_greet_input
        puts "Hi, #{session.current_user.name}, please select an option to continue"
        main_menu_options
    end

    def parse_greet_input
        input = gets.chomp
        if input.downcase == "new"
            puts "A account is needed to create a new user avvount, enter your user ID:"
            goodreads_id = gets.chomp
            user_hash = User.get_user_data_from_goodreads_id(goodreads_id)
            session.current_user = User.find_or_create_user_from_hash(user_hash)
        elsif input.to_i.to_s == input
            session.current_user = User.find(input)
        elsif input.downcase == "exit"
            bye
        else
            puts "Enter a valid command"
            parse_greet_input
        end
    end

    def main_menu_options
        puts "1. Find a book by title"
        puts "2. FInd an author by name"
        puts "3. FInd your reviewed books"
        parse_main_menu_input
    end

    def parse_main_menu_input
        input = gets.chomp
        case input 
        when "1" then main_find_book_by_title
        when "2" then main_find_author_by_name
        when "3" then main_find_user_reviewed_books
        else
            puts "Please enter a valid command"
            parse_main_menu_input
        end
    end

    def main_find_books_by_title
        puts "Please enter the book title you are searching for:"
        input = gets.chomp
        session.current_book = Book.all.find_by title: input
        unless session.current_book
            puts "#{input} not found in database, would you like to add it from Goodreads? (y/n)"
            choice = gets.chomp.downcase
            if choice == 'y'
                new_book_id = Book.create_book_from_goodreads_id(new_book_id)
            else
                main_menu_options
            end
        end
        book_menu_options
    end

    def book_menu_options
        book = session.current_book
        puts "#{book.title} by #{book.author.name}, published #{book.published_date} by #{book.publisher}"
        puts "Average rating: #{book.average_rating} Total ratings: #{book.ratings_count}"
        puts "Summary: #{book.descreption}\n\n"
        puts "1. Open #{book.title}'s Goodreads page"
        puts "2. View or add your review for #{book.title}"
        puts "Enter 'logout' to log out of your account or 'exit' to exit MediocreReads"
        parse_main_menu_input
    end

    def parse_book_menu_input
        input = gets.chomp.downcase
        case input 
        when "1" then
            system "open #{session.current_book.goodreads_url}"
            puts "Enter 'back' to go to the previous menu or '2' to view or add a review for this book"
            parse_book_menu_input
        when '2' then find_or_add_review
        when 'logout' then logout
        when 'exit' then goodbye
        when 'back'
            session.current_book = nil
            main_menu_options
        else
            puts "Enter a valid option"
            parse_book_menu_input
        end
    end
    
    def 
 