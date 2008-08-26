class FlashAdMailer < ActionMailer::Base
  
  def new_flash_ad(flash_ad)
    setup_flash_ad_mail(flash_ad)
    @subject += ": #{flash_ad.title}"
    @body[:url] = "http://192.168.2.105:3000/flash_ads/#{flash_ad.id}"
  end
  
  protected
  
  def setup_flash_ad_mail(flash_ad)
    @user = User.find(:all)
    @subject = "Neue Flash Ad: "
    @string = ''
    @user.each do |user| 
      @string << user.email + ', '
    end
    @count = (@string.size - 3)
    @bcc = @string[0..@count]
    puts @bcc
    @from = "adserver@trade-a-game.de"
    @recipients = "m.lutterbeck@trade-a-game.de"
    @sent_on = Time.now
  end
  
end