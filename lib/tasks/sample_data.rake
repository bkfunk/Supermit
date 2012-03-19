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
  end
end