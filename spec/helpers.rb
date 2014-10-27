module Helpers
  def login
    create(:user)
    visit login_path
    fill_in "email", with: "user@gmail.com"
    fill_in "password", with: "pass"
    click_button "Войти"
  end
end
