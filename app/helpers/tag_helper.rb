module TagHelper
  def tag_select_array
   [["ALL", "all"]] + Work.tags.collect{ |t| [t.name] }
  end
end