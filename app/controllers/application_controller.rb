class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
     admin_path
    elsif resource.is_a?(Public)
      public_customer_path
    end
  end
end
