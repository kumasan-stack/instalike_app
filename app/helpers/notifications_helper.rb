module NotificationsHelper
  def activity_message(activity)
    case activity 
    when "Favorite" then 
      "をお気に入りに追加しました" 
    when "Comment" then 
      "にコメントしました" 
    else
      ""
    end 
  end
end
