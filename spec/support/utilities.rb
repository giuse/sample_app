include ApplicationHelper

def define_buttons
  let(:submit_btn) { "Create my account" }
  let(:signup_btn) { "Sign up" }
  let(:signin_btn) { "Sign me in" }
  let(:edit_btn)   { "Save changes" }
end

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button signin_btn
end
 
def invalid_signin
  click_button signin_btn
end

def sign_in(user, options={})
  if options[:no_capybara]
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button signin_btn
  end
end

def check_user_form_errors
  ["Name can't be blank",
   "Email can't be blank",
   "Email is invalid",
   "Password can't be blank",
   "Password is too short"].each do |error_msg|
      it { should have_content(error_msg) }  
    end
end
# def check_user_form_errors
#   it { should have_content("Name can't be blank")}
#   it { should have_content("Email can't be blank")}
#   it { should have_content("Email is invalid")}
#   it { should have_content("Password can't be blank")}
#   it { should have_content("Password is too short")}
# end

RSpec::Matchers.define :have_error_message do |message=''|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message=''|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end

# TODO: MAKE THIS WORK!! Use it to check the content of a form
# RSpec::Matchers.define :have_field_content do |field, content|
#   match do |page|
#     expect(page).to have_selector(field, text: content)
#   end
# end
