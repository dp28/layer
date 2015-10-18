require_relative '../layer'
require_relative 'terminal'

module Layer
  class Renderer
    def initialize(root, options)
      @terminal = create_terminal options
      @rasterize_path = "#{root}/lib/rasterize.js"
      @temp_image = "#{root}/temp.png"
    end

    def render(url, image)
      rasterize @temp_image, url
      @terminal.replace_background @temp_image
      `mv -f #{@temp_image} #{image}`
      @terminal.replace_background image
    end

    private

    def create_terminal(options)
      terminal = ::Layer::Terminal.new options
      terminal.forbid_scrolling unless options['allow_scroll']
      terminal
    end

    def rasterize(output, url)
      size = "#{@terminal.width}px*#{@terminal.height}px"
      `phantomjs #{@rasterize_path} #{url} #{output} #{size}`
    end

  end
end