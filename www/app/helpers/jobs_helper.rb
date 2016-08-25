module JobsHelper
  def job_size(key, value)
    @filterrific_to_a ||= @filterrific.find.to_a
    "(#{@filterrific_to_a.select {|job| job[key.to_sym] == value }.size})"
  end
end
