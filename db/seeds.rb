require 'open-uri'
require 'json'

puts 'Cleaning up database...'
Movie.destroy_all
puts 'Database cleaned'

api_key = ENV['TMDB_API_KEY']
url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{api_key}"

100.times do |i|
  puts "Importing movies from page #{i + 1}"
  movies = JSON.parse(URI.open("#{url}&page=#{i + 1}").read)['results']
  movies.each do |movie|
    base_poster_url = 'https://image.tmdb.org/t/p/original'
    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "#{base_poster_url}#{movie['poster_path']}",
      rating: movie['vote_average'],
      backdrop_url: "#{base_poster_url}#{movie['backdrop_path']}"
    )
  end
end

puts 'Movies created'
