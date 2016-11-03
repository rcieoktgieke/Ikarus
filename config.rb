require "json"
###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

page "/galleries/*", :layout => "gallery"

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

activate :directory_indexes

SITE_ROOT_PATH = "../"
CONFIG_VERBOSE = true
galleries = JSON.parse(File.read("ikarus_galleries.json"));

#galleries = [
#	{ "name" => "Ecuador - Chimborazo", "shortname" => "ecuador", "data-file" => "data/galleries/ecuador.yaml" },
#	{ "name" => "Bolivia - Illimani", "shortname" => "bolivia", "data-file" => "data/galleries/bolivia.yaml" }
#]
galleries.each do |gallery_info|
	puts "GALLERY: Name: #{gallery_info["name"]} | Short Name: #{gallery_info["shortname"]} | Images Path: #{gallery_info["images_path"]} | Thumbs Folder Path: #{gallery_info["thumbs_folder_path"]} | Total Width: #{gallery_info["total_width"]} | Images Per Row: #{gallery_info["images_per_row"]} | Image Margins: #{gallery_info["image_margins"]} | Width Adjustment: #{gallery_info["width_adjustment"]} | Overlay Thumbnail Height: #{gallery_info["overlay_thumb_height"]}" if CONFIG_VERBOSE
	puts "GALLERY: Image Filename Matrix: #{gallery_info["image_filename_matrix"]}" if CONFIG_VERBOSE
	#, :locals => { , :filename_matrix => filename_matrix, :gallery_folder => gallery_folder, :thumbs_folder => thumbs_folder, :total_width => total_width, :images_per_row => images_per_row, :image_margins => image_margins, :width_adjustment => width_adjustment, :overlay_thumb_height => overlay_thumb_height}
	filename_matrix = gallery_info["image_filename_matrix"]
	gallery_folder = "#{SITE_ROOT_PATH}#{gallery_info["images_path"]}" #"galleries/ecuador"
	thumbs_folder	= gallery_info["thumbs_folder_path"]
	total_width = gallery_info["total_width"]
	images_per_row = gallery_info["images_per_row"]
	image_margins = gallery_info["image_margins"]
	width_adjustment = gallery_info["width_adjustment"]
	overlay_thumb_height = gallery_info["overlay_thumb_height"]
	proxy "/galleries/#{gallery_info["shortname"]}/index.html", "/templates/gallery.html", :locals => { :gallery_info => gallery_info, :filename_matrix => filename_matrix, :gallery_folder => gallery_folder, :thumbs_folder => thumbs_folder, :total_width => total_width, :images_per_row => images_per_row, :image_margins => image_margins, :width_adjustment => width_adjustment, :overlay_thumb_height => overlay_thumb_height }, :ignore => true
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
