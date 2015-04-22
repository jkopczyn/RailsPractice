# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  private    :boolean          default("t"), not null
#  content    :text             not null
#  title      :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ActiveRecord::Base
  validates :title, :content, :user, presence: true
  validates :private, inclusion: { in: [true, false] }

  belongs_to :user

  def public
    !self.private
  end
end
