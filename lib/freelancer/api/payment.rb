module Freelancer
  module API
    module Payment
      module InstanceMethods

        # Retrieve the current users balance and the details of the last
        # transaction.
        def account_balance

          result = api_get("/Payment/getAccountBalanceStatus.json")
          ::Freelancer::Models::Balance.parse(result, :shift => :"json-result")
          
        end

        # Retrieve a list of transactions for the current user
        #
        # Valid parameters are:
        #   - from: the from date/time to search by
        #   - to: the to date/time to search by
        #   - count: the number of results to return (defaults to 50)
        #   - page: the page to retrieve (defaults to 0)
        def transactions(*args)

          params = extract_params(args)

          # If we have a from or to date, convert it to a string
          if params.key?(:from) && params[:from].is_a?(Date)
            params[:from] = params[:from].strftime("%Y-%m-%d %H:%M:%S")
          end
          if params.key?(:to) && params[:to].is_a?(Date)
            params[:to] = params[:to].strftime("%Y-%m-%d %H:%M:%S")
          end

          # Execute the service call
          result = api_get("/Payment/getAccountTransactionList.json", build_api_params({
            :datefrom => params[:from],
            :dateto => params[:to],
            :count => params[:count],
            :page => params[:page]
          }))

          # Parse and return the response
          ::Freelancer::Models::Transaction.parse_collection(result, :shift => [ :"json-result", :items ])
          
        end

        # Retrieve a list of milestones for the current user
        #
        # Valid parameters are:
        #   - type: the type of milestone (Incoming (default) or Outgoing)
        #   - count: the number of results to return (defaults to 50)
        #   - page: the page to retrieve (defaults to 0)
        def account_milestones(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Payment/getAccountMilestoneList.json", build_api_params({
            :type => params[:type],
            :count => params[:count],
            :page => params[:page]
          }))

          # Parse and return the response
          ::Freelancer::Models::Milestone.parse_collection(result, :shift => [ :"json-result", :items ])
          
        end

        # Retrieve a list of withdrawals for the current user
        #
        # Valid parameters are:
        #   - type: the type of withdrawal (Incoming (default) or Outgoing)
        #   - count: the number of results to return (defaults to 50)
        #   - page: the page to retrieve (defaults to 0)
        def account_withdrawals(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Payment/getAccountWithdrawalList.json", build_api_params({
            :type => params[:type],
            :count => params[:count],
            :page => params[:page]
          }))

          # Parse and return the response
          ::Freelancer::Models::Withdrawal.parse_collection(result, :shift => [ :"json-result", :items ])
          
        end

        # Retrieve the balance for the current user
        def balance

          result = api_get("/Payment/getBalance.json")
          json = JSONMapper::Parser.parse(result)

          if !json.nil? && json.key?(:"json-result")
            return json[:"json-result"][:balance].to_f
          end
          return nil

        end

        # Retrieve a list of available withdrawal fees
        def withdrawal_fees

          result = api_get("/Payment/getWithdrawalFees.json")
          ::Freelancer::Models::WithdrawalFee.parse_collection(result, :shift => [ :"json-result", :items, :fee ])
          
        end

        # Retrieve a list of projects that's available for transfers
        def projects_for_transfer

          result = api_get("/Payment/getProjectListForTransfer.json")
          ::Freelancer::Models::Project.parse_collection(result, :shift => [ :"json-result", :items, :project ])
          
        end

      end
    end
  end
end
