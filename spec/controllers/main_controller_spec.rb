require_relative '../spec_helper'
require_relative '../helpers/fake_shoes'

describe MainWindowController do
  include Shoes::SpecHelpers
  
  let(:model) {MainWindowController.instance}
  
  before do
    model.run!
  end
  
  it 'should select a level when a button is pressed' do
    LevelController.any_instance.should_receive(:run!).and_return true
    click_button '1-1'
  end
end
