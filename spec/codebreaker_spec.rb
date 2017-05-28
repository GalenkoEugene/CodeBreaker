# frozen_string_literal: true

require 'spec_helper'

# Core for Game CodeBreaker
module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }

    describe '.start' do
      it 'has instance variable @secret_code' do
        expect(game.instance_variable_get(:@secret_code)).not_to be nil
      end

      it 'call generate_secret_code' do
        expect(game).to receive(:generate_secret_code)
        game.start
      end

      it 'generate secret_code' do
        game.start
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'set amount of attempts' do
        game.start
        expect(game.attempts).to eq(10)
      end
    end

    describe '.generate_secret_code' do
      before { game.send(:generate_secret_code) }

      it 'has size == 4' do
        expect(game.instance_variable_get(:@secret_code).size).to eq 4
      end

      it 'contain only digits from 1..6' do
        expect(game.instance_variable_get(:@secret_code).join)
          .to match(/^[1-6]{4}$/)
      end
    end

    describe '.compare_with' do
      before do
        game.start
        game.instance_variable_set(:@secret_code, %w[1 2 4 3])
      end
      let(:compare_action) { game.compare_with('1234') }

      it 'is present' do
        expect(game).to respond_to(:compare_with)
      end

      it 'compare user_option with secret_code' do
        expect(compare_action).to eq '++--'
      end

      secret = 1243
      user_op = %w[4321 5566 6513 1142 4652 1333 1111 1243 2111 5515 1621]
      result = '----', '', '+-', '++-', '--', '++', '+', '++++', '--', '-', '+-'

      user_op.each_with_index do |user_option, index|
        it 'replies according to the marking algorithm: ' \
            "[#{secret}] & [#{user_option}] => '#{result[index]}'" do
          expect(game.compare_with(user_option)).to eq result[index]
        end
      end

      it 'decrease attempts by 1' do
        expect { compare_action }.to change { game.attempts }.from(10).to(9)
      end

      it 'call explicit_matches' do
        expect(game).to receive(:explicit_matches)
        compare_action
      end

      it 'call implicit_matches' do
        expect(game).to receive(:implicit_matches)
        compare_action
      end

      context 'When user_option doesn`t match the pattern' do
        it 'raise ArgumentError' do
          expect { game.compare_with('foo') }.to raise_error(ArgumentError)
        end
      end
    end

    describe '.expliсit_matches' do
      it 'able to change user_option' do
        game.instance_variable_set(:@secret_code, %w[1 2 4 3])
        game.instance_variable_set(:@user_option, %w[1 2 3 4])
        expect { game.send(:explicit_matches) }
          .to change { game.instance_variable_get :@user_option }.to %w[+ + 3 4]
      end
    end

    describe '.implicit_matches' do
      it 'return result' do
        game.instance_variable_set(:@dup_secret, %w[+ + 4 3])
        game.instance_variable_set(:@user_option, %w[+ + 3 4])
        expect(game.send(:implicit_matches)).to eq '++--'
      end
    end

    describe '.hint' do
      it 'able to call during the game' do
        expect(game).to respond_to(:hint)
      end

      it 'show one number from secret code' do
        game.instance_variable_set(:@secret_code, %w[1 2 4 3])
        hint = game.hint
        expect(game.instance_variable_get(:@secret_code)).to include(hint)
      end
    end

    describe '.save' do
      before do
        Game.instance_eval { remove_const('PATH_TO_DATA') }
        Game.const_set('PATH_TO_DATA', './test_data.yaml')
        game.instance_variable_set(:@result, '++++')
        game.instance_variable_set(:@attempts, 7)
      end
      let(:name) { 'Jimmy' }
      let(:zero_attempts) { game.instance_variable_set(:@attempts, 0) }
      let(:looser_option) { game.instance_variable_set(:@result, '--') }
      after(:all) { File.delete './test_data.yaml' }

      context 'game isn`t finished' do
        it 'raise exception' do
          looser_option
          expect { game.save(name) }.to raise_exception('Game is unfinished')
        end
      end

      context 'attempts is runs out' do
        before { allow(game).to receive(:form_data) }

        it 'Does not raise an exception' do
          looser_option
          zero_attempts
          expect { game.save(name) }.not_to raise_exception
        end

        it 'Does not raise an exception' do
          expect { game.save(name) }.not_to raise_exception
        end
      end

      it 'game.save, call #form_data' do
        expect(game).to receive(:form_data).with(String)
        game.save(name)
      end

      describe '#form_data' do
        it 'generate score accordind to the remaining attempts' do
          zero_attempts
          expect(game.send(:generate_score)).to eq '21'
        end

        describe '#generate_score' do
          it 'generate accordind to the remaining attempts' do
            looser_option
            zero_attempts
            expect(game.send(:generate_score)).to eq 0
          end
        end

        it 'format data before save to file' do
          expect(game.send(:form_data, name)).to be_a Struct
        end
      end
    end

    describe '#score' do
      it 'show score of all games '
    end
  end
end
