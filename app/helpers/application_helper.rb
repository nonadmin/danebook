module ApplicationHelper

  def nav_link(link_text, link_path, options = {})

    # Determine if link is to active page (sets gray background)
    class_name = current_page?(link_path) ? 'active' : nil

    # Add a badge to the link, and extra classes to the li
    if options[:badge]
      badge = " <span class='badge'>#{options[:badge]}</span>"
      link_text += " #{badge}"
    elsif options[:class]
      class_name = "#{class_name} #{options[:class]}"
    end  
     
    # Generate li with nested link  
    content_tag(:li, :role => "presentation", :class => class_name) do   
      link_to(link_path) do
        link_text.html_safe
      end
    end

  end


  def liker_names(liked_resource, current_user)
    likers = liked_resource.likers.to_a
    if likers.include?(current_user)
      likers.reject! { |liker| liker == current_user}
      case likers.size
      when 0
        names = "You like this."
      when 1 
        names = "You and " +
        link_to(likers[0].profile.full_name, user_timeline_path(likers[0])) +
        " like this."
      when 2
        names = "You, " +
        link_to(likers[0].profile.full_name, user_timeline_path(likers[0])) +
        ", and " +
        link_to(likers[1].profile.full_name, user_timeline_path(likers[1])) +
        " like this."
      else
        names = "You, " +
        link_to(likers[0].profile.full_name, user_timeline_path(likers[0])) +
        ", and " +
        link_to(likers[1].profile.full_name, user_timeline_path(likers[1])) +
        " and " + pluralize((likers.size - 3), 'other') + " like this."       
      end
    else
      case likers.size
      when 0
      when 1
        names = link_to(likers[0].profile.full_name, user_timeline_path(likers[0])) +
        " likes this."
      when 2 
        names = link_to(likers[0].profile.full_name, user_timeline_path(likers[0])) +
        ", and " +
        link_to(likers[1].profile.full_name, user_timeline_path(likers[1])) +
        " like this."
      else
        names = link_to(likers[0].profile.full_name, user_timeline_path(likers[0])) +
        ", and " +
        link_to(likers[1].profile.full_name, user_timeline_path(likers[1])) +
        " and " + pluralize((likers.size - 2), 'other') + " like this." 
      end    
    end

    names.html_safe unless names.nil?
    # Joe Bob liked this
    # You and Joe Bob liked this
    # Job Bob, John Bob, and 1 other person liked this
    # You, Joe Bob, and 3 other people liked this
  end


  def liker_self_or_user_link(liker, current_user)
    if liker == current_user
      "You"
    else
      link_to(liker.profile.full_name, user_timeline_path(liker))
    end
  end


end
