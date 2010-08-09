module Freelancer
  module API
    module Common
      module InstanceMethods

        # Get a list of projects that are pending feedback
        #
        # Valid parameters are:
        #   - type: the type of projects to list ("P" or "B" (default))
        def pending_feedback(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Common/getPendingFeedback.json", build_api_params({
            :type => params[:type]
          }))

          # Parse and return the response
          ::Freelancer::Models::Project.parse_collection(result, :shift => [ :"json-result", :items ])
          
        end

        # Get the configuration version of a specific service function
        #
        # Valid parameters are:
        #   - function: the function to look up config version for
        def config_version(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Common/getConfigVersion.json", build_api_params({
            :function => params[:function]
          }))

          # Parse and return the response
          ::Freelancer::Models::ConfigVersion.parse(result, :shift => :"json-result")
          
        end

        # Returns the current Terms and Conditions from the site
        def terms

          result = api_get("/Common/getTerms.json")
          json = JSONMapper::Parser.parse(result)

          if !json.nil? && json.key?(:"json-result")
            return json[:"json-result"][:terms]
          end
          return nil
          
        end

        # Request to cancel an awarded project
        #
        # Valid parameters are:
        #   - project_id: the id of the project to cancel
        #   - selected_winner: the id of the selected winner of the project
        #   - comment: the comment for the cancellation request
        #   - reason: the reason for cancelling the project
        #   - followed_guidelines: if the guidelines for cancelling the project has been followed
        def request_cancel_project(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Common/requestCancelProject.json", build_api_params({
            :projectid => params[:project_id],
            :selectedwinner => params[:selected_winner],
            :commenttext => params[:comment],
            :reasoncancellation => params[:reason],
            :followedguidelinesstatus => params[:followed_guidelines]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Post feedback for a user
        #
        # Valid parameters are:
        #   - project_id: the project id related to the feedback
        #   - user_id: the id of the user to rate
        #   - username: the username of the user to rate
        #   - comment: the feedback comment
        #   - rating: the feedback rating
        def post_feedback(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Common/postFeedback.json", build_api_params({
            :projectid => params[:project_id],
            :userid => params[:user_id],
            :username => params[:username],
            :feedbacktext => params[:comment],
            :rating => params[:rating]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Post reply to a feedback given to you
        #
        # Valid parameters are:
        #   - project_id: the id of the project related to the feedback
        #   - user_id: the id of the user to reply to
        #   - username: the username of the user to reply to
        #   - comment: the feedback comment
        def post_feedback_reply(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Common/postReplyForFeedback.json", build_api_params({
            :projectid => params[:project_id],
            :userid => params[:user_id],
            :username => params[:username],
            :feedbacktext => params[:comment]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Request that posted feedback is withdrawn
        #
        # Valid parameters are:
        #   - project_id: the id of the project related to feedback
        #   - user_id: the user id the feedback is posted to
        #   - username: the username the feedback is posted to
        def request_withdraw_feedback(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Common/requestWithdrawFeedback.json", build_api_params({
            :projectid => params[:project_id],
            :userid => params[:user_id],
            :username => params[:username]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

      end
    end
  end
end
