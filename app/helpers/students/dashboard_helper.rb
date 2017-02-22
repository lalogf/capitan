module Students::DashboardHelper
  def age birthdate
    now = Time.now.utc.to_date
    now.year - birthdate.year - (birthdate.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def percentage grades
    points = grades[:points] != nil ? grades[:points] : 0
    return grades[:max] != nil ? round(points * 100.0 / grades[:max]) : 0
  end

  def round num
    i, f = num.to_i, num.to_f
    i == f ? i : f.round(1)
  end
end
