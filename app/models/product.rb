# -*- encoding : utf-8 -*-
class Product < ActiveRecord::Base
has_many :items, dependent: :destroy
has_one :order, through: :items, dependent: :destroy
belongs_to :category
has_many :marks, dependent: :destroy
has_many :marking_users, through: :marks, source: :user

has_many :comments, as: :commentable,dependent: :destroy
mount_uploader :picture, PictureUploader
 
 validates :name, presence: true, length: {maximum: 50}
 validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
 validates :inventory, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

 searchable do
   text :name
   float :price
  end
end
