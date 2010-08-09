class ConfigVersionTest < Test::Unit::TestCase

  context "config version model" do

    should "create config version instance based on JSON" do
      
      version = Freelancer::Models::ConfigVersion.parse(fixture_file("common/get_config_version.json"), :shift => :"json-result")
      version.function.should == "withdrawalfee"
      version.version.should == 1

    end

  end
end
