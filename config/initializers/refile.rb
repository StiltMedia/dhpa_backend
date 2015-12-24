require "refile/s3"
require "refile/watermark"

Refile.secret_key = Rails.application.secrets.secret_key_base

if Rails.env.production? || Rails.env.staging?

  aws = {
    access_key_id: ENV["AWS_ACCESS_KEY"],
    secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    region: "us-west-1",
    bucket: "dhpa-uploads",
  }
  Refile.cache = Refile::S3.new(prefix: "cache", **aws)
  Refile.store = Refile::S3.new(prefix: "store", **aws)

end