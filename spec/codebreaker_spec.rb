require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }

    describe '.start' do

      it 'has instance variable @secret_code' do
        expect(game.instance_variable_get(:@secret_code)).not_to be nil
      end

      it 'generate secret_code' do
        game.start
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'call generate_secret_code' do
        expect(game).to receive(:generate_secret_code)
        game.start
      end
    end

    describe '.generate_secret_code' do
      before { game.send(:generate_secret_code) }

      it 'has size == 4' do
        expect(game.instance_variable_get(:@secret_code).size).to eq 4
      end

      it 'contain digits from 1..6' do
        expect(game.instance_variable_get(:@secret_code)).to match /[1-6]{4}/
      end
    end

    describe '.compare_with' do
      before { game.instance_variable_set(:@secret_code, '1243') }
      #range = '4321', '5566', '2311', '1146', '4652', '1333', '1111', '1243'
      let(:compare_action) { game.compare_with('1234') }

      it 'is present' do
        expect(game).to respond_to(:compare_with)
      end

      it 'set @user_option' do
        expect{ compare_action }.to change{ game.user_option }.to ('1234')
      end

      it 'compare user_option with secret_code', :skip do
        expect(compare_action).to eq '++--'
      end
      #it 'replies according to the marking algorithm'

      it 'decrease attempt by 1' do
        expect{ compare_action }.to change{ game.attempt }.from(10).to(9)
      end

      it 'call expliсit_matches' do
        expect(game).to receive(:expliсit_matches)
        compare_action
      end

      context 'When user_option doesn`t match the pattern' do
        it 'raise ArgumentError' do
          expect{ game.compare_with('foo') }.to raise_error(ArgumentError)
        end
      end
    end

    describe '.expliсit_matches' do

      it 'marking only `+`'
    end
  end
end
