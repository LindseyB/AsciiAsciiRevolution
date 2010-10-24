#!/usr/bin/ruby

return "no file found!" unless File.exists? ARGV[0]

ARGV.each do |filename|
  file = File.open(filename, "r+")

  bpms = (file.readline.to_f)/60
  length = file.readline

  beats = bpms * length.to_i

  (0..beats.to_i).each do |i|
    roll = 1 + rand(100) 
    case roll
    when 1..14
      line = ""
    when 15..64
      line = "x"
    when 65..89
      line = "xx"
    when 91..99
      line = "xxx"
    when 100
      line = "xxxx"
    else
      line = "x"
    end
    file.puts line
  end
end
