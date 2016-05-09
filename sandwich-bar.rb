require 'erb'

class SandwichBar
  def initialize
    @menu = []
  end

  def call
    drafts.each do |draft|
      publish(draft)
    end
    generate_menu
  end

  def publish(draft)
    published_filename = generate_filename(draft)
    File.open(generate_filename(draft), "w+") do |f|
      f.write(render { |layout| File.read(draft) })
      @menu << published_filename
    end
  end

  def generate_menu
    File.open("nav.html", "w+") do |f|
      f.write(@menu.map{ |menu_item| "#{menu_item}\n" }.join(''))
    end
  end

  private

  def generate_filename(draft)
    "blog/#{draft.gsub('drafts/','').gsub('/','-')}"
  end

  def drafts
    Dir.glob('drafts/**/*').reject{ |fn| File.directory?(fn) }
  end

  def render
    ERB.new(layout).result(binding)
  end

  def layout
    File.read(layout_path)
  end

  def layout_path
    "#{layout_dir}/layouts/default.html.erb"
  end

  def layout_dir
    File.dirname(__FILE__)
  end
end

SandwichBar.new.call
