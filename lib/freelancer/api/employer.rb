module Freelancer
  module API
    module Employer
      module InstanceMethods

        # Retrieve a list of projects posted by a user. By default, this
        # retrieves the projects posted by the currently authenticated user.
        #
        # Valid parameters are:
        #   - status: the status value to filter projects by (defaults to 2 (open and frozen))
        #   - user_id: the id of the user to list projects for (defaults to current user)
        #   - project_id: the project id to filter projects by
        #   - type: the project type to use ('active', 'trial' and 'draft' - defaults to 'active')
        #   - count: the number of results to return (defaults to 50)
        #   - page: the page to retrieve (defaults to 0)
        def posted_projects(*args)

          params = extract_params(args)

          # Use a blank type value if type is set to 'active'
          params[:type] = nil if params[:type] == "active"

          # Execute the service call
          result = api_get("/Employer/getPostedProjectList.json", build_api_params({
            :status => params[:status],
            :userid => params[:user_id],
            :projectid => params[:project_id],
            :projectoption => params[:type],
            :count => params[:count],
            :page => params[:page]
          }))

          # Parse and return the response
          ::Freelancer::Models::Project.parse_collection(result, :shift => [ :"json-result", :items ])
          
        end

        # Check if the current user is eligible to post trial projects
        def eligible_for_trial_project
          
          result = api_get("/Employer/eligibleForTrialProject.json")
          ::Freelancer::Models::Eligibility.parse(result, :shift => :"json-result")

        end

        # Returns true if the current user is eligible to post trial projects,
        # false otherwise
        def eligible_for_trial_project?
          eligibility = eligible_for_trial_project
          !eligibility.nil? && eligibility.eligible?
        end

        # Post a new project
        def new_project(project)

          params = new_project_params(project)

          # Execute the service call
          result = api_get("/Employer/postNewProject.json", params)

          # Parse and return the response
          ::Freelancer::Models::Project.parse(result, :shift => :"json-result")

        end

        # Post a new project draft
        def new_project_draft(project)

          params = new_project_params(project)

          # Execute the service call
          result = api_get("/Employer/postNewDraftProject.json", params)

          # Parse and return the response
          ::Freelancer::Models::Project.parse(result, :shift => :"json-result")

        end

        # Post a new trial project
        def new_trial_project(project)

          params = new_project_params(project)

          # Execute the service call
          result = api_get("/Employer/postNewTrialProject.json", params)

          # Parse and return the response
          ::Freelancer::Models::Project.parse(result, :shift => :"json-result")

        end

        # Update a project
        def update_project(project)

          params = {}
          params[:projectid] = project.id
          params[:projectdesc] = project.short_description
          params[:jobtypecsv] = project.jobs.join(",")

          # Execute the service call
          result = api_get("/Employer/updateProjectDetails.json", params)

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")

        end

        # Upgrade a trial project to a normal project
        #
        # Valid parameters are:
        #   - project_id: the id of the project to ugprade
        def upgrade_trial_project(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Employer/upgradeTrialProject.json", build_api_params({
            :projectid => params[:project_id]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")

        end

        # Delete a draft project
        #
        # Valid parameters are:
        #   - project_id: the id of the project to delete
        def delete_draft_project(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Employer/deleteDraftProject.json", build_api_params({
            :projectid => params[:project_id]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Choose one or more winners for a project
        #
        # Valid parameters are:
        #   - project_id: the id of the project to choose a winner for
        #   - user_id: a single user id, or an array of user ids, to be made winners of the project
        def choose_winner_for_project(*args)

          params = extract_params(args)

          # Handle the user id attribute, make sure it's an array and not set to nil to
          # simplify the handling below.
          params[:user_id] ||= []
          params[:user_id] = [ params[:user_id] ] unless params[:user_id].is_a?(Array)

          # Execute the service call
          result = api_get("/Employer/chooseWinnerForProject.json", build_api_params({
            :projectid => params[:project_id],
            :useridcsv => params[:user_id].join(",")
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Invite one or more users to bid on a project
        #
        # Valid parameters are:
        #   - project_id: the id of the project to invite users to
        #   - user_id: a single user id, or an array of user ids, to invite to the project
        #   - username: a single username, or an array of usernames, to invite to the project
        def invite_user_to_project(*args)

          params = extract_params(args)

          # Handle the username and user id attributes, make sure they're an array and not
          # set to nil to simplify the handling below.
          params[:user_id] ||= []
          params[:user_id] = [ params[:user_id] ] unless params[:user_id].is_a?(Array)
          params[:username] ||= []
          params[:username] = [ params[:username] ] unless params[:username].is_a?(Array)

          # Execute the service call
          result = api_get("/Employer/inviteUserForProject.json", build_api_params({
            :projectid => params[:project_id],
            :useridcsv => params[:user_id].join(","),
            :usernamecsv => params[:username].join(",")
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")

        end

        private

        def new_project_params(project)

          params = {}

          params[:projectname] = project.name
          params[:projectdesc] = project.short_description
          params[:jobtypecsv] = project.jobs.join(",")
          params[:budgetoption] = project.budget_option
          if project.budget_option == 0
            params[:budget] = "#{project.minimum_budget}-#{project.maximum_budget}"
          end
          params[:duration] = project.duration

          params[:isfeatured] = 1 if project.options.featured?
          params[:isnonpublic] = 1 if project.options.non_public?
          params[:isbidhidden] = 1 if project.options.hidden_bids?
          params[:isfulltime] = 1 if project.options.full_time?

          params

        end

      end
    end
  end
end
