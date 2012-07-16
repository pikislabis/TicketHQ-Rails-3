file_settings = File.read("config/settings.yml") 
APP_CONFIG = YAML.load(file_settings)[Rails.env].symbolize_keys