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
      rasterize
      @terminal.replace_background @image
    end

    private

    def setup_terminal
      @terminal = ::Layer::Terminal.new @config
      @terminal.forbid_scrolling unless @config['allow_scroll']
    end

    def rasterize
      size = "#{@terminal.width}*#{@terminal.height}"
      `phantomjs #{rasterize_path} #{@url} #{@image} #{size}`
    end

    def rasterize_path
      File.expand_path '~/.layer/lib/rasterize.js'
    end
  end
end