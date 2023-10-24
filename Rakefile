def notify(msg)
  puts "✅  #{msg}"
end

task default: %w(build)

task :clean do
  system('rm -rf dist/')
  notify 'Clean'
end

task :copy do
  system('mkdir dist')
  # copy without dotfiles - https://stackoverflow.com/a/11557219/254187
  system('rsync -ar --exclude=".*" src/content/static/ dist')
  notify 'Copy'
end

task :compile do
  system('mkdir -p dist')
  system('ruby src/convert.rb dist/index.html')
  notify 'Compile'
end

task build: %w(clean copy compile)
