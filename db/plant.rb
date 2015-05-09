# TO DO LIST 
# ----------
# 0. implement vendor class (mock artist)
# 1. implement vendor#show to list products
# 2. implement product (static list, but i want pages for each)
# 3. real-time inventory of product from db
# 4. home page is product#show with artist links
# 5. artist/:id will give you a list of their products and amounts
# 6. you'll be able to buy from the vendor#show page

# add a string function
# to check if it's a valid integer
class String
  def is_integer?
    self.to_i.to_s == self
  end
end
def generate_password
  # this is nuts
  password_length = rand(12..30)
  return (0...password_length).map { ('a'..'z').to_a[rand(26)] }.join
end
# initial arrays for data building
first_names = [ "Evan", "Derek", "Claudia", "Samuel", "Mark", "Daria", "Jackson", "David", "Michael", "George", "Tobias", "Frank", "Caitlyn", "Samantha", "Andrea", "Lisa", "Larry", "Lemony", "Seth", "Kevin", "Kyle", "Cleveland", "Indiana", "Chicago", "Tortimer", "Hank", "Zil", "Pharrell", "Simon", "Hugh", "John", "Karen", "Clark", "Andre", "Paul", "Tom", "Tammy", "Dee", "Mac", "Charlie", "Charles", "Ryan", "Jessica", "Britney", "Jenna", "Kayden", "Devon" ]
last_names = [ "Gibson", "Smith", "Samsonite", "Calrissian", "Skywalker", "Zappa", "Reynolds", "Anderson", "Birdman", "Carlsen", "Dvorak", "Eagleton", "Torvin", "Fehrman", "Herman", "Griffon", "Jackson", "Wilson", "Simmons", "Jones", "Umbright", "Callen", "Cullen", "Davidson", "Falken", "Filmore", "Gill", "Hammerstein", "Hjord", "Mackelson", "Molbot", "Steemer", "Stark", "Jenkins", "Richardson", "Seymour", "Hoffman", "Nakamura" ]
artist_names = [ "Garbage Collective", "Animal Garden", "Glue Theory", "September Octs", "Cool Cat", "Wizard Team", "Shark Attack", "Lightning Drive", "Ideas", "Sunset Bay", "Michael Overdrive", "Zippy", "Fortitude Spring", "Zork", "Zindar", "Quagger", "Jubilant Jefferey", "Deep Diver", "Typer", "Paraguay The Woman", "Winter Festivities", "Vibraphone Jambot", "Surfer Regulations", "Impact List", "Funk The Police", "Band", "Untitled Band Project 1", "The Band Formerly Known as Untitled Band Project 1", "Dead Smell", "Wretchface", "Graveburial", "Spurrowham", "Wish Journal", "Gigglefit", "UPTEMPO", "downtempo", "Groovy Tambourine", "Twelve Hampsters", "Hamper Damper", "Wishy Washy", "Laughtrack", "Hellacious A", "Sample Population", "Addition", "Dogma", "Tron Reject", "SJE", "FJI", "LIE", "TRUTH", "Sable", "Plumber Siblings", "Vaccuum Cleaner", "Mega Passive Machine", "Hammer Time", "Festival Attack", "Cellar Door", "Witch Hunt", "Hunt Witch", "Psycho Babble", "Simspeak", "Twelve Kardashians", "Veep Impact", "Raking Rad", "Bleak", "Fuse and Coil", "Jomeranian" ]
song_names = [ "Janet", "Tambourine Massacre", "Carnival Garden", "You and I", "I and You", "You and You", "Freyeday", "I and I", "Pirate Times", "Tremble Tuesday", "Highschool Rock", "Cannibal Factory", "Nine Birds", "Why I Assaulted My Grandma", "Tendon", "Yorkshire Puddin", "Fort", "Eggs and Bacon", "Utopia Ensured", "Yum Yum Brigade", "Untitled Song 1", "Flight 22", "Spider Party", "Bridge Hell", "Retort Machine", "Yoga Time", "Eighteen Eighty Eight", "Eleven over Seven", "See You In Bagel Town", "Bageltown Population Me", "Free Trial", "Shlick", "Blade Contour", "Extremenation", "SIMPLE", "Activity", "Balance the Others", "Join Forces", "INspire ME", "Generation Hop", "Rizzo Tizzo", "Bagel Part II", "Rhombus Square", "Uruguay" ]
genres = [ "Rock", "Adult Contemporary", "Hip Hop", "Alternative", "Progressive", "Techno", "Indie", "Pop", "Metal", "Electronic", "Dance", "Dubstep", "Shoegaze", "Folk", "Christian Rock", "Breakcore", "IDM", "Instrumental", "Country", "R&B" ]
# these are for seeds.rb
users = []
artists = []
songs = []
# setting our number of users
number_of_users = rand(15..60)
# setting our number of artists
number_of_artists = rand(20..60)

# create artists
for i in 0..number_of_artists do
  if rand(1..100) < 20 
    artists[i] = first_names.sample + ' ' + last_names.sample
  elsif rand(1..100) < 16
    artists[i] = last_names.sample
  else
    artists[i] = artist_names.sample
  end
end
# create users
for i in 0..number_of_users do
  users[i] = [first_names.sample + ' ' + last_names.sample, artists.sample]
end
# song array index
j = 0
artists.each do |artist|
  # we have a random number of songs
  number_of_songs = rand(5..25)
  for i in 0..number_of_songs do
    # we have a random number of plays 
    # for each song
    number_of_plays = rand(1..100)>80 ? rand(0..12348) : rand(100..2000)
    # fill up our songs array
    if rand(1..100) < 70 
      songs[j] = [artist,song_names.sample,number_of_plays]
    elsif rand(1..100) < 50
      songs[j] = [artist,last_names.sample,number_of_plays]
    elsif rand(1..100) < 40
      songs[j] = [artist,first_names.sample+" "+last_names.sample,number_of_plays]
    else
      songs[j] = [artist,first_names.sample,number_of_plays]
    end
    # increment j
    j += 1
  end
end

# let's remove the duplicates!
users = users.uniq
artists = artists.uniq
songs = songs.uniq
# make the songs in "most played" order
songs.sort_by! do |k|
  -k[2]
end


# doing this after the users.map because user#map! 
# needs the pre-modified artists array
artists.map! do |artist|
  if artist.gsub(' ','_')!= nil
    artist = artist.gsub(" ","_").downcase + " = Artist.create({name:'" + artist + "',genre:'"+genres.sample+"'})"
  else
    artist = artist.downcase + " = Artist.create({name:'" + artist + "',genre:'"+genres.sample+"'})"
  end
end
# using MAP instead of EACH (each never modifies the array it's working on)
users.map! do |user|
  if user[1].gsub(' ','_')!= nil
    artist_id_string = user[1].gsub(' ','_').downcase
  else
    artist_id_string = user[1].downcase
  end
  password = generate_password
  if user[0].gsub(' ','_')!= nil
    user = user[0].gsub(" ","_").downcase + " = User.create({username:'" + user[0] + "',email:'" + user[0].gsub(" ","_").downcase + "@weird.net',password:'"+password+"',password_confirmation:'"+password+"',artist_id:"+artist_id_string+".id})"
  else
    user = user[0].downcase + " = User.create({username:'" + user[0] + "',email:'" + user[0].downcase + "@weird.net',password:'"+password+"',password_confirmation:'"+password+"',artist_id:"+artist_id_string+".id})"
  end
end
songs.map! do |song|
  if song[0].gsub(' ','_')!= nil
    artist_id_string = song[0].gsub(' ','_').downcase
  else
    artist_id_string = song[0].downcase
  end
  song_plays = song[2].to_s
  if song[1].gsub(' ','_')!= nil
    song = song[1].gsub(' ','_').downcase + " = Song.create({title:'" + song[1] + "',play_count:"+song_plays+",artist_id:" + artist_id_string + ".id})"
  else
    song = song[1].downcase + " = Song.create({title:'" + song[1] + "',play_count:"+song_plays+",artist_id:" + artist_id_string + ".id})"
  end
end

puts 'data instantiated - saving to seeds.rb'

largeOutput = [ artists, users, songs ]

# clear out seeds.rb file
output = File.open('./seeds.rb','w') 
  output << ""
output.close
puts "file created"

largeOutput.each do |output|
  output.each do |input|
    # open up the seeds file
    File.open('./seeds.rb','a') { |f| f.write(input+ "\n") }
  end
end
puts 'file written'