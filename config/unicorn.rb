APP_PATH = "/root/waynezone"
working_directory APP_PATH
stderr_path APP_PATH + "/log/unicorn.stderr.log"
stdout_path APP_PATH + "/log/unicorn.stdout.log"

pid APP_PATH + "/tmp/pids/unicorn.pid"
listen "/tmp/unicorn.waynezone.sock"
worker_processes 2
timeout 180
