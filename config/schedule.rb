every 1.minute do
  # runner "Listing.check_for_new"
  rake "listing:all"
  # command "/usr/bin/my_great_command"
end