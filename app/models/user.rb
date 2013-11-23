class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  field :locked_at,       :type => Time

  field :name, :type => String
  field :username, :type => String

  attr_accessor :login

  validates :name, presence: true, uniqueness: true
  # validates :username, presence: true
  validates :email, presence: true

  # has_one :user_info,:dependent => :destroy
  # has_many :items,    :dependent => :destroy
  # has_many :people,   :dependent => :destroy
  # has_many :accounts, :dependent => :destroy
  # has_many :bills,    :dependent => :destroy
  with_options :dependent => :destroy do |assoc|
    assoc.has_many :items
    assoc.has_many :people
    assoc.has_many :accounts 
    assoc.has_many :bills

  end

  after_create :set_init_info
  before_create :set_default_name

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({ :name =>  /^#{Regexp.escape(login)}$/i }, { :email =>  /^#{Regexp.escape(login)}$/i }).first
    else
      super
    end
  end

  def set_init_info
    # info = create_user_info
    Settings.bill_types.values.each{|i| items.create(name: '无', flag: i)}
    Settings.default_items.each{|p| items.create(p)}
    Settings.default_people.each{|p| people.create(p)} 
    Settings.default_accounts.each{|p| accounts.create(p)}
  end

  def set_default_name
    if username.blank? && email
      username = email.split('@')[0]
    end
  end

  def username
    read_attribute(:username) || name
  end

end
