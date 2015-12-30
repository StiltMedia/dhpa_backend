# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Force tmp directory
ENV['TMPDIR'] = Rails.root.join('tmp').to_s