module Freelancer
  module API
    module Project
      module InstanceMethods

        # Search for projects using a specified set of criterias.
        #
        # Valid parameters are:
        #   - featured: if only featured projects should be returned
        #   - non_public: if only non-public projects should be returned
        #   - keyword: the keyword to use for searching
        #   - job: a specific job type, or an array of job types, to search for
        #   - status: the project status to filter projects by
        #   - minimum_budget: the minimum budget to return projects by
        #   - maximum_budget: the maximum budget to return projects by
        #   - full_time: if only full time projects should be returned
        #   - trial: if only trial projects should be returned
        #   - gold_members_only: if only gold member only-projects should be returned
        #   - duration: the bid end duration for the project (submitdate (default), bid_enddate, id or state)
        #   - count: the number of results to return (defaults to 50)
        #   - page: the page to retrieve (defaults to 0)
        def project_search(*args)

          params = extract_params(args)

          # Handle the job attribute, make sure it's an array and not set to nil to
          # simplify the handling below.
          params[:job] ||= []
          params[:job] = params[:job].to_a unless params[:job].is_a?(Array)

          # Delete some boolean data from the params if the values are set to fault,
          # since that's the default already
          [ :featured, :non_public, :full_time, :trial, :gold_members_only ].each do |k|
            params.delete(k) if params.key?(k) && params[k] == false
          end

          # Execute the service call
          result = api_get("/Project/searchProjects.json", build_api_params({
            :isfeatured => params[:featured],
            :isnonpublic => params[:non_public],
            :searchkeyword => params[:keyword],
            :searchjobtypecsv => params[:job].join(","),
            :status => params[:status],
            :budgetmin => params[:minimum_budget],
            :budgetmax => params[:maximum_budget],
            :isfulltime => params[:full_time],
            :istrial => params[:trial],
            :isgoldmembersonly => params[:gold_members_only],
            :bidendsduration => params[:duration],
            :count => params[:count],
            :page => params[:page]
          }))

          # Parse and return the response
          ::Freelancer::Models::Project.parse_collection(result, :shift => [ :"json-result", :items ])
          
        end

        # Retrieve the available project type fees
        def project_fees

          result = api_get("/Project/getProjectFees.json")
          ::Freelancer::Models::ProjectFee.parse_collection(result, :shift => [ :"json-result", :items ])

        end

        # Retrieve information about a project
        #
        # Valid parameters are:
        #   - project_id: the id of the project to retrieve
        def project_details(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Project/getProjectDetails.json", build_api_params({
            :projectid => params[:project_id]
          }))

          # Parse and return the response
          ::Freelancer::Models::Project.parse(result, :shift => :"json-result")
          
        end

        # Retrieve the bids for a project
        #
        # Valid parameters are:
        #   - project_id: the id of the project to retrieve bids for
        def project_bids(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Project/getBidsDetails.json", build_api_params({
            :projectid => params[:project_id]
          }))

          # Parse and return the response
          ::Freelancer::Models::Bid.parse_collection(result, :shift => [ :"json-result", :items ])
          
        end

        # Retrieve the public messages for a project
        #
        # Valid parameters are:
        #   - project_id: the id of the project to retrieve bids for
        def public_messages(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Project/getPublicMessages.json", build_api_params({
            :projectid => params[:project_id]
          }))

          # Parse and return the response
          ::Freelancer::Models::Message.parse_collection(result, :shift => [ :"json-result", :items ])

        end

        # Retrieve the project budget configurations
        def project_budgets

          result = api_get("/Project/getProjectBudgetConfig.json")
          ::Freelancer::Models::ProjectBudget.parse_collection(result, :shift => [ :"json-result", :items ])
          
        end

        # Post a public message for a project
        #
        # Valid parameters are:
        #   - project_id: the id of the project to post the message to
        #   - message: the message to post
        def post_public_project_message(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Project/postPublicMessage.json", build_api_params({
            :projectid => params[:project_id],
            :messagetext => params[:message]
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
