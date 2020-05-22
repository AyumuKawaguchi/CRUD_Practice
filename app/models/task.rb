class Task < ApplicationRecord

  before_validation

  validates :name, presence: true
  validate  :validate_name_not_including_comma


  private

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
    # &.でnilを返してエラーを回避するような役目
  end
end
