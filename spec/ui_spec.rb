# frozen_string_literal: true

require 'spec_helper'

module UserInterface
  RSpec.describe UI do
    describe 'start' do
      it 'print appropriate message' do
        expect { UI.start }.to output("\nNew game was started...\n"\
          "Secret code successfully generated!\n").to_stdout
      end
    end

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

      it 'repeat game print message' do
        allow(UI).to receive(:yes?) { true }
        expect {UI.repeat_game?}
         .to output("Do you want to repeat the game? [y/yes/Enter]\n").to_stdout
      end

      context 'true/false' do
        before { allow(UI).to receive(:puts) }

        it 'repeat game' do
          allow(UI).to receive(:yes?) { true }
          expect(UI.repeat_game?).to be true
        end

        it 'isn`t repeat game' do
          allow(UI).to receive(:yes?) { false }
          expect(UI.repeat_game?).to be false
        end
      end
    end

    describe '#yes?' do
      yes = ['', 'y', 'yes']
      no = ['no', 'now', 'I don`t want to', 'bla bala', 'net', '-']

      context 'user want continue' do
        yes.size.times do |item|
          it "return true when '#{yes[item]}'" do
            allow(UI).to receive_message_chain('gets.chomp') { yes[item] }
            expect(UI.send(:yes?)).to be true
          end
        end
      end

      context 'user do not want continue' do
        no.size.times do |item|
          it "return false when '#{no[item]}'" do
            allow(UI).to receive_message_chain('gets.chomp') { no[item] }
            expect(UI.send(:yes?)).to be false
          end
        end
      end
    end

    describe '#save?' do
      it 'method save is present' do
        expect(UI).to receive(:save?)
        UI.save?
      end

      it 'prompt to save score' do
        allow(UI).to receive(:yes?)
        expect {UI.save?}
         .to output("Save your score? [y/yes/Enter]\n").to_stdout
      end
    end
  end
end
