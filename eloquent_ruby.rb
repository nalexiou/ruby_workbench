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

