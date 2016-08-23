module CompaniesHelper
  def company_size(key, value)
    @filterrific_to_a ||= @filterrific.find.to_a
    "(#{@filterrific_to_a.select {|company| company[key.to_sym] == value }.size})"
  end
end
