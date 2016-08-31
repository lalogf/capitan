class ProfileController < ApplicationController
    
    def myprofile
        @sprints = SprintSummary.uniq.pluck(:sprint_id)
    end
    
    def codereview
        @reviews = Review.where(user_id: current_user.id)
        @pages = Page.where(page_type: "codereview").order(:lesson_id)
    end
    
end
