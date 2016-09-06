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

  def percentage(scored, total)
    (scored / total.to_f) * 100
  end

  def percent(scored, total)
    (scored.zero? or total.zero?) ? 0 : percentage(scored, total)
  end
end
