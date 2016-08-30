module CoursesHelper
    def week_couting(start,duration)
        r = (start...(start+duration)).to_a
        last = r.pop
        r.join(", ") + " y " + last.to_s
    end
end
