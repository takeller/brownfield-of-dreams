require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and is sent to the log in page', :js do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)
    accept_confirm do
      click_on 'Bookmark'
    end
    expect(current_path).to eq(login_path)
  end
end
