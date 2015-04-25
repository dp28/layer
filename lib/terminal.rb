module Layer
  class Terminal

    def initialize(config)
      @schema = "/apps/gnome-terminal/profiles/#{config['profile']}/"
      @pixels_per_row = config['pixels_per_row'].to_i
      @pixels_per_column = config['pixels_per_column'].to_i
    end

    def forbid_scrolling
      `gconftool-2 --set #{@schema}scroll_background false --type bool`
    end

    def replace_background(image)
      `gconftool-2 --unset #{@schema}background_image`
      `gconftool-2 --set #{@schema}background_image #{image} --type string`
    end

    def width
      columns = info 'columns'
      columns.to_i * @pixels_per_column
    end

    def height
      rows = info 'rows'
      rows.to_i * @pixels_per_row
    end

    private

    def info(element)
      @info ||= `stty -a`
      @info.match(/#{element}\s(\d+);/).captures.first
    end

  end
end
