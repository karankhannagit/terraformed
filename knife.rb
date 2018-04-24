current_dir = File.dirname(__FILE__)
log_level         :info
log_location      STDOUT
node_name         "admin"
client_key        "#{current_dir}/admin.pem"
chef_server_url   "https://ip-172-16-1-110.us-east-2.compute.internal/organizations/4thcoffee"
cookbook_path     ["~/"]
