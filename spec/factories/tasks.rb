FactoryBot.define do
  factory :task do
    name { 'テストを書く' }
    description { 'Rspec&Capybara&FactoryBotを用意する' }
    user
    # association :user, factory: :admin_user
    # これは先ほど定義した:userという名前のファクトリーをTaskモデルに紐づけられたuserファクトリーの中身を生成するのに利用するという意味。
    # 簡単に言えばTaskオブジェクトが生成された際に、userにuserファクトリーのデータが埋め込まれる的な意味合い。
  end
end