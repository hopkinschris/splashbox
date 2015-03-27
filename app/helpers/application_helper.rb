module ApplicationHelper
  def dashboard_primary_button
    link_to 'https://www.dropbox.com/home/Apps/Splashbox' do
      button_tag sanitize('View Photos &rarr;'), class: 'purple'
    end
  end

  def waitlist_spot
    hash = Hash[@waiters.map.with_index.to_a]
    hash[@user] + 1
  end
end
