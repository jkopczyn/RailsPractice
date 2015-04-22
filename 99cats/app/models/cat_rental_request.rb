require 'byebug'

class CatRentalRequest < ActiveRecord::Base
  validates :status, :start_date, :end_date, :cat_id, :user_id, presence: true
  validates :status, inclusion: {in: %w[Approved Denied Pending] }
  validate :no_overlapping_approved_requests
  validate :real_user
  
  after_initialize :set_default_status

  belongs_to :cat, class_name: :Cat, foreign_key: :cat_id, primary_key: :id
  belongs_to :requester, class_name: :User, foreign_key: :user_id
  
  def approve!
    CatRentalRequest.transaction do
      self.status = "Approved"

      save!
      overlapping_pending_requests.each do |request|
        request.deny!
      end
    end
  end

  def deny!
    self.status = "Denied"
    save!
  end

  private

  def overlapping_requests

    CatRentalRequest.where(cat_id: self.cat_id)
                    .where("id != ?", self.id)
                    .where([<<-SQL, { start_date: start_date, end_date: end_date }])
                    start_date <= :end_date AND end_date >= :start_date
                    SQL
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "Pending")
  end

  def no_overlapping_approved_requests
    if self.status != "Approved"
      return false
    end
    overlapping_requests.each do |request|
      if "Approved" == request.status
        errors.add(:base, "Conflicting approved request #{request.id}")
      end
    end
  end

  def real_user
    if 0 == user_id
      errors[:user_id] << "0 isn't a real user id"
    end
  end

  def set_default_status
    status ||= "Pending"
  end
end
