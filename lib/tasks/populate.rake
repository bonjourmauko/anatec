class ActiveRecord::Base
  def self.truncate!
    connection.execute("TRUNCATE #{table_name} RESTART IDENTITY;")
  end
end

namespace :db do
  desc 'Populates the database with dummy data'
  task populate: :environment do
    [Book, User].map(&:truncate!)

    20.times do |n|
      User.create!(
        email: "jean#{n + 1}@serien.fr",
        password: 'password',
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      )
    end

    200.times do
      Book.create!(
        title: Faker::Company.catch_phrase,
        author: Faker::Name.name,
        owner: User.order('RANDOM()').first
      )
    end
  end
end
