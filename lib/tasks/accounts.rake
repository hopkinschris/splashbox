desc "Release 5 accounts from the waitlist"
task release: :environment do
  puts "Releasing 5 accounts from waitlist..."
  users = User.where(waitlist: true).first(5)
  users.each{ |u| u.activate }
  puts "Done."
end
