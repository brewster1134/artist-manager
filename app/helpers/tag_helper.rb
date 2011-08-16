module TagHelper
  def tag_select_array
    Work.tags.collect{ |t| [t.name, t.name.downcase] }
  end
end