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
    file = File.open(filename)
    file_data = file.read
    file.close
    file_data
  end

  def morning_progress(content)
    content.gsub!('[X]', '')
    content.gsub!('[-]', '')
    content.gsub!('[ ]', '')
  end

  def evening_progress(content)
    content.gsub!('[X]', '[Completed]')
    content.gsub!('[-]', '[On Hold]')
    content.gsub!('[ ]', '[In Progress]')
  end

  def to_clipboard(content)
    if OS.windows?
      IO.popen('clip', 'w') { |f| f << content.to_s }
    elsif OS.wsl?
      IO.popen('clip.exe') { |f| f << content.to_s }
    else OS.linux?
      IO.popen('xclip -selection clipboard', 'r+') { |f| f.puts content.to_s }
    end
  end
end

