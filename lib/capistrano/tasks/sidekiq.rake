
namespace :sidekiq do
  NUM_WORKERS = 4
  task :quiet do
    on roles(:app) do
      NUM_WORKERS.times.each do |i|
        execute :sudo, :service, :sidekiq, :reload, "index=#{i}"
      end
    end
  end
  task :restart do
    on roles(:app) do
      NUM_WORKERS.times.each do |i|
        execute :sudo, :service, :sidekiq, :restart, "index=#{i}"
      end
    end
  end
end

after 'deploy:starting', 'sidekiq:quiet'
after 'deploy:reverted', 'sidekiq:restart'
after 'deploy:published', 'sidekiq:restart'
