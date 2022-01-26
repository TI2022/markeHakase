require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  describe "shipment_notification" do
    let(:mail) { OrderMailer.shipment_notification }

    it "renders the headers" do
      expect(mail.subject).to eq("Shipment notification")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
