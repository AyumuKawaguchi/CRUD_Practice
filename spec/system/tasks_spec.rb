require 'rails_helper'

describe 'タスク管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a)}  # letを使うかlet!を使うかの問題であるが、let自体は引数が呼ばれなければ動かない（task_a）ので前提条件としてタスクを作成が必須なら、let!にすることで強制的に作成できるので利用すべき。また、テスト毎のcontext内に必要ならばtask_aを作成するという方法ももちろんあるけどめんどいので。
  before do
    # login_userは一度スルーされて、contextの処理が走った中で、発見され初めてログインされるイメージ。
    visit login_path # ステップ１ ログイン画面にアクセスする
    fill_in 'メールアドレス', with: login_user.email # ステップ２ メールアドレスを入力する
    fill_in 'パスワード', with: login_user.password # ステップ３ パスワードを入力する
    click_button 'ログインする' # ステップ４ ログインするボタンをおす
  end

  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    it { expect(page).to have_content '最初のタスク' }
  end
  
  describe'一覧表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) {user_a} #この段階に置いてuser_aに対応したlet関数が呼び出されて、login_userとして利用される。

      #  [   この部分がshared_example_forで置換される   ]
      # it 'ユーザーAが作成したタスクが表示される' do
      #   # 作成済みのタスクの名称が画面上に表示されていることを確認
      #   expect(page).to have_content '最初のタスク'
      # end
      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) {user_b} #この段階に置いてuser_bに対応したlet関数が呼び出されて、login_userとして利用される。
      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).not_to have_content '最初のタスク'
      end
    end
  end

  describe'詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end
end

describe '新規作成機能' do
  
end

# [共通化する前の原文]

# describe 'タスク管理機能', type: :system do
#   describe'一覧表示機能' do
#     before do
#       # ユーザーAを作成しておく
#       # user_a = FactoryBot.create(:user) #テストデータが1つのときはこれでも良い
#       user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
#       # 作成者がユーザーAであるタスクを作成しておく
#       FactoryBot.create(:task, name: '最初のタスク', user: user_a)
#     end

#     context 'ユーザーAがログインしている時' do
#       before do
#         # ユーザーAでログインする
#         visit login_path # ステップ１ ログイン画面にアクセスする
#         fill_in 'メールアドレス', with: 'a@example.com' # ステップ２ メールアドレスを入力する
#         fill_in 'パスワード', with: 'password' # ステップ３ パスワードを入力する
#         click_button 'ログインする' # ステップ４ ログインするボタンをおす
#       end

#       it 'ユーザーAが作成したタスクが表示される' do
#         # 作成済みのタスクの名称が画面上に表示されていることを確認
#         expect(page).to have_content '最初のタスク'
#       end
#     end

#     context 'ユーザーBがログインしているとき' do
#       before do
#         # ユーザーBを作成しておく
#         FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')
#         # ユーザーBでログインする
#         visit login_path # ステップ１ ログイン画面にアクセスする
#         fill_in 'メールアドレス', with: 'b@example.com' # ステップ２ メールアドレスを入力する
#         fill_in 'パスワード', with: 'password' # ステップ３ パスワードを入力する
#         click_button 'ログインする' # ステップ４ ログインするボタンをおす
#       end

#       it 'ユーザーAが作成したタスクが表示されない' do
#         #ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認
#         # expect(page).to have_no_content '最初のタスク'
#         expect(page).not_to have_content '最初のタスク'
#       end
#     end
#   end
# end

