class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, :user_id, :description, presence: true
  validates :color, inclusion: { in: %w{ calico blue black orange }}
  validates :sex, inclusion: { in: %w{ M F }}
  validate :real_user

  belongs_to :owner, class_name: :User, foreign_key: :user_id

  DAYS_IN_YEAR = 365


  def age
    (Time.now.to_date - birth_date)/DAYS_IN_YEAR
  end

  has_many(
    :cat_rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )

  private
  def real_user
    if 0 == user_id
      errors[:user_id] << "0 isn't a real user id"
    end
  end
end
