require_relative 'terminal'
require_relative 'config'

module Layer
  class Layer

    ROOT = File.expand_path '~/.layer'
    CONFIG_FILE = "#{ROOT}/config/layer_config.yml"
    RASTERIZE_PATH = "#{ROOT}/lib/rasterize.js"
    WRITE_HTML_PATH = "#{ROOT}/lib/write_html.js"
    TEMP_IMAGE = "#{ROOT}/temp.png"

    def initialize(argv)
      @config = Config.new CONFIG_FILE, argv
      @url = @config.get :url
      @image = @config.get :image
      setup_terminal
    end

    def run
      write_html @config.get(:write)
      write_html @config.get(:append), true
      update_background
    end

    private

    def setup_terminal
      @terminal = ::Layer::Terminal.new @config
      @terminal.forbid_scrolling unless @config.get :allow_scroll
    end

    def update_background
      rasterize TEMP_IMAGE
      @terminal.replace_background TEMP_IMAGE
      `mv -f #{TEMP_IMAGE} #{@image}`
      @terminal.replace_background @image
    end

    def write_html(content, append = false)
      return if content.nil?
      arguments = "#{@config.get :file} \"#{@config.get :selector}\" \"#{content}\""
      arguments += ' -a' if append
      `phantomjs #{WRITE_HTML_PATH} #{arguments}`
    end

    def rasterize(output)
      size = "#{@terminal.width}px*#{@terminal.height}px"
      `phantomjs #{RASTERIZE_PATH} #{@url} #{output} #{size}`
    end
  end
end