class Post < ActiveRecord::Base
  attr_accessible :body, :title

  scope :published, lambda { where(:published => true) }
end
