require "refile/s3"
require "refile/watermark"

Refile.secret_key = Rails.application.secrets.secret_key_base

if Rails.env.production?

  aws = {
    access_key_id: ENV["AWS_ACCESS_KEY"],
    secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    region: "sa-east-1",
    bucket: "my-bucket",
  }
  Refile.cache = Refile::S3.new(prefix: "cache", **aws)
  Refile.store = Refile::S3.new(prefix: "store", **aws)

end