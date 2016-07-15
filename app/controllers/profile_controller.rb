class ProfileController < ApplicationController
    
    def myprofile
        @reviews = Review.where(user_id: current_user.id)
        @pages = Page.where(page_type: "codereview")
    end
    
end
