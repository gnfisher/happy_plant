# Playing around with select, IO, listening for key press etc..
require "io/console"
require "pry"

system("stty raw -echo cbreak dsusp undef")
loop do
  read, _, _ = select([STDIN], nil, nil)
  if read.include?(STDIN)
    if STDIN.getc == ?q
      raise SystemExit
    else
      puts "No"
    end
  end
end

# loop do
#   # getch is blocking! waits for input!
#   # x = STDIN.getch
#   case x
#   when ?j then puts "HELLO"
#   when ?k then puts "GOODBYE"
#   when ?\C-c then raise SystemExit
#   end
# end

