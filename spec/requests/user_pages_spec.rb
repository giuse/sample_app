require 'spec_helper'

describe 'User page' do
  
  define_buttons
  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title "All users"}
    it { should have_content "All users"}

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector("div.pagination") }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end

  describe "profile" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }    
    it { should have_title(user.name) }    
  end

  describe "signup" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit_btn }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit_btn }

        it { should have_title('Sign up') }
        check_user_form_errors
      end
    end

    describe "with valid information" do
      let(:user_email) { "user@example.com" }
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: user_email
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit_btn }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit_btn }
        let(:found_user) { User.find_by email: user_email }

        it { should have_link('Sign out') }
        it { should have_title(found_user.name) }
        it { should have_success_message("Welcome") }

        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end
    it { should have_content("Update your profile") }
    it { should have_title("Edit user") }
    it { should have_link('change', href: 'http://gravatar.com/emails')}
    # it { should have_field_content("input#user_name", user.name) }

    describe "with invalid information" do
      before { click_button edit_btn }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirmation",     with: user.password
        click_button edit_btn
      end

      it { should have_title(new_name) }
      it { should have_success_message("updated") }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end