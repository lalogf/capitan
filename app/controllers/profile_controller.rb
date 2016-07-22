class ProfileController < ApplicationController
    
    def codereview
        @reviews = Review.where(user_id: current_user.id)
        @pages = Page.where(page_type: "codereview")
    end
    
    def myprofile
    end
    
end
