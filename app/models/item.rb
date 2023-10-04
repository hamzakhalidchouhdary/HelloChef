class Item < ApplicationRecord
  belongs_to :shop
  # belongs_to :staff

  # reterive lables as array
  def labels
    labels = read_attribute(:labels)
    labels.split(',') if labels
  end

  # write labels as string
  def labels=(value)
    write_attribute(:labels, value.join(','))
  end

  def self.default_scope
    # self[:labels].split(',').map(&:strip)
  end
end
