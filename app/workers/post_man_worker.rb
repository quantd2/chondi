class PostManWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'post_man'

  def perform(contact)
    h = JSON.parse(contact)
    @contact = Contact.new(h)
    @contact.deliver
    # do something
  end
end
