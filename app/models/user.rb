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
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %i[twitter]
  has_many :appointments, dependent: :destroy
  has_many :events, through: :appointments
  has_many :comments
  def name
    if preffered_name.blank?
      "#{first_name} #{last_name}"
    else
      preffered_name
    end
  end

  def all_events
    joined_events = events.pluck(:id)
    Event.where('owner_id=? OR id IN (?)', id, joined_events).order(date: :asc, start_time: :asc)
  end

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first
    if user
      unless user.provider
        user.provider = auth.provider
        user.uid = auth.uid
      end
    else
      user = where(provider: auth.provider, uid: auth.uid).first_or_create
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.preffered_name = auth.info.nickname 
      user.username = auth.info.nickname 
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
    user
  end
end
