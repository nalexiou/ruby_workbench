#simple array
poem_words = [ 'twinkle', 'little', 'star', 'how', 'I', 'wonder' ]
#simple array shortcut
poem_words = %w{ twinkle little star how I wonder }

#multiple arguments passed - position independent)
def echo_at_least_two( first_arg, *middle_args, last_arg )
  puts "The first argument is #{first_arg}"
  middle_args.each { |arg|puts "A middle argument is #{arg}" }
  puts "The last argument is #{last_arg}"
end

#this works when names is an array
def add_authors( names )
  @author += " #{names.join(' ')}"
end

#this is better - splat operation (Exploding the array)

def add_authors( *names )
  @author += " #{names.join(' ')}"
end

#hash parameter example
load_font( { :name => 'times roman', :size => 12 })
#can be shorten to this
load_font( :name => 'times roman', :size => 12 )
#can be further shorten to this
load_font :name => 'times roman', :size => 12

#arbitrary quote mechanism same as using single quotes (note lower case q)
str = %q{I said "I cannot deal with 's and "s."}
#arbitrary quote mechanism same as using double quotes (note upper case Q)
str = %Q<The is now #{Time.now}>

#here document example spans over multiple lines
heres_one = <<EOF
This is the beginning of my here document.
And this is the end.
EOF

#strings are collections of things
str.each_char #collection of characters
str.each_byte #collection of bytes
str.each_line #collection of lines

#strings are mutable data structures
first_name = "Nick"
given_name = first_name
first_name = "Some other name" #this changes given_name as well

#regex for ruby - this matches beginning of line, end and new lines for the askerisk (/m modifier)
/^Once upon a time.*hapilly ever after\.$/m

#classes and objects in ruby
class Document
	# A method
	def words
		@content.split
	end
	# And another one
 	def word_count
		words.size
 	end
	#example of self
 	def about_me
		puts "I am #{self}"
		puts "My title is #{self.title}"
		puts "I have #{self.word_count} words"
	end
end
#everything is a class
-3.abs
"abc".upcase
:abc.length
/abc/.class
true.class
false.nil?
nil.class

#simple irb loop
while true
  print "Cmd> "
  cmd = gets
  puts( eval( cmd ) )
end

#private methods
class Document
  # Most of the class omitted
	private  # Methods are private starting here
	def word_count
		return words.size
	end 
end

class Document
  # Most of the class omitted
	def word_count
		return words.size
	end
	private :word_count
end


class Document
  # Most of the class omitted...
	def word_count
		return words.size
	end
	private :word_count
  # This method works because self is the right thing,
  # the document instance, when you call it.
	def print_word_count
		n = word_count
		puts "The number of words is #{word_count}"
	end
end

#clean and precise code - ruby uses dynamic typing/extreme decoupling
class Document
  # Body of the class unchanged...
end
class LazyDocument
  # Body of the class unchanged...
end

class Title
	attr_reader :long_name, :short_name
	attr_reader :isbn
	def initialize(long_name, short_name, isbn)
		@long_name = long_name
		@short_name = short_name
		@isbn = isbn
	end 
end

class Author
	attr_reader :first_name, :last_name
	def initialize( first_name, last_name )
		@first_name = first_name
		@last_name = last_name
	end 
end

#this will still work - nothing to change in Document class
two_cities = Title.new( 'A Tale Of Two Cities',
                        '2 Cities', '0-999-99999-9' )
dickens = Author.new( 'Charles', 'Dickens' )
doc = Document.new( two_cities, dickens, 'It was the best...' )

#don't do this!
def initialize( title, author, content )
  raise "title isn't a String" unless title.kind_of? String
  raise "author isn't a String" unless author.kind_of? String
  raise "content isn't a String" unless content.kind_of? String
  @title = title
  @author = author
  @content = content
end

#don't do this!
def initialize( String title, String author, String content )
	
#don't do this!
class Doc
	attr_accessor :ttl, :au, :c
		def initialize(ttl, au, c)
		@ttl = ttl; @au = au; @c = c
	end
  def wds;  @c.split; end
end
