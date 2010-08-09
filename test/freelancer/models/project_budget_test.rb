class ProjectBudgetTest < Test::Unit::TestCase

  context "project budget model" do

    should "create project budgets based on JSON" do

      budgets = Freelancer::Models::ProjectBudget.parse_collection(fixture_file("project/get_project_budget_config.json"), :shift => [ :"json-result", :items ])
      budgets.size.should == 6
      budgets.first.id.should == 5
      budgets.first.minimum_budget.should == 30
      budgets.first.maximum_budget.should == 250
      budgets.first.name.should == "simple project"

    end

  end

end
