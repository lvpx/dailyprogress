require_relative "DailyProgress/version"
require_relative 'os'

module DailyProgress
  include OS
  class Error < StandardError; end


  def configure(path)
    @@path = path

  end
  def progress
    time_now = Time.new
    # Threshold time currently 7 PM
    time_th = Time.new(time_now.year, time_now.month, time_now.day, 19, 0, 0, "+05:00")
    if time_now < time_th
      content = morning_progress(self.content)
    else
      content = evening_progress(self.content)
    end
    puts "Content to clipboard"
    to_clipboard(content)
  end

  def list_files
    Dir[@@path + "*"]
  end

  def today_filename
    time = Time.new
    @@path + time.strftime("%Y-%m-%d.wiki")
  end

  def today_file_exists
    File.file?(self.today_filename)
  end

  def content
    filename = today_filename
    file = File.open(filename)
    file_data = file.read
    file.close
    file_data
  end

  def morning_progress(content)
    content.gsub!("[X]","")
    content.gsub!("[-]","")
    content.gsub!("[ ]","")
  end

  def evening_progress(content)
    content.gsub!("[X]", "[Completed]")
    content.gsub!("[-]", "[On Hold]")
    content.gsub!("[ ]", "[In Progress]")
  end

  # Currently only works with WSL
  def to_clipboard(content)
    puts OS.windows?
    if OS.windows?
      IO.popen('clip', 'w') { |f| f << content.to_s }
    else OS.linux?
      IO.popen('xsel -clipboard -input', 'r+') { |f| f.puts content.to_s }
    end
  end
end

