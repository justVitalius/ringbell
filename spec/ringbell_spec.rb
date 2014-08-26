require 'spec_helper'
require 'ringbell'

describe "RingBell object" do

  before :each do
    RingBell::Notification.destroy_all
  end

  with_model :Email do
    table do |t|
      t.string :name
      t.timestamps
    end

    model do
      include RingBell

      belongs_to :reader, class_name: 'User'
      default_interesants :reader
    end
  end

  with_model :User do
    table do |t|
      t.string :name
      t.timestamps
    end

    model do
      has_many :objs
    end
  end

  subject!(:email) {Email.create}

  let(:user) {User.create}
  let(:user2) {User.create}

  it "can be accessed as a constant" do
    expect(email).to be
  end

  it 'can get interesants' do
    expect(subject.interesants).to be_instance_of Array
  end

  it 'can have notifications' do
    expect(subject.notifications).to respond_to(:count)
  end

  it 'can get class interesants' do
    expect(subject.class.interesants).to be_instance_of Array
  end

  # TODO: rewrite/add tests using "notify interesants", not "notifications.create"
  it 'can clear notifications' do
    expect { subject.notifications.create(user_id: user.id) }
      .to change{subject.notifications.count}.from(0).to(1)

    expect { subject.clear_notifications for: user}
      .to change{subject.notifications.count}.from(1).to(0)
  end

  it 'can clear notifications for specified user' do
    subject.notifications.create(user_id: user.id)
    subject.notifications.create(user_id: user2.id)

    expect {subject.clear_notifications(for: user) }.to change{subject.notifications.count}.from(2).to(1)
  end

  it 'can check if user have notification' do
    expect {subject.notifications.create(user_id: user.id)}.to change {subject.has_notification_for? user}.from(false).to(true)
  end

  context 'in advanced mode' do
    it 'can create single notifications' do
      expect { subject.notifications.create(user_id: user.id) }
        .to change{subject.notifications.count}.from(0).to(1)
    end

    it 'can set/read notification message' do
      expect {subject.notifications.create(user_id: user.id, message: 'test')}.not_to raise_error
    end
  end

  it 'can get array of notifications for the user' do
    expect {subject.notifications.create(user_id: user.id)}.to change {subject.notifications.count}.from(0).to(1)
    expect {subject.notifications.create(user_id: user2.id)}.to change {subject.notifications.count}.from(1).to(2)

    expect(subject.class.notifications_for user).to be_kind_of ActiveRecord::Relation
    expect((subject.class.notifications_for user).count).to be == 1
  end
    
end