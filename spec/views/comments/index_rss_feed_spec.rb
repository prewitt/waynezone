require 'spec_helper'

describe "comments/index_rss_feed.rss.builder" do
  let!(:blog) { build_stubbed :blog }

  describe "rendering comments" do
    let(:article) { FactoryGirl.build_stubbed :article }
    let(:comment) { FactoryGirl.build_stubbed(:comment, article: article, body: "Comment body", guid: '12313123123123123') }

    before(:each) do
      assign(:items, [comment])
      render
    end

    it "should render a valid rss feed" do
      assert_feedvalidator rendered
      assert_rss20 rendered, 1
    end

    describe "the comment entry" do
      it "should have all the required attributes" do
        xml = Nokogiri::XML.parse(rendered)
        entry_xml = xml.css("item").first

        entry_xml.css("title").first.content.should ==
          "Comment on #{article.title} by #{comment.author}"
        entry_xml.css("guid").first.content.should == "urn:uuid:12313123123123123"
        entry_xml.css("description").first.content.should == "<p>Comment body</p>"
        entry_xml.css("link").first.content.should == "#{article.permalink_url}#comment-#{comment.id}"
      end
    end
  end
end
