module ApplicationHelper

  def signed_in_user?
    !!current_user
  end
  # helper_method :signed_in_user?


  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token])
  end
  # helper_method :current_user 
   

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


  # wrap a link around the block if condition is true, otherwise
  # simply output the block with a link
  def link_to_if_with_block condition, options, html_options={}, &block
    if condition
     link_to options, html_options, &block
    else
     link_to "#", html_options, &block
    end
  end


  # Generate the "You and such and such like this" line.
  # Kind of complicated due to replacing current_user with "You"
  # and handling different phrasing depending on number of likes
  def liker_names(liked_resource, current_user)
    likers = liked_resource.likers.to_a

    if likers.reject! { |liker| liker == current_user}
      likers.unshift("You")
    end

    case likers.size
    when 0
    when 1
      like_or_likes = likers[0] == "You" ? "like" : "likes"
      names = like_profile_link(likers[0]) + " #{like_or_likes} this."
    when 2 
      names = like_profile_link(likers[0]) + " and " +
      like_profile_link(likers[1]) + " like this."
    else
      names = like_profile_link(likers[0]) + ", " +
      like_profile_link(likers[1]) + ", and " + 
      pluralize((likers.size - 2), 'other') + " like this." 
    end    

    names.html_safe unless names.nil?
    # Joe Bob likes this
    # You and Joe Bob like this
    # Job Bob, John Bob, and 1 other like this
    # You, Joe Bob, and 3 others like this
  end


  def like_profile_link(user)
    user == "You" ? "You" : link_to(user.profile.full_name, user_timeline_path(user))
  end
end
