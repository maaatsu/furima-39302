class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :password, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/, message: 'は半角英数字混合で入力してください' }
  validates :last_name, presence: { message: 'お名前(全角)を入力してください' }, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角ひらがな、カタカナ、漢字で入力してください' }
  validates :first_name, presence: { message: 'お名前(全角)を入力してください' }, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角ひらがな、カタカナ、漢字で入力してください' }  
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' }
  validates :date_of_birth, presence: { message: 'を入力してください' }

  validate :password_complexity

  private

  def password_complexity
    return if encrypted_password.blank?

    # 半角英数字混合チェック
    unless encrypted_password.match?(/\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/)
      errors.add(:encrypted_password, 'は半角英数字混合で入力してください')
    end
  end
end
