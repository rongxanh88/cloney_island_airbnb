# require 'rails_helper'
#
# RSpec.describe 'As a host' do
#
#   xit 'can create a new listing' do
#     visit root_path
#     hover_on 'Become a Host'
#     click_on 'Host an Experience'
#
#     expect(path).to be(new_experience_path)
#     fill_in "Category", :with => "Arts") #Check boxes
#     fill_in "Title", :with => "Visit the Only Worthy Gallery in the Galaxy") #Text field
#     fill_in "Time", :with => "2 hours") #Text field
#     fill_in "Tagline", :with => "If you're with us, you're awesome!") #Text box
#     #fill_in "Photos", :with => "Photos") # Photo upload
#     fill_in "What", :with => "Walk around and ask questions about art. Do you buy art because it's evocative? Would you buy art that disgusts you becaues it evokes that feeling?") #Text box
#     fill_in "Where", :with => "The place beyond the pines.") #Text box
#     fill_in "Provisions", :with => "Water, energy bars, chewing gum.") #Text box
#     fill_in "Notes", :with => "Bring yourself. Bring your smile. Bring your happiness and share it.") #Text box
#
#     click_on "Create Experience"
#
#     expect(user.roles).should include('traveler') #make this work!
#     expect(user.roles).should include('host') # and this!
#   end
# end
