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

FactoryGirl.define do
  factory :goal do
    private false
    content "I'm going to do it!"
    title "Succeed!"
    user_id 1
  end

end
