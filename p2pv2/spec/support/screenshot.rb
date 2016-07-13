#
# based on http://blog.jerodsanto.net/2012/12/capybara-and-poltergeist-snap/
#

def take_screenshot(options={})
  begin
    path = options.fetch :path, "~/.Trash"
    file = options.fetch :file, "#{Time.now.to_i}.png"
    full = options.fetch :full, true

    path = File.expand_path path
    path = "/tmp" if !File.exists?(path)

    path = ENV['CIRCLE_ARTIFACTS'] if ENV['CIRCLECI'] and ENV['CIRCLE_ARTIFACTS']

    uri = File.join path, file

    page.save_screenshot(uri, full: full, width: 1200, height: 800)

    return uri
  rescue Exception => e
    puts
    puts "Caught exception while taking screenshot:"
    p e
    puts e.backtrace
    puts
    puts "Can't capture screenshot with this drivers: add 'js: true' to 'it .. do' block to run this test with Poltergeist."
    puts
  end
end

def take_and_open_screenshot(options={})
  begin
    uri = take_screenshot(options)

    # do not open screenshots on CI
    return if (!!ENV['CIRCLECI'])

    # Mac, Linux fallbacks
    fallbacks = ["open", %w{geeqie --remote}, "gimp"]

    opened = false
    for opener in fallbacks
      # TODO: if this opens gimp, it hangs until it's closed. frown emoticon
      system *opener, uri
      if $?.exitstatus == 0
        opened = true
        break
      end
    end

    if !opened
      puts
      puts "Failed to open screenshot with any opener. Sorry."
      puts "It's placed at #{uri}, open it yourself."
      puts
    end
  rescue Exception => e
    puts
    puts "Caught exception while taking screenshot:"
    p e
    puts e.backtrace
    puts
    puts "Can't capture screenshot with this drivers: add 'js: true' to 'it .. do' block to run this test with Poltergeist."
    puts
  end
end