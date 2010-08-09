# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{freelancer}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Trond Arve Nordheim"]
  s.date = %q{2010-08-09}
  s.description = %q{Ruby gem implementation of the Freelancer.com API}
  s.email = %q{tanordheim@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "Gemfile",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "init.rb",
     "lib/freelancer.rb",
     "lib/freelancer/api.rb",
     "lib/freelancer/api/common.rb",
     "lib/freelancer/api/employer.rb",
     "lib/freelancer/api/freelancer.rb",
     "lib/freelancer/api/job.rb",
     "lib/freelancer/api/message.rb",
     "lib/freelancer/api/notification.rb",
     "lib/freelancer/api/payment.rb",
     "lib/freelancer/api/profile.rb",
     "lib/freelancer/api/project.rb",
     "lib/freelancer/api/user.rb",
     "lib/freelancer/client.rb",
     "lib/freelancer/extensions/hash.rb",
     "lib/freelancer/models/address.rb",
     "lib/freelancer/models/balance.rb",
     "lib/freelancer/models/bid.rb",
     "lib/freelancer/models/config_version.rb",
     "lib/freelancer/models/eligibility.rb",
     "lib/freelancer/models/job.rb",
     "lib/freelancer/models/job_category.rb",
     "lib/freelancer/models/message.rb",
     "lib/freelancer/models/milestone.rb",
     "lib/freelancer/models/news.rb",
     "lib/freelancer/models/notification.rb",
     "lib/freelancer/models/notification_status.rb",
     "lib/freelancer/models/project.rb",
     "lib/freelancer/models/project_budget.rb",
     "lib/freelancer/models/project_fee.rb",
     "lib/freelancer/models/project_options.rb",
     "lib/freelancer/models/rating.rb",
     "lib/freelancer/models/review.rb",
     "lib/freelancer/models/transaction.rb",
     "lib/freelancer/models/user.rb",
     "lib/freelancer/models/withdrawal.rb",
     "lib/freelancer/models/withdrawal_fee.rb",
     "lib/freelancer/support/json_mapper.rb",
     "test/fixtures/common/get_config_version.json",
     "test/fixtures/common/get_config_version.xml",
     "test/fixtures/common/get_pending_feedback.json",
     "test/fixtures/common/get_pending_feedback.xml",
     "test/fixtures/common/get_terms.json",
     "test/fixtures/common/get_terms.xml",
     "test/fixtures/common/post_feedback.json",
     "test/fixtures/common/post_feedback.xml",
     "test/fixtures/common/post_reply_for_feedback.json",
     "test/fixtures/common/post_reply_for_feedback.xml",
     "test/fixtures/common/request_cancel_project.json",
     "test/fixtures/common/request_cancel_project.xml",
     "test/fixtures/common/request_withdraw_feedback.json",
     "test/fixtures/common/request_withdraw_feedback.xml",
     "test/fixtures/employer/choose_winner_for_project.json",
     "test/fixtures/employer/choose_winner_for_project.xml",
     "test/fixtures/employer/delete_draft_project.json",
     "test/fixtures/employer/delete_draft_project.xml",
     "test/fixtures/employer/eligible_for_trial_project.json",
     "test/fixtures/employer/eligible_for_trial_project.xml",
     "test/fixtures/employer/get_posted_project_list.json",
     "test/fixtures/employer/get_posted_project_list.xml",
     "test/fixtures/employer/invite_user_for_project.json",
     "test/fixtures/employer/invite_user_for_project.xml",
     "test/fixtures/employer/post_new_draft_project.json",
     "test/fixtures/employer/post_new_draft_project.xml",
     "test/fixtures/employer/post_new_project.json",
     "test/fixtures/employer/post_new_project.xml",
     "test/fixtures/employer/post_new_trial_project.json",
     "test/fixtures/employer/post_new_trial_project.xml",
     "test/fixtures/employer/publish_draft_project.json",
     "test/fixtures/employer/publish_draft_project.xml",
     "test/fixtures/employer/update_project_details.json",
     "test/fixtures/employer/update_project_details.xml",
     "test/fixtures/employer/upgrade_trial_project.json",
     "test/fixtures/employer/upgrade_trial_project.xml",
     "test/fixtures/freelancer/accept_bid_won.json",
     "test/fixtures/freelancer/accept_bid_won.xml",
     "test/fixtures/freelancer/get_project_list_for_placed_bids.json",
     "test/fixtures/freelancer/get_project_list_for_placed_bids.xml",
     "test/fixtures/freelancer/place_bid_on_project.json",
     "test/fixtures/freelancer/place_bid_on_project.xml",
     "test/fixtures/freelancer/retract_bid_from_project.json",
     "test/fixtures/freelancer/retract_bid_from_project.xml",
     "test/fixtures/job/get_category_job_list.json",
     "test/fixtures/job/get_category_job_list.xml",
     "test/fixtures/job/get_job_list.json",
     "test/fixtures/job/get_job_list.xml",
     "test/fixtures/job/get_my_job_list.json",
     "test/fixtures/job/get_my_job_list.xml",
     "test/fixtures/message/get_inbox_messages.json",
     "test/fixtures/message/get_inbox_messages.xml",
     "test/fixtures/message/get_sent_messages.json",
     "test/fixtures/message/get_sent_messages.xml",
     "test/fixtures/message/get_unread_count.json",
     "test/fixtures/message/get_unread_count.xml",
     "test/fixtures/message/load_message_thread.json",
     "test/fixtures/message/load_message_thread.xml",
     "test/fixtures/message/mark_message_as_read.json",
     "test/fixtures/message/mark_message_as_read.xml",
     "test/fixtures/message/send_message.json",
     "test/fixtures/message/send_message.xml",
     "test/fixtures/notification/get_news.json",
     "test/fixtures/notification/get_news.xml",
     "test/fixtures/notification/get_notification.json",
     "test/fixtures/notification/get_notification.xml",
     "test/fixtures/payment/cancel_milestone.json",
     "test/fixtures/payment/cancel_milestone.xml",
     "test/fixtures/payment/create_milestone_payment.json",
     "test/fixtures/payment/create_milestone_payment.xml",
     "test/fixtures/payment/get_account_balance_status.json",
     "test/fixtures/payment/get_account_balance_status.xml",
     "test/fixtures/payment/get_account_milestone_list.json",
     "test/fixtures/payment/get_account_milestone_list.xml",
     "test/fixtures/payment/get_account_transaction_list.json",
     "test/fixtures/payment/get_account_transaction_list.xml",
     "test/fixtures/payment/get_account_withdrawal_list.json",
     "test/fixtures/payment/get_account_withdrawal_list.xml",
     "test/fixtures/payment/get_balance.json",
     "test/fixtures/payment/get_balance.xml",
     "test/fixtures/payment/get_project_list_for_transfer.json",
     "test/fixtures/payment/get_project_list_for_transfer.xml",
     "test/fixtures/payment/get_withdrawal_fees.json",
     "test/fixtures/payment/get_withdrawal_fees.xml",
     "test/fixtures/payment/prepare_transfer.json",
     "test/fixtures/payment/prepare_transfer.xml",
     "test/fixtures/payment/release_milestone.json",
     "test/fixtures/payment/release_milestone.xml",
     "test/fixtures/payment/request_cancel_withdrawal.json",
     "test/fixtures/payment/request_cancel_withdrawal.xml",
     "test/fixtures/payment/request_release_milestone.json",
     "test/fixtures/payment/request_release_milestone.xml",
     "test/fixtures/payment/request_withdrawal.json",
     "test/fixtures/payment/request_withdrawal.xml",
     "test/fixtures/payment/transfer_money.json",
     "test/fixtures/payment/transfer_money.xml",
     "test/fixtures/profile/get_account_details.json",
     "test/fixtures/profile/get_account_details.xml",
     "test/fixtures/profile/get_profile_info.json",
     "test/fixtures/profile/get_profile_info.xml",
     "test/fixtures/profile/set_profile_info.json",
     "test/fixtures/profile/set_profile_info.xml",
     "test/fixtures/project/get_bids_details.json",
     "test/fixtures/project/get_bids_details.xml",
     "test/fixtures/project/get_project_budget_config.json",
     "test/fixtures/project/get_project_budget_config.xml",
     "test/fixtures/project/get_project_details.json",
     "test/fixtures/project/get_project_details.xml",
     "test/fixtures/project/get_project_fees.json",
     "test/fixtures/project/get_project_fees.xml",
     "test/fixtures/project/get_public_messages.json",
     "test/fixtures/project/get_public_messages.xml",
     "test/fixtures/project/get_sent_messages.xml",
     "test/fixtures/project/get_unread_count.xml",
     "test/fixtures/project/load_message_thread.xml",
     "test/fixtures/project/mark_message_as_read.xml",
     "test/fixtures/project/post_public_message.json",
     "test/fixtures/project/post_public_message.xml",
     "test/fixtures/project/search_projects.json",
     "test/fixtures/project/search_projects.xml",
     "test/fixtures/project/send_message.xml",
     "test/fixtures/user/get_user_details.json",
     "test/fixtures/user/get_user_details.xml",
     "test/fixtures/user/get_user_feedback.json",
     "test/fixtures/user/get_user_feedback.xml",
     "test/fixtures/user/get_users_by_search.json",
     "test/fixtures/user/get_users_by_search.xml",
     "test/freelancer/api/common_api_test.rb",
     "test/freelancer/api/employer_api_test.rb",
     "test/freelancer/api/freelancer_api_test.rb",
     "test/freelancer/api/job_api_test.rb",
     "test/freelancer/api/message_api_test.rb",
     "test/freelancer/api/notification_api_test.rb",
     "test/freelancer/api/payment_api_test.rb",
     "test/freelancer/api/profile_api_test.rb",
     "test/freelancer/api/project_api_test.rb",
     "test/freelancer/api/user_api_test.rb",
     "test/freelancer/client_test.rb",
     "test/freelancer/models/balance_test.rb",
     "test/freelancer/models/bid_test.rb",
     "test/freelancer/models/config_version.rb",
     "test/freelancer/models/eligibility_test.rb",
     "test/freelancer/models/job_category_test.rb",
     "test/freelancer/models/job_test.rb",
     "test/freelancer/models/message_test.rb",
     "test/freelancer/models/milestone_test.rb",
     "test/freelancer/models/news_test.rb",
     "test/freelancer/models/notification_test.rb",
     "test/freelancer/models/project_budget_test.rb",
     "test/freelancer/models/project_fee_test.rb",
     "test/freelancer/models/project_test.rb",
     "test/freelancer/models/review_test.rb",
     "test/freelancer/models/transaction_test.rb",
     "test/freelancer/models/user_test.rb",
     "test/freelancer/models/withdrawal_fee_test.rb",
     "test/freelancer/models/withdrawal_test.rb",
     "test/freelancer/oauth_test.rb",
     "test/freelancer_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/tanordheim/freelancer}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Freelancer API}
  s.test_files = [
    "test/freelancer_test.rb",
     "test/test_helper.rb",
     "test/freelancer/api/freelancer_api_test.rb",
     "test/freelancer/api/user_api_test.rb",
     "test/freelancer/api/notification_api_test.rb",
     "test/freelancer/api/job_api_test.rb",
     "test/freelancer/api/message_api_test.rb",
     "test/freelancer/api/common_api_test.rb",
     "test/freelancer/api/project_api_test.rb",
     "test/freelancer/api/payment_api_test.rb",
     "test/freelancer/api/employer_api_test.rb",
     "test/freelancer/api/profile_api_test.rb",
     "test/freelancer/client_test.rb",
     "test/freelancer/oauth_test.rb",
     "test/freelancer/models/bid_test.rb",
     "test/freelancer/models/balance_test.rb",
     "test/freelancer/models/job_test.rb",
     "test/freelancer/models/job_category_test.rb",
     "test/freelancer/models/notification_test.rb",
     "test/freelancer/models/user_test.rb",
     "test/freelancer/models/project_test.rb",
     "test/freelancer/models/milestone_test.rb",
     "test/freelancer/models/config_version.rb",
     "test/freelancer/models/withdrawal_test.rb",
     "test/freelancer/models/project_budget_test.rb",
     "test/freelancer/models/message_test.rb",
     "test/freelancer/models/eligibility_test.rb",
     "test/freelancer/models/news_test.rb",
     "test/freelancer/models/review_test.rb",
     "test/freelancer/models/withdrawal_fee_test.rb",
     "test/freelancer/models/transaction_test.rb",
     "test/freelancer/models/project_fee_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oauth>, [">= 0.4.0"])
      s.add_runtime_dependency(%q<htmlentities>, [">= 4.2.1"])
      s.add_runtime_dependency(%q<json_mapper>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 2.10.3"])
      s.add_development_dependency(%q<mcmire-matchy>, [">= 0.5.2"])
      s.add_development_dependency(%q<mocha>, [">= 0.9.8"])
      s.add_development_dependency(%q<fakeweb>, [">= 1.2.8"])
    else
      s.add_dependency(%q<oauth>, [">= 0.4.0"])
      s.add_dependency(%q<htmlentities>, [">= 4.2.1"])
      s.add_dependency(%q<json_mapper>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 2.10.3"])
      s.add_dependency(%q<mcmire-matchy>, [">= 0.5.2"])
      s.add_dependency(%q<mocha>, [">= 0.9.8"])
      s.add_dependency(%q<fakeweb>, [">= 1.2.8"])
    end
  else
    s.add_dependency(%q<oauth>, [">= 0.4.0"])
    s.add_dependency(%q<htmlentities>, [">= 4.2.1"])
    s.add_dependency(%q<json_mapper>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 2.10.3"])
    s.add_dependency(%q<mcmire-matchy>, [">= 0.5.2"])
    s.add_dependency(%q<mocha>, [">= 0.9.8"])
    s.add_dependency(%q<fakeweb>, [">= 1.2.8"])
  end
end

