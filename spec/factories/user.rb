FactoryBot.define do
  factory :user do
    email { 'test@example.com' }
    password { '123456789aA#' }
    password_confirmation { '123456789aA#' }
  end
end
