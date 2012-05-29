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

        # Request withdrawal of funds
        #
        # Valid parameters are:
        #   - amount: the amount of money to withdraw
        #   - method: the withdrawal method (paypal, moneybooker, wire, paynoneer)
        #   - wire_comment: withdrawal comment for wire transfer
        #   - paypal_email: paypal account to withdraw to
        #   - moneybooker_account: moneybooker account to withdraw to
        #   - description: description for wire transfer withdrawal
        #   - country_code: country code for wire transfer withdrawal
        def request_withdrawal(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Payment/requestWithdrawal.json", build_api_params({
            :amount => params[:amount],
            :method => params[:method],
            :additionaltext => params[:wire_comment],
            :paypalemail => params[:paypal_email],
            :mb_account => params[:moneybooker_account],
            :description => params[:description],
            :country_code => params[:country_code]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Create a new milestone payment
        #
        # Valid parameters are:
        #   - project_id: the id of the project to create the payment for
        #   - amount: the amount of money to add to the milestone payment
        #   - user_id: the id of the user to make out the payment to
        #   - username: the username of the user to make out the payment to
        #   - comment: the comment of the payment
        #   - type: the milestone payment type (partial, full or other)
        def create_milestone_payment(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Payment/createMilestonePayment.json", build_api_params({
            :projectid => params[:project_id],
            :amount => params[:amount],
            :touserid => params[:user_id],
            :tousername => params[:username],
            :reasontext => params[:comment],
            :reasontype => params[:type]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Transfer money to another user
        #
        # Valid parameters are:
        #   - project_id: the id of the project to transfer money for
        #   - amount: the amount of money to transfer
        #   - user_id: the id of the user to transfer the money to
        #   - username: the username of the user to transfer the money to
        #   - comment: the comment of the transfer
        #   - type: the transfer type (partial, full or other)
        def transfer_money(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Payment/transferMoney.json", build_api_params({
            :projectid => params[:project_id],
            :amount => params[:amount],
            :touserid => params[:user_id],
            :tousername => params[:username],
            :reasontext => params[:comment],
            :reasontype => params[:type]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Cancel a money withdrawal request
        #
        # Valid parameters are:
        #   - withdrawal_id: the id of the withdrawal to cancel
        def cancel_withdrawal(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Payment/requestCancelWithdrawal.json", build_api_params({
            :withdrawalid => params[:withdrawal_id]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Cancel a milestone payment
        #
        # Valid parameters are:
        #   - transaction_id: the id of the milestone transaction to cancel
        def cancel_milestone(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Payment/cancelMilestone.json", build_api_params({
            :transactionid => params[:transaction_id]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Request to release a milestone payment
        #
        # Valid parameters are:
        #   - transaction_id: the id of the milestone transaction to release
        def request_release_milestone(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Payment/requestReleaseMilestone.json", build_api_params({
            :transactionid => params[:transaction_id]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Release a milestone payment
        #
        # Valid parameters are:
        #   - transaction_id: the id of the milestone transaction to release
        #   - full_name: the full name of the payer (signature)
        def release_milestone(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Payment/releaseMilestone.json", build_api_params({
            :transactionid => params[:transaction_id],
            :fullname => params[:full_name]
          }))

          # Parse and return the response
          ::Freelancer::Models::StatusConfirmation.parse(result, :shift => :"json-result")
          
        end

        # Prepare a transfer to validate it before actually transfering
        #
        # Valid parameters are:
        #   - project_id: the id of the project to transfer money for
        #   - amount: the amount of money to transfer
        #   - user_id: the id of the user to transfer money to
        #   - type: the type of transfer (partial, full or other)
        def prepare_transfer(*args)

          params = extract_params(args)

          # Execute the service call
          result = api_get("/Payment/prepareTransfer.json", build_api_params({
            :projectid => params[:project_id],
            :amount => params[:amount],
            :touserid => params[:user_id],
            :reasontype => params[:type]
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
