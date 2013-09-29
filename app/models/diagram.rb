class Diagram < ActiveRecord::Base
  has_attached_file :image, :styles => {:large => '800x800>', :medium => '400x400>', :thumb => '100x100>'}, :default_url => '/images/:style/missing.png'

  belongs_to :question
end
