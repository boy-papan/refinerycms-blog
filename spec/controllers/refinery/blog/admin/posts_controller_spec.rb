require "spec_helper"

module Refinery
  module Blog
    module Admin
      describe PostsController, :focus do
        refinery_login_with :refinery_user

        describe "#delete_translation" do
          let!(:blog_post) { FactoryGirl.create(:blog_post) }

          before do
            blog_post.translations.create(:locale => :fr, :title => 'Un titre francais', :body => "La baguette, c'est bon. Mangez-en.")
          end

          it "destroys the translation" do
            post :delete_translation, :id => blog_post.id, :locale_to_delete => :fr
            blog_post.translations.exists?(:locale => :fr).should be_false
          end

          it "redirects on success" do
            post :delete_translation, :id => blog_post.id, :locale_to_delete => :fr
            response.should be_redirect
          end
        end
      end
    end
  end
end
