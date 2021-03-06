module EmailHelper
  def email_image_tag(image, **options)
    attachments[image] = File.read(Rails.root.join("public/img/#{image}"))
    image_tag attachments[image].url, **options
  end
end