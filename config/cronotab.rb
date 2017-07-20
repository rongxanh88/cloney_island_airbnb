# cronotab.rb — Crono configuration file
#
# Here you can specify periodic jobs and schedule.
# You can use ActiveJob's jobs from `app/jobs/`
# You can use any class. The only requirement is that
# class should have a method `perform` without arguments.
#
# class TestJob
#   def perform
#     puts 'Test!'
#   end
# end
#
# Crono.perform(TestJob).every 2.days, at: '15:30'
#
Crono.perform(CreateListingsJob).every 1.day, at: {hour: 10, min: 0}
Crono.perform(DeleteListingsJob).every 1.day, at: {hour: 10, min: 0}
Crono.perform(CreateListingsJob).every 1.day, at: {hour: 10, min: 10}
Crono.perform(DeleteListingsJob).every 1.day, at: {hour: 10, min: 10}
Crono.perform(CreateListingsJob).every 1.day, at: {hour: 10, min: 20}
Crono.perform(DeleteListingsJob).every 1.day, at: {hour: 10, min: 20}
Crono.perform(CreateListingsJob).every 1.day, at: {hour: 10, min: 30}
Crono.perform(DeleteListingsJob).every 1.day, at: {hour: 10, min: 30}
Crono.perform(CreateListingsJob).every 1.day, at: {hour: 10, min: 40}
Crono.perform(DeleteListingsJob).every 1.day, at: {hour: 10, min: 40}
Crono.perform(CreateListingsJob).every 1.day, at: {hour: 10, min: 50}
Crono.perform(DeleteListingsJob).every 1.day, at: {hour: 10, min: 50}