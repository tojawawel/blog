class ApplicationController < ActionController::Base

  def favourite_text
    return "Add to favourites!"
  end

  helper_method :favourite_text
end
