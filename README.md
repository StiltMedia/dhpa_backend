## Mandatory Regular Maintenance

* To make security updates quicker:
  * Please change DHPA.com's GoDaddy DNS to:
    * A
      * <pre>@    50.63.202.1</pre>
    * CNAME
      * <pre>www    658-915-814.cloud66.net</pre>
  * Immediately set up domain forwarding:
    * See https://www.godaddy.com/help/manually-forwarding-or-masking-your-domain-name-422
    * Select `http://` as your Forward to option.
    * Enter the URL: `http://www.dhpa.com`
    * Select Redirect type of `301 (Permanent)`
    * Select `Forward only`

1. You must perform monthly security updates of your cloud66 AWS servers in order to avoid being hacked:
   * http://help.cloud66.com/managing-your-stack/applying-upgrades
   * Estimate: (1.5hr/mo)
2. The webserver and database server are both managed via cloud66 and hosted on AWS EC2.
   I have enabled daily automatic backups via cloud66, but you will need to manually verify
   that the backups are working and useable on a regular basis (every 3 months, for example.)
   * (2hr/3mo)
3. Your photos are being saved on Amazon S3; the "production" bucket is the important one.
   I've enabled versioning on it to avoid a disaster if things are accidentally deleted,
   but the entire bucket should be manually backed up every 3 months as well.
   * (1hr/3mo)
4. It's a very good idea to copy the S3 (photo) and Cloud66 (Postgres Database) backups to your home
   computer every month, so that if Cloud66 or Amazon have trouble you still have a recent copy of your site.
   * (1hr/mo)
5. Basic website uptime monitoring is recommended (to get alerts if the site goes completely offline)
   * ($10/mo)

## Todo & Scope

See TODO.rdoc

## Dependencies

* Ruby 2.2.4 (see .versions.conf and rvm)
* Gems from gemfile (see bundler)
* Perl (for mini_exiftool_vendored)
* Ubuntu Packages:
  * sudo apt-get install libgmp3-dev postgresql-contrib imagemagick

## Environment Variables

Copy env.dist to .env and edit as desired, for development/testing.
Input into cloud66's Environment Variables GUI for staging/production.
Stored in Will Bradley's LastPass under "DHPA Cloud66" for easy copy-pasting.

* Production/staging only
  * `SECRET_KEY_BASE`
    * Long random string for encryption purposes
  * `SMTP_HOSTNAME=www.dhpa.com`
    * Needed to install an smtp server locally (see .cloud66/smtpinstall.sh)
* All Environments
  * `RAILS_SERVE_STATIC_FILES`
    * 0 for dev/test, 1 for staging/prod
  * `AWS_ACCESS_KEY`
    * Access Key of an AWS user with S3 Full Access
  * `AWS_SECRET_ACCESS_KEY`
    * Secret Key of an AWS user with S3 Full Access
  * `AWS_REFILE_BUCKET`
    * S3 bucket name for image uploads (i.e. `dhpa-photos-development` for dev, `dhpa-photos-staging` for staging, `dhpa-photos-production` for production)
  * `STRIPE_PUBLISHABLE_KEY`
    * Public Stripe key (either test keys for test/dev/staging, or live keys for production)
  * `STRIPE_SECRET_KEY`
    * Secret Stripe key (either test keys for test/dev/staging, or live keys for production)

## Configuration

* Ensure there are recent and usable S3 and Postgres backups/snapshots/recovery before running any of these commands on production!
* Use postgres for all environments. Create the database names according to database.yml
* Use AWS S3 for image uploads
  * Create an IAM user and credentials, with normal "S3 Full Access" permissions.
  * In the us-east-1 region (Virginia), create test, dev, staging, and production buckets according to the AWS_REFILE_BUCKET environment variable. Do not use production buckets outside of the production webserver.

### In Test/Dev

* To clear the database and run the create/migrate/seed commands, run `rake db:setup`, OR each of the below steps manually:
  * `rake db:create && rake db:migrate` for database initialization.
  * See db/seeds.rb for default usernames and `rake db:seed` to insert these defaults into the db.

### In Staging/Production

* Use cloud66 for staging/production deployment (in the us-east-1 region; use t2.medium for production server size and t2.small for staging.)
  * The scripts in the .cloud66 folder should take care of most stuff.
* Manually ensure that large file uploads are enabled:
  1. Go to your cloud66 stack, click the web server group page (eg. Rails servers) and click CONFIGURE NGINX at the top right.
  1. Edit the Nginx configuration to: `client_max_body_size    300m;` *IN BOTH THE HTTP AND SERVER SECTIONS OF THE CONFIG FILE.*
* *TODO:* CDN for faster image serving

## Testing

No tests created yet. Please create tests, tests are good.

## Documentation

Run `rake doc:app` to generate HTML documentation from classes.

## Running

Run `rails s` for development. Cloud66 scripts are already present for staging/production.

## Contributors

- Gustavo Pares, http://staycreativedesign.com
- Will Bradley via Stilt Media, info@stiltmedia.com
