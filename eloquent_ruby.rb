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

module Rendering
	class Font
	attr_accessor :name, :weight, :size
	def initialize( name, weight=:normal, size=10 )
		@name = name
		@weight = weight
		@size = size
	end
    # Rest of the class omitted...
  end
	class PaperSize
	attr_accessor :name, :width, :height
		def initialize( name='US Let', width=8.5, height=11.0 )
			@name = name
			@width = width
			@height = height
		end
	# Rest of the class omitted...
	end
end

#To access font class, syntax is: Rendering::Font

#set constants in module
module Rendering
	# Font and PaperSize classes omitted...
	DEFAULT_FONT = Font.new( 'default' )
	DEFAULT_PAPER_SIZE = PaperSize.new
end

#To access constant, syntax is: Rendering::DEFAULT_FONT
#If you include the module (include Rendering), then you can access directly: DEFAULT_FONT

#Nested modules

module WordProcessor
		module Rendering
			class Font
			  # Guts of class omitted...
			end
			# and so on...
		end
end

#To access nested, syntax is: WordProcessor::Rendering::Font

#methods inside Modules

module WordProcessor
	def self.points_to_inches( points )
		points / 72.0
	end
	def self.inches_to_points( inches )
		inches * 72.0
	end
	# Rest of the module omitted
end

#Calling methods defined in modules
an_inch_full_of_points = WordProcessor.inches_to_points( 1.0 )
#this also works: WordProcessor::inches_to_points but is not preferred

#Treat modules as objects

#we can do this:

class TonsOTonerPrintQueue
	def submit( print_job )
	# Send the job off for printing to this laser printer...
	end
	def cancel( print_job)
	# Stop the print job on this laser printer...
	end 
end
class TonsOTonerAdministration
	def power_off
	# Turn this laser printer off...
	end
	def start_self_test
	# Test this laser printer...
	end 
end

class OceansOfInkPrintQueue
	def submit( print_job )
	# Send the job off for printing to this ink jet printer...
	end
	def cancel( print_job)
	# Stop the print job on this ink jet printer...
	end 
end
class OceansOfInkAdministration
	def power_off
	# Turn this ink jet printer off...
	end
	def start_self_test
	# Test this ink jet printer...
	end 
end

#A better way is to use modules:

module TonsOToner
	class PrintQueue
		def submit( print_job )
		  # Send the job off for printing to this laser printer
		end
		def cancel( print_job)
		  # Stop!
		end 
	end
	class Administration
		def power_off
		# Turn this laser printer off...
		end
		def start_self_test
		  # Everything ok?
		end 
	end
end

module OceansOfInk
	class PrintQueue
		def submit( print_job )
		# Send the job off for printing to this ink jet printer
		end
	# Rest omitted...
	end
	class Administration
	#  Ink jet administration code omitted...
	end 
end

#then we can do this:

	if use_laser_printer
	  print_module = TonsOToner
	else
	  print_module = OceansOfInk
	end
# Later...
	admin = print_module::Administration.new


#Modules as mixins
module WritingQuality
	CLICHES = [ /play fast and loose/,
	          /make no mistake/,
	          /does the trick/,
	          /off and running/,
	          /my way or the highway/ ]
	def number_of_cliches
		CLICHES.inject(0) do |count, phrase|
			count += 1 if phrase =~ content
			count 
		end
	end 
end

class Document
	include WritingQuality
	# Lots of stuff omitted...
end

class ElectronicBook < ElectronicText
	include WritingQuality
	# Lots of stuff omitted...
end

#Now, the number_of_cliches method becomes available in both classes
text = "my way or the highway does the trick"
my_tome = Document.new('Hackneyed', 'Russ', text)
puts my_tome.number_of_cliches

my_ebook = ElectronicBook.new( 'EHackneyed', 'Russ', text)
puts my_ebook.number_of_cliches

#mixins as class methods

module Finders
	def find_by_name( name )
	# Find a document by name...
	end
	def find_by_id( doc_id )
	# Find a document by id
	end 
end

class Document
  # Most of the class omitted...
	class << self
		include Finders
	end 
end

#shortcut for class methods (singleton)

class Document
  extend Finders
  # Most of the class omitted...
end

#Use Blocks to Iterate
def do_something_with_an_arg
	yield("Hello World") if block_given?
end
do_something_with_an_arg do |message|
	puts "The message is #{message}"
end

#this will print: The message is Hello World

class Document
	# Most of the class omitted...
	def each_word_pair
		word_array = words
		index = 0
		while index < (word_array.size-1)
			yield word_array[index], word_array[index+1]
		index += 1 
		end
	end 
end

doc = Document.new('Donuts', '?', 'I love donuts mmmm donuts' )
doc.each_word_pair{ |first, second| puts "#{first} #{second}" }

#this will print the following without generating a four-element array
I love
love donuts
donuts mmmm
mmmm donuts

#Iterators on steroid: Enumerable

class Document 
	include Enumerable
  # Most of the class omitted...
	def each
		words.each { |word| yield( word ) }
	end 
end

doc = Document.new('Advice', 'Harry', 'Go ahead make my day')

doc.include?("make") #returns true
doc.include?("Punk") #returns false


def each_word_pair
  words.each_cons(2) {|array| yield array[0], array[1] }
end

#going further: creating an enumerator instance
doc = Document.new('example', 'russ', "We are all characters")
enum = Enumerator.new( doc, :each_character )
#character count
puts enum.count

#sorted characters
pp enum.sort

#execute around block
class SomeApplication
		def do_something
			with_logging('load') { @doc = Document.load( 'resume.txt' ) }
			# Do something with the document...
			with_logging('save') { @doc.save } 
		end
		# Rest of the class omitted...
		def with_logging(description)
			begin
			  @logger.debug( "Starting #{description}" )
			  yield
			  @logger.debug( "Completed #{description}" )
			rescue
			  @logger.error( "#{description} failed!!")
			  raise
			end 
		end
end

#example of execute around to initialize class
class Document
	attr_accessor :title, :author, :content
	def initialize(title, author, content = '')
		@title = title
		@author = author
		@content = content
		yield( self ) if block_given?
	end
# Rest of the class omitted...
end

#passing block to a new class instance

new_doc = Document.new( 'US Constitution', 'Madison', '' ) do |d|
  d.content << 'We the people'
  d.content << 'In order to form a more perfect union'
  d.content << 'provide for the common defense'
end

#carrying answers back using block

def do_something_silly
  with_logging( 'Compute miles in a light year' ) do
    186000 * 60 * 60 * 24 * 365
  end
end

def with_logging(description)
	begin
		@logger.debug( "Starting #{description}" ) 
		return_value = yield
		@logger.debug( "Completed #{description}" ) 
		return_value
	rescue
		@logger.error( "#{description} failed!!")
		raise
	end 
end

#save blocks to execute later
def run_that_block( &that_block )
	puts "About to run the block"
	that_block.call
	puts "Done running the block"
end

that_block.call if that_block

class DocumentSaveListener
	def on_save( doc, path)
		puts "Hey, I've been saved!"
	end
end
class DocumentLoadListener
	def on_load( doc, path)
		puts "Hey I've been loaded!"
	end
end

class Document
	attr_accessor :load_listener
	attr_accessor :save_listener
  # Most of the class omitted...
	def load( path )
		@content = File.read( path )
		load_listener.on_load( self, path ) if load_listener
	end
	def save( path )
	File.open( path, 'w') { |f| f.print( @contents ) }
	save_listener.on_save( self, path ) if save_listener
	end 
end

doc = Document.new( 'Example', 'Russ', 'It was a dark...' )
doc.load_listener = DocumentLoadListener.new
doc.save_listener = DocumentSaveListener.new
doc.load( 'example.txt' )
doc.save( 'example.txt' )

#a better way
class Document
  # Most of the class omitted...
	def on_save( &block )
		@save_listener = block
	end
	def on_load( &block )
		@load_listener = block
	end
	def load( path )
		@content = File.read( path )
		@load_listener.call( self, path ) if @load_listener
	end
	def save( path )
		File.open( path, 'w' ) { |f| f.print( @contents ) }
		@save_listener.call( self, path ) if @save_listener
	end 
end

my_doc = Document.new( 'Block Based Example', 'russ', '' )
my_doc.on_load do |doc|
  puts "Hey, I've been loaded!"
end
my_doc.on_save do |doc|
  puts "Hey, I've been saved!"
end

#instead of this (dependent on File)
class ArchivalDocument
  attr_reader :title, :author
	def initialize(title, author,  path)
		@title = title
		@author = author
		@path = path
	end
	def content
		@content ||= File.read( @path )
	end 
end

#do this that is way more flexible

class BlockBasedArchivalDocument
  attr_reader :title, :author
	def initialize(title, author, &block) @title = title
		@author = author
		@initializer_block = block
	end
	def content
		if @initializer_block
		  @content = @initializer_block.call
		  @initializer_block = nil
		end
		@content 
	end
end

#it allows us to do this:
file_doc =  BlockBasedArchivalDocument.new( 'file', 'russ' ) do
  File.read( 'some_text.txt' )
end

#and this
google_doc = BlockBasedArchivalDocument.new('http', 'russ') do
  Net::HTTP.get_response('www.google.com', '/index.html').body
end

#and this

boring_doc = BlockBasedArchivalDocument.new('silly', 'russ') do
  'Ya' * 100
end

#hooks keep classes informed

class SimpleBaseClass
  def self.inherited( new_subclass )
    puts "Hey #{new_subclass} is now a subclass of #{self}!"
  end
end

class ChildClassOne < SimpleBaseClass
end

#this will print: Hey ChildClassOne is now a subclass of SimpleBaseClass!

class PlainTextReader < DocumentReader
	def self.can_read?(path)
		/.*\.txt/ =~ path
	end
	def initialize(path)
		@path = path
	end
	def read(path)
		File.open(path) do |f|
			title = f.readline.chomp
			author = f.readline.chomp
			content = f.read.chomp
			Document.new( title, author, content )
		end 
	end
end

class XMLReader < DocumentReader
	def self.can_read?(path)
		/.*\.xml/ =~ path
	end
	def initialize(path)
		@path = path
	end
	def read(path)
	    # Lots of complicated XML stuff omitted
	end 
end

class DocumentReader
  class << self
    attr_reader :reader_classes
end
  @reader_classes = []
	def self.read(path)
		reader = reader_for(path)
		return nil unless reader
		reader.read(path)
	end

	def self.reader_for(path)
	    reader_class = DocumentReader.reader_classes.find do |klass|
	      klass.can_read?(path)
	    end
		return reader_class.new(path) if reader_class
		nil 
	end
  #this will generate the reader_classes whenever a subclass is created	
	def self.inherited(subclass)
		DocumentReader.reader_classes << subclass
	end
end

#extending and including shortcut

module UsefulMethods
	module ClassMethods
	    def a_class_method
		end 
	end
	def self.included( host_class )
		host_class.extend( ClassMethods )
	end
	def an_instance_method
	end
  # Rest of the module deleted...
end


class Host
  include UsefulMethods
end

#method_missing block - handle exceptions

#.......

#method_missing override

class RepeatBackToMe
	def method_missing( method_name, *args )
	    puts "Hey, you just called the #{method_name} method"
	    puts "With these arguments: #{args.join(' ')}"
	    puts "But there ain't no such method"
	end 
end

#implementation that suggests missing method using Text gem
require 'text'  # From the text gem

class Document
	include Text

	# Most of the class omitted...
	def method_missing( missing, *args )
		candidates = methods_that_sound_like( missing.to_s )
		message = "You called an undefined method: #{missing}."
	unless candidates.empty?
	  message += "\nDid you mean #{candidates.join(' or ')}?"
	end
	raise raise NoMethodError.new( message )
	end
	def methods_that_sound_like( name )
		missing_soundex = Soundex.soundex( name.to_s )
		public_methods.sort.find_all do |existing|
		  existing_soundex = Soundex.soundex( existing.to_s )
		  missing_soundex == existing_soundex
		end
	end 
end

#missing constant example - note the class method detail

class Document
	# Most of the class omitted...
	def self.const_missing( const_name ) 
		msg = %Q{
		You tried to reference the constant #{const_name}
		There is no such constant in the Document class.
		}
		raise msg 
	end
end

#method delication using method_missing
class SuperSecretDocument
	def initialize(original_document, time_limit_seconds)
		@original_document = original_document
		@time_limit_seconds = time_limit_seconds
		@create_time = Time.now
	end
	def time_expired?
		Time.now - @create_time >= @time_limit_seconds
	end
	def check_for_expiration
		raise 'Document no longer available' if time_expired?
	end
	def method_missing(name, *args)
		check_for_expiration
		@original_document.send(name, *args)
	end
end

#being explicit

class SuperSecretDocument
  # Lots of code omitted...
	DELEGATED_METHODS = [ :content, :words ]
	def method_missing(name, *args) check_for_expiration
		if DELEGATED_METHODS.include?( name )
			@original_document.send(name, *args)
		else
			super 
		end
	end 
end


class SuperSecretDocument < BasicObject
# Most of the class omitted...
	def initialize(original_document, time_limit_seconds)
		@original_document = original_document
		@time_limit_seconds = time_limit_seconds
		@create_time = ::Time.now
	end
	def time_expired?
		::Time.now - @create_time >= @time_limit_seconds
	end
	def check_for_expiration
		raise 'Document no longer available' if time_expired?
	end
  def method_missing(name, *args)
    check_for_expiration
	 @original_document.send(name, *args)
  end
end

#method_missing for flexible APIs

#one implementation
class FormLetter < Document
  def replace_word( old_word, new_word )
    @content.gsub!( old_word, "#{new_word}" )
  end
end

offer_letter = FormLetter.new( "Special Offer", "Acme Inc",
%q{
    Dear Mr. LASTNAME
    Are you troubled by the heartache of hangnails?
    ...
    FIRSTNAME, we look forward to hearing from you.
})
offer_letter.replace_word( 'FIRSTNAME', 'Russ' )
offer_letter.replace_word( 'LASTNAME', 'Olsen' )

#here is some magic with method_missing

class FormLetter < Document
	def replace_word( old_word, new_word )
		@content.gsub!( old_word, "#{new_word}" )
	end
	def method_missing( name, *args )
		string_name = name.to_s
		return super unless string_name =~ /^replace_\w+/
		old_word = extract_old_word(string_name)
		replace_word( old_word, args.first )
	end
	def extract_old_word( name )
		name_parts = name.split('_')
		name_parts[1].upcase
	end 
end

#watch out for this:
letter = FormLetter.new( 'Example', 'Acme', 'The word is WORD' )
letter.replace_word( 'Abracadabra' )

#since method is already defined you will get this error

#<ArgumentError: wrong number of arguments (1 for 2)>

#also, method_missing does not get included in the respond_to? method

doc.respond_to?(:words)  # => true
doc.respond_to?(:abuse)  # => false

#A fix for this could be overriding the method:
def respond_to?(name)
  string_name = name.to_s
  return true if string_name =~ /^replace_\w+/
  super
end

#magic via missing_method in OpenStruct (hash-like) object

require 'otruct'
author = OpenStruct.new
author.first_name = 'Stephen'
author.last_name = 'Hawking'
puts author.first_name
puts author.last_name

def method_missing(mid, *args) # :nodoc:
	mname = mid.id2name
	len = args.length
	if mname =~ /=$/
		# Some error handling deleted... 
		mname.chop! 
		self.new_ostruct_member(mname) 
		@table[mname.intern] = args[0]
	elsif len == 0
		@table[mid]
	else
		raise NoMethodError,
		  "undefined method `#{mname}' for #{self}", caller(1)
	end
end

#Monkey patching

#modifying an existing class's method
class String
	def +( other )
	if other.kind_of? Document
		new_content = self + other.content
		return Document.new(other.title, other.author, new_content)
	end
	result = self.dup
	result << other.to_str
	result
	end 
end


#using alias for methods
class Document
	# Stuff omitted...
	def word_count
		words.size
	end
	alias_method :number_of_words, :word_count
	alias_method :size_in_words,   :word_count
	# Stuff omitted...
end

class String
	alias_method :old_addition, :+
	def +( other )
		if other.kind_of? Document
		  new_content = self + other.content
		  return Document.new(other.title, other.author, new_content)
	end
		old_addition(other)
	end 
end

#make method private
class Document
  private :word_count
end

#make method public
class Document
  public :word_count
end

#remove method
class Document
  remove_method :word_count
end

#self modifying classes

#ruby class definitions are executable
class MostlyEmpty
	puts "hello from inside the class"
end

#creating methods for subclasses using define_method

class StructuredDocument
	def self.paragraph_type( paragraph_name, options )
		name = options[:font_name] || :arial
		size = options[:font_size] || 12
		emphasis = options[:font_emphasis] || :none
		define_method(paragraph_name) do |text|
			paragraph = Paragraph.new( name, size, emphasis, text )
			self << paragraph
		end 
	end
# ... 
end

#sample internal DSL (Domain Specific Languages)
require "rexml/document"
class XmlRipper
	def initialize(&block)
		@before_action = proc {}
		@path_actions = {}
		@after_action = proc {}
		block.call( self ) if block
	end
	def on_path( path, &block )
		@path_actions[path] = block
	end
	def before( &block )
		before_action = block
	end
	def after( &block )
		@after_action = block
	end
	def run( xml_file_path )
		File.open( xml_file_path ) do |f|
		  document = REXML::Document.new(f)
		  @before_action.call( document )
		  run_path_actions( document )
		  @after_action.call( document )
		end 
	end
	def run_path_actions( document )
		@path_actions.each do |path, block|
			REXML::XPath.each(document, path) do |element|
				block.call( element )
			end 
		end
	end
end

#we can now do this
ripper = XmlRipper.new do |r|
  r.on_path( '/document/author' ) { |a| puts a.text }
  r.on_path( '/document/chapter/title' ) { |t| puts t.text }
end
ripper.run( 'fellowship.xml' )

#to make better, use instance_eval:

class XmlRipper
	def initialize(&block) 
		@before_action = proc {} 
		@path_actions = {} 
		@after_action = proc {} 
		instance_eval( &block ) if block
	end
  # Rest of the class omitted...
end

#now we have this:

ripper = XmlRipper.new do
  on_path( '/document/author' ) do |author|
    author.text = 'J.R.R. Tolkien'
  end
  after { |doc| puts doc }
end
ripper.run( 'fellowship.xml' )

#reduce code doen with this

class XmlRipper
	def initialize_from_file( path )
		instance_eval( File.read( path ) )
	end
  # Rest of the class omitted...
end

#add your xpath code in a file and then run this code
#file would have ruby code text: 
######
on_path( '/document/author' ) do |author|
 author.text = 'J.R.R. Tolkien'
end
after { |doc| puts doc }
####


ripper = XmlRipper.new
ripper.initialize_from_file( 'fix_author.ripper' )
ripper.run( 'fellowship.xml')

#Building external DSL
##We have this syntax
on_path( '/document/author' ) { |author| puts author.text }
#But users want a parser that can take input like this

delete /document/published
replace /document/author Tolkien

#example of External DSL
class EzRipper
	def initialize( program_path )
		@ripper = XmlRipper.new
		parse_program(program_path)
	end
	def run( xml_file )
		@ripper.run( xml_file )
	end
	def parse_program( program_path )
		File.open(program_path) do |f|
			until f.eof?
				parse_statement( f.readline )
			end 
		end
	end
	def parse_statement( statement )
		tokens = statement.strip.split
		return if tokens.empty?
		case tokens.first
		when 'print'
			@ripper.on_path( tokens[1] ) do |el|
				puts el.text
			end
		when 'delete'
			@ripper.on_path( tokens[1] ) { |el| el.remove }
		when 'replace'
			@ripper.on_path( tokens[1] ) { |el| el.text = tokens[2] }
		when 'print_document'
			@ripper.after do |doc|
			puts doc 
			end
		else
		  raise "Unknown keyword: #{tokens.first}"
		end 
	end
end

#adding some error messages

def parse_statement( statement )
	tokens = statement.strip.split
	return if tokens.empty?
	case tokens.first
	when 'print'
		raise "Expected print <xpath>" unless tokens.size == 2
		@ripper.on_path( tokens[1] ) do |el|
			puts el.text
		end
	when 'delete'
		raise "Expected delete <xpath>" unless tokens.size == 2
		@ripper.on_path( tokens[1] ) { |el| el.remove }
	when 'replace'
		unless tokens.size == 3
		raise "Expected replace <xpath> <value>"
	end
		@ripper.on_path( tokens[1] ) {|el| el.text = tokens[2]}
	when 'print_document'
		raise "Expected print_document" unless tokens.size == 1
		@ripper.after do |doc|
			puts doc
		end
	else
		raise "Unknown keyword: #{tokens.first}"
	end 
end

#parse statement with regex
def parse_statement( statement )
	statement = statement.sub( /#.*/, '' )
	case statement.strip
	when ''
	# Skip blank lines
	when /print\s+'(.*?)'/ @ripper.on_path( $1 ) do |el|
		puts el.text
	end
	when /delete\s+'(.*?)'/
		@ripper.on_path( $1 ) { |el| el.remove }
	when /replace\s+'(.*?)'\s+'(.*?)'$/ @ripper.on_path( $1 ) { |el| el.text = $2 }
	when /uppercase\s+'(.*?)'/
		@ripper.on_path( $1 ) { |el| el.text = el.text.upcase }
	when /print_document/
		@ripper.after do |doc|
		puts doc 
		end
	else
		raise "Don't know what to do with: #{statement}"
	end
end

#alternative to parser using Treetop -> a language for describing languages 
grammar EzRipperStatement
	rule statement
		comment/delete_statement/replace_statement/print_statement
	end
	rule comment
			"#" .*
	end
	rule delete_statement
		"delete" sp quoted_argument sp
	end
	rule replace_statement
		"replace" sp quoted_argument sp quoted_argument sp
	end
	rule print_statement
		"filter" sp quoted_argument sp
	end
	rule quoted_argument
		"'" argument "'"
	end
	rule argument
		(!"'" . )*
	end
	rule sp
		[ \t\n]*
	end
end

#compile using treetop compiler gets us this:  tt ez_ripper_statement.tt

#to run treetop and revised ezripper we use this:
require 'treetop'
require 'ez_ripper_statement'
statement =  "replace '/document/author' 'Russ Olsen'"
parser = EzRipperStatementParser.new
parse_tree = parser.parse( statement )

#HAML and ERB also is an external DSL that uses parsing to generate the HTML code 

#ruby (under the hood) implementation in C

rb_cObject = boot_defclass("Object", 0);
rb_cModule = boot_defclass("Module", rb_cObject);
rb_cClass =  boot_defclass("Class",  rb_cModule);

#collect! implementation
static VALUE
rb_ary_collect_bang(ary)
VALUE ary; {
long i;
rb_ary_modify(ary);
for (i = 0; i < RARRAY(ary)->len; i++) {
rb_ary_store(ary, i, rb_yield(RARRAY(ary)->ptr[i])); }
return ary; }