require 'thor'
require 'yaml'

Dir[File.dirname(__FILE__) + '/layer/*.rb'].each {|file| require file }

module Layer
  class Layer < Thor

    ROOT = File.expand_path '~/.layer'
    DEFAULTS = YAML.load_file "#{ROOT}/config/layer_config.yml"
    WRITE_HTML_PATH = "#{ROOT}/lib/write_html.js"

    def self.add_class_options(*opts)
      opts.each { |opt| add_class_option opt, opt[0] }
    end

    def self.add_class_option(opt, short)
      class_option opt, aliases: [short], default: DEFAULTS[opt.to_s]
    end

    def self.html_options
      option :selector, aliases: [:s], required: true
      option :file, aliases: [:f], default: DEFAULTS['file']
    end

    desc 'render', 'Replace terminal background with rendered HTML'
    add_class_options :url, :image, :profile
    add_class_option :pixels_per_column, :c
    add_class_option :pixels_per_row, :r
    class_option :url, aliases: [:u], default: "file://#{DEFAULTS['file']}"
    class_option :allow_scroll, aliases: [:a], default: DEFAULTS['allow_scroll'], type: :boolean
    long_desc <<-LONGDESC
      Replaces the terminal background for a given profile with a rendered
      PNG of a specific HTML page.

      `--allow-scroll` allows the background image to scroll (and may break
      positioning of the background).

      `--image` defines where the rendered PNG is saved.

      `--pixels_per_column` and '--pixels_per_row' can be used to tweak the
      calculation of the size of the terminal when rendering the PNG, for
      example if you have a non-default font-size.

      `--profile` is the terminal profile which should have its background
      changed.

      `--url` is the URL of an HTML page to render to PNG to be used as the
      background. Using file:// as the protocol allows access to local files.
    LONGDESC
    def render
      renderer = ::Layer::Renderer.new ROOT, options
      renderer.render options['url'], options['image']
    end
    default_task :render

    desc 'write', 'Replace the inner contents of a selector in an HTML file
                  then re-render the background.'
    html_options
    def write(content)
      `#{write_html content, options[:file], options[:selector]}`
      render
    end

    desc 'append', 'Append to the inner contents of a selector in an HTML file
                    then re-render the background.'
    html_options
    def append(content)
      `#{write_html content, options[:file], options[:selector]} -a`
      render
    end

    private

    def write_html(content, file, selector)
      "phantomjs #{WRITE_HTML_PATH} #{file} \"#{selector}\" \"#{content}\""
    end
  end
end