class MoveUsersColumnToProfile < ActiveRecord::Migration
  def change
    User.find_each do |user|
      profile = Profile.find_or_initialize_by(
        user: user,
        name: user.name,
        lastname: "#{user.lastname1} #{user.lastname2}",
        biography: user.biography,
        dni: user.dni,
        phone1: user.phone1,
        phone2: user.phone2,
        facebook_link: user.facebook_username
      )
      profile.save!
    end
  end
end
