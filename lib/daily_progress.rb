# frozen_string_literal: true

require_relative 'DailyProgress/version'
require_relative 'os'

# The main module for the gem implementation.
module DailyProgress
  include OS
  class Error < StandardError; end

  def configure(path)
    @path = path
    abort("[FATAL] Today's vimwiki entry not created yet!") unless today_file_exists?
  end

  def progress
    time_now = Time.new
    # Threshold time currently 7 PM
    time_th = Time.new(time_now.year, time_now.month, time_now.day, 19, 0, 0, '+05:30')
    text = content
    if time_now < time_th
      morning_progress(text)
    else
      evening_progress(text)
    end
  end

  def list_files
    Dir["#{@path}*"]
  end

  def today_filename
    time = Time.new
    "#{@path}#{time.strftime('%Y-%m-%d.wiki')}"
  end

  def today_file_exists?
    File.file?(today_filename)
  end

  def content
    filename = today_filename
    File.open(filename).read
  end

  def morning_progress(content)
    content.gsub!('[X]', '')
    content.gsub!('[-]', '')
    content.gsub!('[ ]', '')
    content
  end

  def evening_progress(content)
    content.gsub!('[X]', '[Completed]')
    content.gsub!('[-]', '[On Hold]')
    content.gsub!('[ ]', '[In Progress]')
    content
  end

  def to_clipboard(content)
    success_msg = "Content copied to clipboard successfully!"
    if OS.windows?
      IO.popen('clip', 'w') { |f| f << content.to_s }
      puts success_msg if $?.exitstatus.to_i == 0
    elsif OS.wsl?
      IO.popen('clip.exe', 'w') { |f| f << content.to_s }
      puts success_msg if $?.exitstatus.to_i == 0
    elsif OS.linux?
      IO.popen('xclip -selection clipboard', 'r+') { |f| f.puts content.to_s }
      puts success_msg if $?.exitstatus.to_i == 0
    else
      puts "Clipboard not implemented for this OS."
      Puts "Please copy from stdout."
    end
  end
end

