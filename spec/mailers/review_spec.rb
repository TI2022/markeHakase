require "rails_helper"

RSpec.describe ReviewMailer, type: :mailer do
  describe "review_notification" do
    let(:mail) { ReviewMailer.review_notification }

    it "renders the headers" do
      expect(mail.subject).to eq("Review notification")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
