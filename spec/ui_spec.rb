# frozen_string_literal: true

module UI
  RSpec.describe UI do
    describe '#lost' do
      it 'have lost method' do
        expect(UI).to receive(:lost)
        UI.lost
      end
    end

    describe '#repeat_game?' do
      it 'have repeat_game? method' do
        expect(UI).to receive(:repeat_game?)
        UI.repeat_game?
      end
    end
  end
end
