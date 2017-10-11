# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  first_name     :string
#  last_name      :string
#  email          :string
#  preffered_name :string
#  house          :string
#  admin          :boolean
#  twitter        :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def name
    if preffered_name.blank?
      "#{first_name} #{last_name}"
    else
      preffered_name
    end
  end
end
