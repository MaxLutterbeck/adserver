set :application, "adserver"
set :repository,  "git@github.com:MaxLutterbeck/adserver.git"
set :domain, "max@89.110.147.59"

default_run_options[:pty] = true
set :scm, :git
set :git_enable_submodules, 1
set :deploy_to, "#{application}" 
set :deploy_via, :copy
set :copy_cache, true
set :copy_exclude, ['.git']
ssh_options[:paranoid] = false
set :user, "max"
set :runner, "max"
set :use_sudo, false

role :app, domain
role :web, domain
role :db,  domain, :primary => true


deploy.task :restart do
  run "#{application}/current/script/process/reaper"
end



  

