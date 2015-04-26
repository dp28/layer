require 'yaml'
require_relative 'terminal'

module Layer
  class Layer

    ROOT = File.expand_path '~/.layer'
    CONFIG_FILE = "#{ROOT}/config/layer_config.yml"
    RASTERIZE_PATH = "#{ROOT}/lib/rasterize.js"
    TEMP_IMAGE = "#{ROOT}/temp.png"

    def initialize
      @config = YAML.load_file CONFIG_FILE
      @url = @config['url']
      @image = @config['image']
      setup_terminal
    end

    def update_background
      rasterize TEMP_IMAGE
      @terminal.replace_background TEMP_IMAGE
      `mv -f #{TEMP_IMAGE} #{@image}`
      @terminal.replace_background @image
    end

    private

    def setup_terminal
      @terminal = ::Layer::Terminal.new @config
      @terminal.forbid_scrolling unless @config['allow_scroll']
    end

    def rasterize(output)
      size = "#{@terminal.width}px*#{@terminal.height}px"
      `phantomjs #{RASTERIZE_PATH} #{@url} #{output} #{size}`
    end
  end
end