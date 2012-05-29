module Freelancer
  module API
    module Message
      module InstanceMethods

        # Return the private messages sent to the current user
        #
        # Valid parameters are:
        #   - project_id: the project id to filter messages by
        #   - count: the number of results to return (defaults to 50)
        #   - page: the page to retrieve (defaults to 0)
        def messages(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Message/getInboxMessages.json", build_api_params({
            :projectid => params[:project_id],
            :count => params[:count],
            :page => params[:page]
          }))

          # Parse and return the response
          ::Freelancer::Models::Message.parse_collection(result, :shift => [ :"json-result", :items ])

        end

        # Retrieve the messages the current user has sent to other users
        #
        # Valid parameters are:
        #   - count: the number of results to return (defaults to 50)
        #   - page: the page to retrieve (defaults to 0)
        def sent_messages(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Message/getSentMessages.json", build_api_params({
            :count => params[:count],
            :page => params[:page]
          }))

          # Parse and return the response
          ::Freelancer::Models::Message.parse_collection(result, :shift => [ :"json-result", :items ])

        end

        # Retrieve the number of unread messages the current user has available
        def unread_message_count

          result = api_get("/Message/getUnreadCount.json")
          json = JSONMapper::Parser.parse(result)

          if !json.nil? && json.key?(:"json-result")
            return json[:"json-result"][:unreadcount].to_i
          end
          return nil

        end

        # Retrieve the full thread of private messages sent between two users
        # within a project.
        #
        # Valid parameters are:
        #   - project_id: the id of the project to load messages for
        #   - between_user_id: the id of the receiving user to load the thread for
        #   - count: the number of messages to retrieve (defaults to 50)
        #   - page: the page number to retrieve (defaults to 0)
        def message_thread(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Message/loadMessageThread.json", build_api_params({
            :projectid => params[:project_id],
            :betweenuserid => params[:between_user_id],
            :count => params[:count],
            :page => params[:page]
          }))

          # Parse and return the response
          ::Freelancer::Models::Message.parse_collection(result, :shift => [ :"json-result", :items, :message ])
          
        end

        # Send a private message to another user
        #
        # Valid parameters are:
        #   - project_id: the id of the project to send message for
        #   - text: the text of the message to send
        #   - user_id: the id of the user to send the message to
        #   - username: the username of the user to send the message to
        def send_message(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Message/sendMessage.json", build_api_params({
            :projectid => params[:project_id],
            :messagetext => params[:text],
            :userid => params[:user_id],
            :username => params[:username]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Mark a message as read
        #
        # Valid parameters are:
        #   - message_id: the id of the message to mark as read
        def mark_message_as_read(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Message/markMessageAsRead.json", build_api_params({
            :id => params[:message_id]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")

        end

      end
      module ClassMethods

      end
    end
  end
end
