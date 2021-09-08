require 'rails_helper'

RSpec.describe Image, type: :model do 

  let(:user) { User.create(email: "test@example.com", password: "L0rem123#")}
  subject { Image.new(name: "Test Image", user: user)}

  context "validations" do 
    it "name should be present" do 
      expect(subject.name).to_not be_blank
    end

    it "name should be present" do 
      expect(subject).to be_valid
      subject.name = ''
      expect(subject).to_not be_valid
    end

    it "should attach image with activestorage" do 
      subject.gif_file.attach(io: File.open(
        Rails.root.join('spec', 'fixtures', 'test_image.gif')), 
        filename: 'test_image.gif', content_type: 'image/gif')
        expect(subject).to be_valid
        expect(subject.gif_file.attached?).to be true
    end 
    
    it "should attach larger gif images" do 
      subject.gif_file.attach(io: File.open(
        Rails.root.join('spec', 'fixtures', 'titleribbon.gif')), 
        filename: 'titleribbon.gif', content_type: 'image/gif')
        expect(subject).to_not be_valid
    end 
    
    it "should should upload only gif images" do 
      subject.gif_file.attach(io: File.open(
        Rails.root.join('spec', 'fixtures', 'mac.png')), 
        filename: 'mac.png', content_type: 'image/png')
        expect(subject).to_not be_valid
    end 
  end
end