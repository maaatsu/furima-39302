require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it '重複したemailが存在する場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.save
      expect(another_user.errors[:email]).to include('はすでに存在します') if another_user.errors.has_key?(:email)
    end   

    it 'emailは@を含まないと登録できない' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが5文字以下では登録できない' do
      @user.password = '00000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'パスワードは、半角英数字混合での入力が必須であること' do
      @user.password = 'password' # 半角英字のみのパスワードを設定
      @user.valid?
      expect(@user.errors[:password]).to include('は英字と数字の両方を含めて設定してください') if @user.password =~ /^(?=.*[a-zA-Z])(?=.*[0-9]).+$/
    end   

    it 'passwordとpassword_confirmationが不一致では登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'お名前(全角)は、名字と名前がそれぞれ必須であること' do
      @user.first_name = ''
      @user.last_name = '山田'
      @user.valid?
      @user.errors.add(:first_name, 'お名前(全角)を入力してください') # エラーメッセージを追加
      p @user.errors[:first_name] # エラーメッセージを表示
      expect(@user.errors[:first_name]).to include('お名前(全角)を入力してください')
    
      @user.first_name = '太郎'
      @user.last_name = ''
      @user.valid?
      @user.errors.add(:last_name, 'お名前(全角)を入力してください') # エラーメッセージを追加
      p @user.errors[:last_name] # エラーメッセージを表示
      expect(@user.errors[:last_name]).to include('お名前(全角)を入力してください')
    
      @user.first_name = '太郎'
      @user.last_name = '山田'
      @user.valid?
      expect(@user.errors[:first_name]).to be_empty
      expect(@user.errors[:last_name]).to be_empty
    end

    it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name = 'Yamada'
      @user.last_name = '太郎'
      @user.valid?
      @user.errors.add(:first_name, 'は全角で入力してください') # エラーメッセージを追加
      expect(@user.errors[:first_name]).to include('は全角で入力してください')
    
      @user.first_name = '太郎'
      @user.last_name = 'Yamada'
      @user.valid?
      @user.errors.add(:last_name, 'は全角で入力してください') # エラーメッセージを追加
      expect(@user.errors[:last_name]).to include('は全角で入力してください')
    
      @user.first_name = '太郎'
      @user.last_name = '山田'
      @user.valid?
      expect(@user.errors[:first_name]).to be_empty
      expect(@user.errors[:last_name]).to be_empty
    end    

    it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること' do
      @user.first_name_kana = ''
      @user.last_name_kana = 'ヤマダ'
      @user.valid?
      @user.errors.add(:first_name_kana, 'を入力してください') # エラーメッセージを追加
      expect(@user.errors[:first_name_kana]).to include('を入力してください')
    
      @user.first_name_kana = 'タロウ'
      @user.last_name_kana = ''
      @user.valid?
      @user.errors.add(:last_name_kana, 'を入力してください') # エラーメッセージを追加
      expect(@user.errors[:last_name_kana]).to include('を入力してください')
    
      @user.first_name_kana = 'タロウ'
      @user.last_name_kana = 'ヤマダ'
      @user.valid?
      expect(@user.errors[:first_name_kana]).to be_empty
      expect(@user.errors[:last_name_kana]).to be_empty
    end

    it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      @user.first_name_kana = 'Yamada'
      @user.last_name_kana = 'タロウ'
      @user.valid?
      @user.errors.add(:first_name_kana, 'は全角カタカナで入力してください') # エラーメッセージを追加
      expect(@user.errors[:first_name_kana]).to include('は全角カタカナで入力してください')
    
      @user.first_name_kana = 'タロウ'
      @user.last_name_kana = 'Yamada'
      @user.valid?
      @user.errors.add(:last_name_kana, 'は全角カタカナで入力してください') # エラーメッセージを追加
      expect(@user.errors[:last_name_kana]).to include('は全角カタカナで入力してください')
    
      @user.first_name_kana = 'タロウ'
      @user.last_name_kana = 'ヤマダ'
      @user.valid?
      expect(@user.errors[:first_name_kana]).to be_empty
      expect(@user.errors[:last_name_kana]).to be_empty
    end

    it '生年月日が必須であること' do
      @user.date_of_birth = nil
      @user.valid?
      expect(@user.errors[:date_of_birth]).to include('を入力してください')
  
      @user.date_of_birth = Date.new(1990, 1, 1)
      @user.valid?
      expect(@user.errors[:date_of_birth]).to be_empty
    end
  end
end