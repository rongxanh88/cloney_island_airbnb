job_type :runner,  "cd :path && bin/rails runner -e :development ':task' :output"

every 1.minute do
  runner "Listing.check_for_new"
  runner "Listing.check_for_old"
  # rake "listing:all"
  # command "/usr/bin/my_great_command"
  # runner "MyModel.task_to_run_at_four_thirty_in_the_morning"
end