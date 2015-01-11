server 'protorails-staging', user: 'deploy', roles: %w{web app db job}
set :rails_env, 'staging'
set :release_note_url, 'http://staging.prototypeB.com/release_note.txt'