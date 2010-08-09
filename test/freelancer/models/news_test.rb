class NewsTest < Test::Unit::TestCase

  context "news model" do

    should "create news list based on json" do

      news = Freelancer::Models::News.parse_collection(fixture_file("notification/get_news.json"), :shift => [ :"json-result", :items ])
      news.size.should == 8
      news.first.id.should == 177
      news.first.text.size.should > 10

    end

  end
end
