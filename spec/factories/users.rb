FactoryBot.define do
  # factory :admin_user, class: User do ファクトリ名がアドミンユーザーで実際に参照しているモデルはユーザーだよってこと
  factory :user do
    name { 'テストユーザー' }
    email { 'test1@example.com' }
    password { 'password' }
  end
end