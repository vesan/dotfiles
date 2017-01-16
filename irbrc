# require File.dirname(__FILE__) + "/.tweet"
require 'logger'
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
end

require 'irb/completion'
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

# load rubygems and helper gems

# Assume a bundler-managed environment, so find and require the irb-specific
# enhancement gems directly. This does not do dependency tracking, so
# dependent gems must be explicitly specified!
#
# Taken from: https://github.com/aniero/dotfiles/blob/master/irbrc#L4-35
def irb_require(gemname, lib=nil)
  # allow bundler or rubygems a fair shake at loading the library first
  require lib ? lib : gemname
rescue LoadError
  # didn't work? we'll do it ourself
  candidates = []

  if ENV["GEM_PATH"]
    ENV["GEM_PATH"].split(":").map {|p| p + "/gems" }.each do |path|
      Dir.glob(path + "/*").each do |entry|
        if File.directory?(entry) && File.basename(entry).start_with?(gemname)
          candidates << entry
        end
      end
    end
  end

  if candidates.empty?
    raise LoadError, "could not load #{lib || gemname} via irb_require"
  else
    $:.push(candidates.sort.reverse.first + "/lib")
    require lib ? lib : gemname
  end
end

irb_require "awesome_print"
irb_require "hirb"
irb_require "interactive_editor"
# irb_require "looksee"
Hirb.enable

# pretty print
require 'pp'

# http://aaronbedra.com/2008/6/12/slight-of-hand-for-the-ruby-man
module Kernel
  # which { some_object.some_method() } => ::
  def where_is_this_defined(settings={}, &block)
    settings[:debug] ||= false
    settings[:educated_guess] ||= false

    events = []

    set_trace_func lambda { |event, file, line, id, binding, classname|
      events << { :event => event, :file => file, :line => line, :id => id, :binding => binding, :classname => classname }

      if settings[:debug]
        puts "event => #{event}" 
        puts "file => #{file}" 
        puts "line => #{line}" 
        puts "id => #{id}" 
        puts "binding => #{binding}" 
        puts "classname => #{classname}" 
        puts ''
      end
    }
    yield
    set_trace_func(nil)

    events.each do |event|
      next unless event[:event] == 'call' or (event[:event] == 'return' and event[:classname].included_modules.include?(ActiveRecord::Associations))
      return "#{event[:classname]} received message '#{event[:id]}', Line \##{event[:line]} of #{event[:file]}" 
    end

    # def self.crazy_custom_finder
    #  return find(:all......)
    # end
    # return unless event == 'call' or (event == 'return' and classname.included_modules.include?(ActiveRecord::Associations))
    # which_file = "Line \##{line} of #{file}" 
    if settings[:educated_guess] and events.size > 3
      event = events[-3]
      return "#{event[:classname]} received message '#{event[:id]}', Line \##{event[:line]} of #{event[:file]}" 
    end

    return 'Unable to determine where method was defined.'
  end
end

# from: http://pastie.org/113760
class Object
  def grep_methods(search_term)
    methods.find_all {|method| method.to_s.downcase.include? search_term.to_s.downcase}
  end
  
  def non_class_methods
    self.methods - Class.methods
  end
end

# from: http://judofyr.net/posts/copy-paste-irb.html
def copy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
  str.to_s
end

def paste
  `pbpaste`
end

def ep
  eval(paste)
end
