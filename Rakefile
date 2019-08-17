def notify(msg)
  puts "✅  #{msg}"
end

def upload(dry_run)
  system("rsync -arv --exclude=\".*\" #{dry_run ? '--dry-run' : ''} dist/* $MPLEWIS_COM_SERVER")
  notify "Upload #{dry_run ? '(dry run)' : ''}"
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

namespace :upload do
  task dry: %w(build) do
    upload(true)
  end

  task real: %w(build) do
    upload(false)
  end
end

task build: %w(clean copy compile)
