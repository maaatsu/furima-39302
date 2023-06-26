require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
      context '正常な場合' do
        it '正常に登録できること' do
          expect(@user).to be_valid
        end
      end

      context '異常な場合' do
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
        expect(another_user.errors.full_messages).to include('Email has already been taken') if another_user.errors.has_key?(:email)
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

      it 'パスワードは、半角英字での入力が必須であること' do
        @user.password = 'password' # 半角英字のみのパスワードを設定
        @user.valid?
        expect(@user.errors[:password]).to include('は数字を含めて設定してください') if @user.password =~ /^(?=.*[a-zA-Z])(?=.*[0-9]).+$/
      end

      it 'パスワードは、半角数字での入力が必須であること' do
        @user.password = '123456' # 数字のみのパスワードを設定
        @user.valid?
        expect(@user.errors[:password]).to include('は英字を含めて設定してください') if @user.password =~ /^(?=.*[a-zA-Z])(?=.*[0-9]).+$/
      end

      it 'パスワードは、半角英数字混合での入力が必須であること' do
        @user.password = 'パスワード' # 全角文字のみのパスワードを設定
        @user.valid?
        expect(@user.errors[:password]).to include('は英字と数字の両方を含めて設定してください') if @user.password =~ /^(?=.*[a-zA-Z])(?=.*[0-9]).+$/
      end   

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'お名前(全角)の名字が必須であること' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors[:last_name]).to include('は全角ひらがな、カタカナ、漢字で入力してください')
      end
      
      it 'お名前(全角)の名前が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors[:first_name]).to include('は全角ひらがな、カタカナ、漢字で入力してください')
      end

      it 'お名前(全角)の名前は全角での入力が必須であること' do
        @user.first_name = 'Yamada'
        @user.valid?
        expect(@user.errors[:first_name]).to include('は全角ひらがな、カタカナ、漢字で入力してください')
      end
      
      it 'お名前(全角)の名字は全角での入力が必須であること' do
        @user.last_name = 'Tarou'
        @user.valid?
        expect(@user.errors[:last_name]).to include('は全角ひらがな、カタカナ、漢字で入力してください')
      end
      
      it 'お名前カナ(全角)は、名字が必須であること' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include('は全角カタカナで入力してください')
      end

      it 'お名前カナ(全角)は、名前が必須であること' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors[:last_name_kana]).to include('は全角カタカナで入力してください')
      end

      it 'お名前カナ名字(全角)は、全角（カタカナ）での入力が必須であること' do
        @user.first_name_kana = 'Yamada'
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include('は全角カタカナで入力してください')
      end

      it 'お名前カナ名前(全角)は、全角（カタカナ）での入力が必須であること' do      
        @user.last_name_kana = 'Yamada'
        @user.valid?
        expect(@user.errors[:last_name_kana]).to include('は全角カタカナで入力してください')
      end

      it '生年月日が必須であること' do
        @user.date_of_birth = nil
        @user.valid?
        expect(@user.errors[:date_of_birth]).to include('を入力してください')
    
        @user.date_of_birth = Date.new(1990, 1, 1)
        @user.valid?
      end
    end
  end
end