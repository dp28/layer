require 'yaml'

module Layer
  class Layer

    CONFIG_FILE = 'layer_config.yml'

    def initialize
      @config = YAML.load_file CONFIG_FILE
      @url = @config['url']
      @image = @config['image']
      @profile = @config['profile']
    end

    def update_background
      rasterize
      replace_background
    end

    private

    def rasterize
      `phantomjs lib/rasterize.js #{@url} #{@image} #{width}*#{height}`
    end

    def replace_background
      `gconftool-2 --unset #{background_key}`
      `gconftool-2 --set #{background_key} #{@image} --type string`
    end

    def background_key
      @background_key ||= "/apps/gnome-terminal/profiles/#{@profile}/background_image"
    end

    def width
      columns = terminal_info 'columns'
      columns.to_i * @config['pixels_per_column']
    end

    def height
      rows = terminal_info 'rows'
      rows.to_i * @config['pixels_per_row']
    end

    def terminal_info(element)
      @info ||= `stty -a`
      @info.match(/#{element}\s(\d+);/).captures.first
    end
  end
end