class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  has_many :identities
  has_many :polls
  has_many :comments
  has_many :reports

  has_reputation :votes, source: {reputation: :votes, of: :options}, aggregated_by: :sum

  validates :name, length: { maximum: 20 }, presence: true, uniqueness: true
  validates :email, :password, presence: true

  mount_uploader :image, ImageUploader

  def vote_cache_key votable
    'user_' + id.to_s + 'voted_for' + votable.updated_at.to_s
  end

  def is_neutral?(votable)
    Rails.cache.fetch(vote_cache_key votable) {
      return true unless votable.evaluations.present?
      return true unless votable.evaluations.where(source_id: self.id).present?
      votable.evaluations.where(source_id: self.id).first.value == 0
    }
  end

  def reported?(reportable)
    reportable.reports.where(user_id: id).present?
  end

  def twitter
    identities.where( :provider => "twitter" ).first
  end

  def twitter_client
    @twitter_client ||= Twitter.client( access_token: twitter.accesstoken )
  end

  def facebook
    identities.where( :provider => "facebook" ).first
  end

  def facebook_client
    @facebook_client ||= Facebook.client( access_token: facebook.accesstoken )
  end

  def instagram
    identities.where( :provider => "instagram" ).first
  end

  def instagram_client
    @instagram_client ||= Instagram.client( access_token: instagram.accesstoken )
  end

  def google_oauth2
    identities.where( :provider => "google_oauth2" ).first
  end

  def google_oauth2_client
    if !@google_oauth2_client
      @google_oauth2_client = Google::APIClient.new(:application_name => 'HappySeed App', :application_version => "1.0.0" )
      @google_oauth2_client.authorization.update_token!({:access_token => google_oauth2.accesstoken, :refresh_token => google_oauth2.refreshtoken})
    end
    @google_oauth2_client
  end
end
