module ApplicationHelper
  def dashboard_primary_button
    if @user.donater?
      link_to 'https://www.dropbox.com/home/Apps/Splashbox' do
        button_tag sanitize('View Photos &rarr;'), class: 'purple'
      end
    else
      button_tag sanitize('Donate Now &rarr;'), class: 'purple donate'
    end
  end

  def waitlist_primary_button
    if @user.present?
      button_tag sanitize('Donate Now &rarr;'), class: 'purple donate'
    else
      link_to dashboard_path do
        button_tag sanitize('View Dashboard &rarr;'), class: 'purple'
      end
    end
  end

  def waitlist_spot
    hash = Hash[@waiters.map.with_index.to_a]
    hash[@user] + 1
  end
end
