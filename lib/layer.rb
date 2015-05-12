require 'thor'
require 'yaml'

Dir[File.dirname(__FILE__) + '/layer/*.rb'].each {|file| require file }

module Layer
  class Layer < Thor

    ROOT = File.expand_path '~/.layer'
    DEFAULTS = YAML.load_file "#{ROOT}/config/layer_config.yml"
    WRITE_HTML_PATH = "#{ROOT}/lib/write_html.js"

    def self.add_options(*opts)
      opts.each { |opt| add_option opt, opt[0] }
    end

    def self.add_option(opt, short)
      option opt, aliases: [short], default: DEFAULTS[opt.to_s]
    end

    # def run
    #   write_html @config.get(:write)
    #   write_html @config.get(:append), true
    #   update_background
    # end

    desc 'render', 'Replace terminal background with rendered HTML'
    add_options :url, :image, :profile
    add_option :pixels_per_column, :c
    add_option :pixels_per_row, :r
    option :allow_scroll, default: DEFAULTS[:allow_scroll], aliases: [:a], type: :boolean
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

    private

    def write_html(content, append = false)
      return if content.nil?
      arguments = "#{@config.get :file} \"#{@config.get :selector}\" \"#{content}\""
      arguments += ' -a' if append
      `phantomjs #{WRITE_HTML_PATH} #{arguments}`
    end
  end
end