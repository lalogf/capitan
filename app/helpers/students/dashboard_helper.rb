module Students::DashboardHelper
  def age birthdate
    now = Time.now.utc.to_date
    now.year - birthdate.year - (birthdate.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  def percentage grades
    round(grades[:points] * 100.0 / grades[:max])
  end

  def round num
    i, f = num.to_i, num.to_f
    i == f ? i : f.round(1)
  end
end
