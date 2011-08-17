module TagHelper
  def tag_select_array
   [["ALL", "all"]] + Work.tags.collect{ |t| [t.name, t.name.downcase] }
  end
end