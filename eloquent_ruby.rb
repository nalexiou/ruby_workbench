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


#moving onto testing
def test_document_holds_onto_contents
	text = 'A bunch of words'
	doc = Document.new('test', 'nobody', text)
	assert_equal text, doc.content, 'Contents are still there'
end

#complete initial test example

require 'test/unit'
require 'document.rb'
class DocumentTest < Test::Unit::TestCase
	def test_document_holds_onto_contents
		text = 'A bunch of words'
		doc = Document.new('test', 'nobody', text)
		assert_equal text, doc.content, 'Contents are still there'
	end
	def test_that_doc_can_return_words_in_array
		text = 'A bunch of words'
		doc = Document.new('test', 'nobody', text)
		assert doc.words.include?( 'A' )
		assert doc.words.include?( 'bunch' )
		assert doc.words.include?( 'of' )
		assert doc.words.include?( 'words' )
	end
	def test_that_word_count_is_correct
		text = 'A bunch of words'
		doc = Document.new('test', 'nobody', text)
		assert_equal 4, doc.word_count, 'Word count is correct'
	end 
end

#better test with setup

class DocumentTest < Test::Unit::TestCase
	def setup
		@text = 'A bunch of words'
		@doc = Document.new('test', 'nobody', @text)
	end
	def test_that_document_holds_onto_contents
		assert_equal @text, @doc.content, 'Contents are still there'
	end
	def test_that_doc_can_return_words_in_array
		assert @doc.words.include?( 'A' )
		assert @doc.words.include?( 'bunch' )
		assert @doc.words.include?( 'of' )
		assert @doc.words.include?( 'words' )
	end
	def test_that_word_count_is_correct
		assert_equal 4, @doc.word_count, 'Word count is correct'
	end 
end

#same test in RSpec
describe Document do
	it 'should hold on to the contents' do
		text = 'A bunch of words'
		doc = Document.new( 'test', 'nobody', text )
		doc.content.should == text
	end
		it 'should return all of the words in the document' do
		text = 'A bunch of words'
		doc = Document.new( 'test', 'nobody', text )
		doc.words.include?( 'A' ).should == true
		doc.words.include?( 'bunch' ).should == true
		doc.words.include?( 'of' ).should == true
		doc.words.include?( 'words' ).should == true
	end
	it 'should know how many words it contains' do
		text = 'A bunch of words'
		doc = Document.new( 'test', 'nobody', text )
		doc.word_count.should == 4
	end 
end

#shorter RSpec version
require 'document'
	describe Document do
		before :each do
		@text = 'A bunch of words'
		@doc = Document.new( 'test', 'nobody', @text )
	end
	it 'should hold on to the contents' do
		@doc.content.should == @text
	end
	it 'should know which words it has' do
		@doc.words.should include( 'A' )
		@doc.words.should include( 'bunch' )
		@doc.words.should include( 'of' )
		@doc.words.should include( 'words' )
	end
	it 'should know how many words it contains' do
		@doc.word_count.should == 4
	end 
end

#stub example
describe PrintableDocument do
	before :each do
		@text = 'A bunch of words'
		@doc = PrintableDocument.new( 'test', 'nobody', @text )
	end
	it 'should know how to print itself' do
		stub_printer = stub :available? => true, :render => nil
		@doc.print( stub_printer ).should == 'Done' 
	end
	it 'should return the proper string if printer is offline' do
		stub_printer = stub :available? => false, :render => nil
		@doc.print( stub_printer ).should == 'Printer unavailable' 
	end
end

#stub! example
apparently_long_string = 'actually short'
apparently_long_string.stub!( :length ).and_return( 1000000 )

#mock example
it 'should know how to print itself' do
	mock_printer = mock('Printer')
	mock_printer.should_receive(:available?).and_return(true)
	mock_printer.should_receive(:render).exactly(3).times
	@doc.print( mock_printer ).should == 'Done'
end

#ruby classes and methods
#simple compressing/archiving code
class TextCompressor
	attr_reader :unique, :index
	def initialize( text )
		@unique = []
		@index = []
		words = text.split
		words.each do |word|
			i = @unique.index( word )
			if i
				@index << i
			else
			    @unique << word
			    @index << unique.size - 1
			end
		end 
	end
end

#improved version
class TextCompressor
	attr_reader :unique, :index
	def initialize( text )
		@unique = []
		@index = []
		words = text.split
		words.each do |word|
			i = @unique_index_of( word )
			if i
				@index << i
			else
			    @index << add_unique_word( word )
			end
		end 
	end

	def unique_index_of( word)
		@unique.index(word)
	end

	def add_unique_word(word)
		@unique << word
		unique.size - 1
	end
end

#another shot
class TextCompressor
	attr_reader :unique, :index

	def initialize( text )
		@unique = []
		@index = []
		add_text( text )
	end

	def add_text( text )
		words = text.split
		words.each { |word| add_word ( word ) }
	end

	def add_word ( word )
			i = @unique_index_of( word ) || add_unique_word( word )
				@index << i
	end

	def unique_index_of( word)
		@unique.index(word)
	end

	def add_unique_word(word)
		@unique << word
		unique.size - 1
	end
end

#sample test for comp


describe TextCompressor do
	it "should be able to add some text" do
		c = TextCompressor.new( '' )
		c.add_text( 'first second' )
		c.unique.should == [ 'first', 'second' ]
		c.index.should == [ 0, 1 ]
	end
	it "should be able to add a word" do
		c = TextCompressor.new( '' )
		c.add_word( 'first' )
		c.unique.should == [ 'first' ]
		c.index.should == [ 0 ]
	end
	it "should be able to find the index of a word" do
		c = TextCompressor.new( 'hello world' )
		c.unique_index_of( 'hello' ).should == 0
		c.unique_index_of( 'world' ).should == 1
	end
end

#user-defined operators
class Document
  # Most of the class omitted...
	def +(other)
		Document.new( title, author, "#{content} #{other.content}" )
	end
end

#now we can do this!
doc1 = Document.new('Tag Line1', 'Kirk', "These are the voyages")
doc2 = Document.new('Tag Line2', 'Kirk', "of the star ship ...")
total_document = doc1 + doc2
puts total_document.content #prints: These are the voyages of the star ship ...

#user-defined ! operator

class Document
  # Stuff omitted...
	def !
	Document.new( title, author, "It is not true: #{content}")
	end 
end

favorite = Document.new( 'Favorite', 'Russ', 'Chocolate is best')

!favorite # will print: It is not true: Chocolate is the best

#unary operator
class Document
# Most of the class taking a break...
	def +@
		Document.new( title, author, "I am sure that #{@content}" )
	end
	def -@
		Document.new( title, author, "I doubt that #{@content}" )
	end 
end

favorite = Document.new('Favorite', 'Russ', 'Chocolate is best')
unsure = -(+favorite) #unsure will be: I doubt that I am sure that Chocolate is best

#ruby equality operators

#we could do this...
class DocumentIdentifier
	attr_reader :folder, :name
	def initialize( folder, name )
		@folder = folder
		@name = name
	end
	def ==(other)
		return true if other.equal?(self)
		return false unless other.kind_of?(self.class)
		folder == other.folder && name == other.name
	end 
end

class ContractIdentifier < DocumentIdentifier
end

doc_id =  DocumentIdentifier.new( 'contracts', 'Book Deal' )
con_id =  ContractIdentifier.new( 'contracts', 'Book Deal' )

#then using ==

doc_id == con_id #this will return true

#this is a little better
class DocumentPointer
	attr_reader :folder, :name
	def initialize( folder, name )
		@folder = folder
		@name = name
	end
	def ==(other)
		return false unless other.respond_to?(:folder) 
		return false unless other.respond_to?(:name) 
		folder == other.folder && name == other.name
	end 
end

#watch out for assymetry!

doc_id = DocumentIdentifier.new( 'secret/area51', 'phone list' )
pointer = DocumentPointer .new('secret/area51', 'phone list' )

pointer == doc_id # True
doc_id == pointer # Not True

#equality user-defined for hash
class DocumentIdentifier
  # Code omitted...
	def hash
		folder.hash ^ name.hash
	end
	def eql?(other)
		return false unless other.instance_of?(self.class)
		folder == other.folder && name == other.name
	end
end

#singleton methods - define: instance.method_name

hand_built_stub_printer = Object.new
def hand_built_stub_printer.available?
	true 
end
def hand_built_stub_printer.render( content )
	nil 
end

#alternate definition
class << hand_built_stub_printer
	def available?
		true
	end
	def render
		nil
	end
end

#class methods are Singleton methods!
def Document.explain
  puts "self is #{self}"
  puts "and its class is #{self.class}"
end

#class instance variables
class Document
	@default_font = :times
	class << self
		attr_accessor :default_font
	end
# Rest of the class omitted...
end

#modules as name spaces
