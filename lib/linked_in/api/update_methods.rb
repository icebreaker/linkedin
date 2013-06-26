module LinkedIn
  module Api

    module UpdateMethods

      def add_share(share)
        path = "/people/~/shares"
        defaults = {:visibility => {:code => "anyone"}}
        post(path, defaults.merge(share).to_json, "Content-Type" => "application/json")
      end

      def add_post_to_group(group_id, post)
        path = "/groups/#{group_id}/posts"
        defaults = {}
        response = post(path, defaults.merge(post).to_json, "Content-Type" => "application/json")

        last_post = get("/groups/#{group_id}/posts?count=1&order=recency")
        if last_post
          data = JSON.parse(last_post)
          if data["values"].is_a? Array and data["values"].size > 0 and data["values"][0].is_a? Hash
            id =["values"][0]["id"]
            response.instance_variable_set(:@id, id) if id
          end
        end

        response
      end

      # def share(options={})
      #   path = "/people/~/shares"
      #   defaults = { :visability => 'anyone' }
      #   post(path, share_to_xml(defaults.merge(options)))
      # end
      #
      # def update_comment(network_key, comment)
      #   path = "/people/~/network/updates/key=#{network_key}/update-comments"
      #   post(path, comment_to_xml(comment))
      # end
      #
      # def update_network(message)
      #   path = "/people/~/person-activities"
      #   post(path, network_update_to_xml(message))
      # end
      #
      # def send_message(subject, body, recipient_paths)
      #   path = "/people/~/mailbox"
      #
      #   message         = LinkedIn::Message.new
      #   message.subject = subject
      #   message.body    = body
      #   recipients      = LinkedIn::Recipients.new
      #
      #   recipients.recipients = recipient_paths.map do |profile_path|
      #     recipient             = LinkedIn::Recipient.new
      #     recipient.person      = LinkedIn::Person.new
      #     recipient.person.path = "/people/#{profile_path}"
      #     recipient
      #   end
      #   message.recipients = recipients
      #   post(path, message_to_xml(message)).code
      # end
      #
      # def clear_status
      #   path = "/people/~/current-status"
      #   delete(path).code
      # end
      #

    end

  end
end
