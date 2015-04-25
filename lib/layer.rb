require 'yaml'
require_relative 'terminal'

module Layer
  class Layer

    CONFIG_FILE = File.expand_path '~/.layer/config/layer_config.yml'

    def initialize
      @config = YAML.load_file CONFIG_FILE
      @url = @config['url']
      @image = @config['image']
      setup_terminal
    end

    def update_background
      [temp_image, @image].each do |image|
        rasterize image
        @terminal.replace_background image
      end
    end

    private

    def setup_terminal
      @terminal = ::Layer::Terminal.new @config
      @terminal.forbid_scrolling unless @config['allow_scroll']
    end

    def temp_image
      File.expand_path '~/.layer/temp.png'
    end

    def rasterize(output)
      size = "#{@terminal.width}*#{@terminal.height}"
      `phantomjs #{rasterize_path} #{@url} #{output} #{size}`
    end

    def rasterize_path
      File.expand_path '~/.layer/lib/rasterize.js'
    end
  end
end