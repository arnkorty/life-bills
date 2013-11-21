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

  # has_one :user_info,:dependent => :destroy
  has_many :items,    :dependent => :destroy
  has_many :people,   :dependent => :destroy
  has_many :accounts, :dependent => :destroy
  has_many :bills,    :dependent => :destroy

  after_create :set_init_info

  def set_init_info
    # info = create_user_info
    Settings.bill_types.values.each{|i| items.create(name: '无', flag: i)}
    Settings.default_items.each{|p| items.create(p)}
    Settings.default_people.each{|p| people.create(p)} 
    Settings.default_accounts.each{|p| accounts.create(p)}
  end
end
