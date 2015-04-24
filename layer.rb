require 'yaml'

module Layer
  class Layer

    CONFIG_FILE = 'layer_config.yml'

    def initialize
      config = YAML.load_file CONFIG_FILE
      @url = config['url']
      @image = config['image']
      @profile = config['profile']
    end

    def update_background
      rasterize
      replace_background
    end

    private

    def rasterize
      puts "phantomjs lib/rasterize.js #{@url} #{@image}"
      `phantomjs lib/rasterize.js #{@url} #{@image}`
    end

    def replace_background
      `gconftool-2 --unset #{background_key}`
      `gconftool-2 --set #{background_key} #{@image} --type string`
    end

    def background_key
      @background_key ||= "/apps/gnome-terminal/profiles/#{@profile}/background_image"
    end

  end
end