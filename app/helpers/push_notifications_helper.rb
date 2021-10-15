module PushNotificationsHelper
  include HTTParty
  include Rails.application.routes.url_helpers

  HEADERS = { "Authorization" => "Basic #{ENV['ONESIGNAL_REST_APY_KEY']}", "Content-Type" => "application/json" }

  # Create new file to storage log of pushes.
  @push_logger = ::Logger.new(Rails.root.join('log', 'push.log'))

  # Every request needs to inform the APP ID.
  @body =  {
    "app_id" => ENV['ONESIGNAL_APP_ID']
  }

  def self.send_push(body)
    HTTParty.post "https://onesignal.com/api/v1/notifications", headers: HEADERS, body: body, logger: @push_logger, log_level: :debug, log_format: :curl
  end

  # Send push to all stores.
  def self.new_request_created(replacement_request, url)
    push_body = @body.merge(
      { 
        "included_segments" => ["locales_comerciales"],
        "url" => url,
        "data" => { "type": "new_request_created" },
        "contents" => { "en" => "New request created! Add a proposal.", "es" =>  "¡Nueva solicitud ingresada! Agregue una propuesta." },
      }).to_json

    send_push(push_body)
  end

  # Send push to specific user.
  def self.new_proposal_created(replacement_proposal, url)
    push_body = @body.merge(
      { 
        "url" => url,
        "include_player_ids" => [replacement_proposal.replacement_request.user.onesignal_id],
        "data" => { "type": "new_proposal_created", "id": replacement_proposal.id },
        "contents" => { "en" => "You have receibed a new proposal for #{replacement_proposal.replacement_request.short_name}.", "es" => "Ha recibido una nueva propuesta para #{replacement_proposal.replacement_request.short_name}." }
      }).to_json

    send_push(push_body)
  end

  # Send push to specific user.
  def self.proposal_accepted(replacement_proposal, url)
    push_body = @body.merge(
      { 
        "url" => url,
        "include_player_ids" => [replacement_proposal.shop.user.onesignal_id],
        "data" => { "type": "proposal_accepted", "id": replacement_proposal.id },
        "contents" => { "en" => "Your proposal for #{replacement_proposal.replacement_request.short_name} has been accepted.", "es" => "Su propuesta para #{replacement_proposal.replacement_request.short_name} fue aceptada." }
      }).to_json

    send_push(push_body)
  end
end

#Now, to call any method, just use the lines below at any point in the Ruby on Rails project:

#PushNotificationsHelper::new_proposal_created(replacement_proposal)
#PushNotificationsHelper::proposal_accepted(replacement_proposal)

#PushNotificationsHelper::new_request_created(replacement_request)