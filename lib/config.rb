require 'optparse'
require 'yaml'

module Layer
  class Config

    def initialize(defaults_path, argv)
      @values = {}
      @config = YAML.load_file defaults_path
      @parser = OptionParser.new
      setup_parser defaults_path
      @parser.parse argv
    end

    def print_help
      puts @parser
    end

    def get(key)
      @values[key.to_s]
    end

    private

    def setup_parser(defaults_path)
      @parser.banner = "Usage: layer [-acfipursw] \nDefault options in #{defaults_path}\n\n"
      add :url, 'URL of HTML page to use as background.', 'url'
      add :image, 'Location to save new background image to.', 'path'
      add :profile, 'Terminal profile to change background of.', 'profile_name'
      add :pixels_per_column, 'How many pixels wide one terminal column is.', 'number', '-c'
      add :pixels_per_row, 'How many pixels high one terminal row is.', 'number', '-r'
      add :allow_scroll, 'Allow the background image to scroll (may break positioning of the background).'
      add :file, 'The file to write HTML changes to', 'path'
      add :selector, 'The selector to write/append changes to', 'css'
      add :write, 'Content to write to the HTML before rendering', 'html'
      add :append, 'Content to append to the HTML before rendering', 'html'

      @parser.on('-h', '--help', 'Print this help message') do
        print_help
        exit
      end
    end

    def add(name, description, arg = nil, short = nil, long = nil)
      short ||= "-#{name[0]}"
      long ||= "--#{name}"
      long += " <#{arg}>" unless arg.nil?
      add_option short, long, description, name
    end

    def add_option(short, long, description, name)
      name = name.to_s
      default = @config[name]
      @values[name] = default
      description = build_description description, default
      @parser.on(short, long, description) { |arg| @values[name] = arg }
    end

    def build_description(description, default)
      description = "#{description} [default: #{default}]\n"
      line = ""
      lines = []
      description.split(' ').each do |word|
        if line.length + word.length > 40
          lines << line
          line = ""
        end
        line += "#{word} "
      end

      lines << "#{line}\n\n"
      lines.join "\n\t\t\t\t     "
    end
  end
end