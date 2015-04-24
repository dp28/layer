#! /usr/bin/env ruby

def rasterize(output_file)
  `phantomjs lib/rasterize.js file:///home/jimmy/Programming/Other/layer/example.html #{output_file}`
end

def replace_background(image_path, profile = 'Default')
  key = "#{schema_for profile}/background_image"
  `gconftool-2 --unset #{key}`
  `gconftool-2 --set #{key} #{image_path} --type string`
end

def schema_for(profile)
  "/apps/gnome-terminal/profiles/#{profile}"
end

image = '/home/jimmy/Programming/Other/layer/output/test.png'
rasterize image
replace_background image