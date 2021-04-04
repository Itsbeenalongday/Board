# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "board"
set :repo_url, "git@github.com:Itsbeenalongday/Board.git"

# 배포 git branch
set :branch, :master

# 배포 환경 변수
set :user_sudo, false
set :deploy_via, :remote_cache

set :pty, true

## Github에 Push되면 안되는 중요한 파일에 있어선 해당 리스트에 추가하는게 좋음.
# 해당 리스트에 추가된 파일은 하단에 보이는 namespace :linked_files 부분에도 추가해줘야 합니다.
set :linked_files, %w{config/application.yml config/database.yml config/master.key}

## 프로젝트 배포 후 유지에 있어 공통으로 쓰이는 폴더들
# Capistrano에 배포된 프로젝트는 현재 상용서비스로 사용되는 프로젝트와 과거에 배포되었던 프로젝트 총 :keep_releases개 로 나뉘어 관리가 이루어진다.
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads public/img}

# Capistrano를 통해 배포된 현재/과거에 배포됐던 프로젝트 최대 수용갯수 (Default : 5)
set :keep_releases, 5

## [Rails Version 6.0 ~] linked_files 파일을 EC2 서버로 Upload
namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/application.yml ]")
          upload! 'config/application.yml', "#{shared_path}/config/application.yml"
        end
        
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! 'config/master.key', "#{shared_path}/config/master.key"
        end
        
        unless test("[ -f #{shared_path}/config/database.yml ]")
          upload! 'config/database.yml', "#{shared_path}/config/database.yml"
        end
        
      end
    end
  end
end

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
