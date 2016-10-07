module CoursesHelper
    def week_couting(start,duration)
        r = (start...(start+duration)).to_a
        last = r.pop
        r.join(", ") + " y " + last.to_s
    end

    def sprint_lessons(sprint_id,lessons)
        lessons.select { |l| l[:sprint_id] == sprint_id }
    end
end
