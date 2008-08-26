class ImageAdMailer < ActionMailer::Base
  
  def new_image_ad(image_ad)
    setup_image_ad_mail(image_ad)
    @subject += ": #{image_ad.title}"
    @body[:url] = "http://192.168.2.105:3000/image_ads/#{image_ad.id}"
  end
  
  protected
  
  def setup_image_ad_mail(image_ad)
    @user = User.find(:all)
    @subject = "Neue Image Ad: "
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