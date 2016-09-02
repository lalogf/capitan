module ProfileHelper
  def age(user)
    "#{user.age} años" unless user.age.nil?
  end

  def district(user)
    user.district.blank? ? 'Lima' : user.district
  end

  def biography(user)
    user.biography.blank? ? 'Soy un estudiante en Laboratoria' : user.biography
  end
end
