require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "#available?" do
    let(:host_user) { create :user, email: "host@user.com" }
    let(:guest_user) { create :user, email: "guest@user.com" }

    let(:room) { create :room, price: 20, user: host_user }

    let!(:existent_booking) { create :booking, room: room, starts_at: 2.days.from_now, ends_at: 6.days.from_now, user: guest_user }

    context "is available" do
      subject { room.available?(8.days.from_now, 10.days.from_now) }

      it "returns true" do
        expect(subject).to be true
      end
    end

    context "is not available" do
      subject { room.available?(4.days.from_now, 10.days.from_now) }

      it "returns false" do
        expect(subject).to be false
      end
    end
  end
end
