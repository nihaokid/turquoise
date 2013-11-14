require 'spec_helper'

describe URIHandler do
  let(:rui_handler) {
    URIHandler.new('/hello/:id/world/:name')
  }
  subject {rui_handler}

  context "match?" do
    it "uri should be true" do
      uri = '/hello/aa/world/ss'
      subject.match?(uri).should eq(true)
    end

    it "uri should not be true" do
      uri = '/hello/a/a/world/ss'
      subject.match?(uri).should eq(false)
    end
  end

end
