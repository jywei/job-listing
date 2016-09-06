module ResumesHelper

  def resume_size(key, value)
    @filterrific_to_a ||= @filterrific.find.to_a
    if value.class == Range
      "(#{@filterrific_to_a.select { |resume| value.include?(resume[key])  }.size})"
    else
      "(#{@filterrific_to_a.select { |resume| resume[key] == value  }.size})"
    end
  end

  def DesiredJobSalary_size(value)
    @filterrific_to_a ||= @filterrific.find.to_a
    "(#{@filterrific_to_a.select { |resume| value.include?(resume.djs_salary)  }.size})"
  end

  def calculate_age(date)
    (Date.today.year - date.year).to_s
  end
end
