server 'protorails-production', user: 'deploy', roles: %w{web app db job}
set :rails_env, 'production'
set :release_note_url, 'http://prototypeB.com/release_note.txt'