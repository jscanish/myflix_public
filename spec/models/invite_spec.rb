require 'spec_helper'

describe Invite do
  it { should belong_to(:inviter) }
  it { should validate_presence_of(:invitee_email) }
  it { should validate_presence_of(:invitee_name) }
end
