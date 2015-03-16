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
