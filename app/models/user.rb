class User < ActiveRecord::Base
  has_many :microposts , dependent: :destroy
  #before_save { self.email = email.downcase }
  before_save { email.downcase! }
  before_create :create_remember_token

  validates :name, presence: true , length: { maximum: 50 }
 # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i   #不允许出现连续点号的正则表达式
  validates :email, presence: true,
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  has_secure_password
  #validates是一个方法


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)  #调用 to_s，是为了处理输入为 nil 的情况，在浏览器中不会遇到，测试时偶尔会出现。）
  end

  def feed
    #Micropost.where('user_id=?',id)
    microposts
  end



private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

  end
#Active Record 是把模型的属性和数据库表中的列对应的，如果不指定 self 的话，我们就只
# 是创建了一个名为 remember_token 的局部变量而已，这可不是我们期望得到的结果。加上 self 之后
# ，赋值操作就会把值赋值给用户的 remember_token 属性，保存用户时，随着其他的属性一起存入数据库。
# （现在你知道了为什么代码 6.20 中的 before_save 为什么要用 self.name 而不直接用 email。）