task default: ["game"]

task :game do
  ruby "game.rb"
end

task :glider do
  ENV['MODE'] = 'glider'
  ruby "game_tricky.rb"
end

task :spaceship do
  ENV['MODE'] = 'spaceship'
  ruby "game_tricky.rb"
end
