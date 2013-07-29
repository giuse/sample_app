Given /^a user visits the signin page$/
  visit signin_path
end

When /^he submits invalid signin information$/
  click_button "Sign in"
end

Then /^he should see an error message$/
  expect(page).to have_selector('div.alert.alert-error')
end

Given /^the user has an account$/
  @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
end

When /^the user submits valid signin information$/
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

Then /^he should see his profile page$/
  expect(page).to have_title(@user.name)
end

Given /^he should see a signout link$/
  expect(page).not_to have_link('Sign out', href: signout_path)
end
