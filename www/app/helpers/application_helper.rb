module ApplicationHelper
  def company_unread_cover_letter_count(company)
    unread_count = 0
    company.jobs.each do |job|
      job.cover_letters.each do |cover_letter|
        unread_count += 1 if !cover_letter.is_read
      end
    end
    unread_count == 0 ? nil : unread_count
  end

  def job_unread_cover_letter_count(job)
    unread_count = 0
    job.cover_letters.each do |cover_letter|
      unread_count += 1 if !cover_letter.is_read
    end
    unread_count == 0 ? nil : unread_count
  end

  def is_employer?
    if current_user
      current_user.has_role? :employer
    else
      current_user
    end
  end

  def is_seeker?
    if current_user
      current_user.has_role? :seeker
    else
      current_user
    end
  end

  def check_carousel_number(i)
    if i == 0 || i == 2 || i == 4 || i == 5 || i == 7 || i == 9 || i == 10 || i == 12 || i == 14 || i == 15 || i == 17 || i == 19 
      return true
    else
      return false
    end
  end

  def check_carousel_number2(i)
    if i == 3 || i == 8 
      return true
    else
      return false
    end
  end
end

