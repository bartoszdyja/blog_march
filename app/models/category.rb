class Category < ActiveRecord::Base
  validates_uniqueness_of :name, :case_sensitive => true	
  has_many :products
end
