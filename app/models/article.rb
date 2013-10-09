class Article < ActiveRecord::Base
  default_scope {order 'created_at DESC'}
  attr_accessor :image
  has_attached_file :image, styles:{small: '200x200#', medium:'400x300>',large:'600x500>'},
                     path: "#{Rails.root}/public/:attachment/:id/:filename",
                     url: '/:attachment/:id/:filename'

  has_many :comments, dependent: :destroy
  has_many :users, through: :comments



end
