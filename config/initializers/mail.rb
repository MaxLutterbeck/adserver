# Email settings
ActionMailer::Base.delivery_method = :smtp  # or :sendmail
ActionMailer::Base.smtp_settings = {
:address => "www.1und1.de",
:port => 25,
:domain => "1und1.de",
:authentication => :login,
:user_name => "m.lutterbeck@trade-a-game.de",
:password => "1234567"
}