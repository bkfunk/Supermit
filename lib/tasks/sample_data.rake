namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:first_name => "Brian",
                 :last_name => "Karfunkel",
                 :email => "bkarfunkel@gmail.com",
                 :identifier_url => "https://www.google.com/accounts/o8/id?id=AItOawmiCj-qwvuZXAZX1qU4lrpBVjvmKshpA7E")
    19.times do |n|
      first_name  = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = Faker::Internet.email
      url = Faker::Internet.ip_v4_address + "/" + first_name + "/" + last_name
      User.create!(:first_name => first_name,
                   :last_name => last_name,
                   :email => email,
                   :identifier_url => url)
    end
    
    User.first.todos.create!(:title => "Example Todo",
                             :desc => Faker::Lorem.paragraph,
                             :due_at => Time.now,
                             :has_time_due => true,
                             :parent_id => 1)
    29.times do
      User.all(:limit => 6).each do |user|
        
        has_time_due = rand(2) > 0 # Create random boolean
        due_at = !has_time_due ? (Date.today + rand(90)).to_time : (Date.today + rand(90)).to_time + rand(1/Date::HOURS_IN_DAY).hours
        
        # For random cases, make the new todo a parent of another todo
        todos = user.todos # Get list of todos for this user
        #puts todos.count.to_s + " todos for User " + user.first_name + " " + user.last_name
        # If at least one todo, and 20% of the time
        if (!todos.nil? && todos.count > 0 && rand < 0.2)
          parent = todos.select(:id).shuffle.first # Get an array of all todos IDs
          parent_id = parent.id unless parent.nil?
         
        end
        new_todo = user.todos.create!(:title => Faker::Lorem.words.join(' ').capitalize,
                           :desc => Faker::Lorem.paragraph,
                           :due_at => due_at,
                           :has_time_due => has_time_due,
                           :parent_id => parent_id)
        new_todo.update_attribute(:parent_id, new_todo.id) unless !new_todo.parent_id.nil?
        
      end
    end
    
    Outlet.create!(:title => "Tin House",
                   :url => "http://www.tinhouse.com/magazine/")
    Outlet.create!(:title => "McSweeney's Quarterly Concern",
                   :affiliation => "McSweeney's",
                   :url => "http://www.mcsweeneys.net/books#category0",
                   :submit_method => "online")
    3.times do
      Outlet.create!(:title => Faker::Address.city + " Review",
                     :url => Faker::Internet.domain_name)
    end
    
    genres = [ 'fiction', 'essay', 'poetry', 'other' ]
    
    User.all(:limit => 6).each do |user|
      (rand(5)+1).times do
        genre = genres[rand(4)]
        piece = user.pieces.create!(:title => Faker::Lorem.sentence,
                      :genre => genre)
        # Create a random number of submissions for each piece
        rand(4).times do
          sub_date = Date.today() - rand(14).days
          if rand() < 0.3
            res_date = sub_date + rand(30).days
            res = rand < 0.1 ? "accept" : "decline"
          else
            res_date = nil
            res = nil
          end
          outlet = Outlet.find(rand(Outlet.count) + 1)
          piece.submissions.create!(:submit_date => sub_date,
                        :outlet_id => outlet.id,
                        :response_date => res_date,
                        :response => res,
                        :user_id => piece.user_id)
        end
      end
    end
  end
end