task default: %w(build)

task :clean do
  `rm -rf dist/`
end

task :copy do
  `mkdir dist`
  # copy without dotfiles - https://stackoverflow.com/a/11557219/254187
  `rsync -av --exclude=".*" src/content/static/** dist`
end

task :compile do
  `ruby src/convert.rb dist/index.html`
end

task build: %w(clean copy compile)
