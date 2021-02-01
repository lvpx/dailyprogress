require 'DailyProgress'

include DailyProgress
path = "/home/lovepreet/vimwiki/diary/"

DailyProgress.configure(path)
puts DailyProgress.progress

