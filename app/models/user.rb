# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  preffered_name         :string
#  house                  :string
#  admin                  :boolean
#  twitter                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
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
  
  def test
    useless = 'useless'
    "testdkdkdkdkkdkdkdkdkk ksd fksd flksjd fkjsdlkfj sldkfjslkdfjlskdjflksdj flksdjflksjdfl ksjdfl ksjdflksjdflks jdflksjd flkdfs df sdf sdf sd"
  end
end
