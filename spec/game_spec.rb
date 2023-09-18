require_relative '../lib/game.rb'
require_relative '../lib/player.rb'
require 'rspec'

describe Game do

    before do 
        allow(subject).to receive(:show_introduction)
    end

    describe '#create_player' do
        let(:player1_name) { String.new('Alex') }
        let(:player1_symbol) { String.new('X') }
        let(:player1_number) { 1 }
        let(:player2_name) { String.new('Sam') }
        let(:player2_symbol) { String.new('Y') }
        let(:player2_number) { 2 }

        context 'when creating player 1' do
            before do 
                allow(subject).to receive(:puts).with("\n  Player #{player1_number}, what is your name?\n  ")
                allow(subject).to receive(:puts).with("#{player1_name}, what is you symbol? (a single symbol or letter)")
            end

            it 'creates a player 1 object with valid input' do
                allow(subject).to receive(:gets).and_return(player1_name, player1_symbol)
                expect(Player).to receive(:new).with(player1_name, player1_symbol)
                subject.send(:create_player, player1_number)
                # subject.create_player(player1_number)
            end
            it 'creates a player 1 object after receiving two invalid symbols followed by a valid symbol' do
                allow(subject).to receive(:gets).and_return(player1_name, "1", "4", player1_symbol)
                expect(subject).to receive(:show_input_error).twice
                expect(Player).to receive(:new).with(player1_name, player1_symbol)
                subject.create_player(player1_number)
            end
        end
        context 'when creating player 2' do
            before do 
                allow(subject).to receive(:puts).with("\n  Player #{player2_number}, what is your name?\n  ")
                allow(subject).to receive(:puts).with("#{player2_name}, what is you symbol? (a single symbol or letter)")
                allow(subject).to receive(:puts).with("Make sure it is not #{player1_symbol}")
            end

            it 'creates a player 2 with valid input' do
                allow(subject).to receive(:gets).and_return(player2_name, player2_symbol)
                expect(Player).to receive(:new).with(player2_name, player2_symbol)
                subject.create_player(player2_number)
            end
            it 'creates a player 2 object after receiving an invalid symbol, a symbol identical to player 1, followed by a valid symbol' do
                allow(subject).to receive(:gets).and_return(player2_name, "1", player1_symbol, player2_symbol)
                expect(subject).to receive(:show_input_error).twice
                expect(Player).to receive(:new).with(player2_name, player2_symbol)
                subject.create_player(player2_number, player1_symbol)
            end
        end
    end
end
