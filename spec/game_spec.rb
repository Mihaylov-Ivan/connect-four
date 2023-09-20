require_relative '../lib/game.rb'
require_relative '../lib/player.rb'
require_relative '../lib/board.rb'
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

    describe '#get_symbol' do
        let(:player1_name) { String.new('Alex') }
        let(:player1_symbol) { String.new('X') }
        let(:player2_name) { String.new('Sam') }
        let(:player2_symbol) { String.new('Y') }
        let(:wrong_input) { String.new('2') }

        context 'when creating player 1' do
            before do
                allow(subject).to receive(:puts).with("#{player1_name}, what is you symbol? (a single symbol or letter)")
            end

            it 'returns the symbol with valid input' do
                allow(subject).to receive(:gets).and_return(player1_symbol)
                expect(subject.get_symbol(player1_name, nil)).to eq(player1_symbol)
            end
            it 'shows error after receiving invalid input, and returns symbol with valid input' do
                allow(subject).to receive(:gets).and_return(wrong_input, player1_symbol)
                allow(subject).to receive(:puts).with("\e[31mSorry, that is an invalid input. Please, try again.\e[0m")
                expect(subject.get_symbol(player1_name, nil)).to eq(player1_symbol)
            end
        end

        context 'when creating player 2' do
            before do
                allow(subject).to receive(:puts).with("#{player2_name}, what is you symbol? (a single symbol or letter)")
                allow(subject).to receive(:puts).with("Make sure it is not #{player1_symbol}")
            end

            it 'returns the symbol with valid input' do
                allow(subject).to receive(:gets).and_return(player2_symbol)
                expect(subject.get_symbol(player2_name, player1_symbol)).to eq(player2_symbol)
            end
            it 'shows error after receiving invalid input, and returns symbol with valid input' do
                allow(subject).to receive(:gets).and_return(wrong_input, player2_symbol)
                allow(subject).to receive(:puts).with("\e[31mSorry, that is an invalid input. Please, try again.\e[0m")
                expect(subject.get_symbol(player2_name, player1_symbol)).to eq(player2_symbol)
            end
        end
    end

    describe '#validate_move' do
        let(:invalid_move) { String.new('1') }
        let(:valid_move) { String.new('2') }

        before do
            allow(subject.board).to receive(:length).and_return(6)
        end

        context "when a valid move is entered" do
            it 'returns the move' do
                allow(subject).to receive(:check_move_input).and_return(valid_move)
                expect(subject.validate_move(valid_move)).to eq([5, 1])
            end
        end

        context "when an invalid move is entered, and then a valid one" do
            it 'displays error message once and then returns the move' do
                allow(subject).to receive(:check_move_input).and_return(invalid_move, valid_move)
                allow(subject).to receive(:gets).and_return(valid_move)
                allow(subject.board).to receive(:check_available).and_return(false, false, false, false, false, false, true)
                expect(subject).to receive(:puts).with("\e[31mSorry, that is an invalid move. Please, select a free slot.\e[0m").once
                expect(subject.validate_move(invalid_move)).to eq([5, 1])
            end
        end
    end

    describe '#check_move_input' do
        let(:invalid_input1) { String.new('0') }
        let(:invalid_input2) { String.new('9') }
        let(:valid_input) { String.new('2') }

        context "when an valid input is entered" do
            it 'returns the input' do
                expect(subject.check_move_input(valid_input)).to eq(valid_input)
            end
        end

        context "when an invalid input is entered twice, and then a valid one" do
            it 'displays an error twice, and then returns the input' do
                allow(subject).to receive(:gets).and_return(invalid_input2, valid_input)
                expect(subject).to receive(:puts).with("\e[31mSorry, that is an invalid input. Please, try again.\e[0m").twice
                expect(subject.check_move_input(invalid_input1)).to eq(valid_input)
            end
        end
    end
end
