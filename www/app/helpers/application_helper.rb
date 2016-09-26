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
end
