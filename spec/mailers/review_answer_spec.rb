require "rails_helper"

RSpec.describe ReviewAnswerMailer, type: :mailer do
  describe "review_answer_notification" do
    let(:mail) { ReviewAnswerMailer.review_answer_notification }

    it "renders the headers" do
      expect(mail.subject).to eq("Review answer notification")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
