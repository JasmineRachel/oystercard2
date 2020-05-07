require 'oystercard'
RSpec.describe Oystercard do
  it 'can create an card' do
    card = Oystercard.new

    expect(card.class).to eq(Oystercard)
  end

  it 'has a start balance of 0' do
    card = Oystercard.new

    expect(card.balance).to eq(0)
  end

  it 'can top_up balance' do
    card = Oystercard.new

    card.top_up(50)

    expect(card.balance).to eq(50)
  end

  it 'raises an error when top up attempted beyond limit' do
    card = Oystercard.new

    card.top_up(90)

    expect { card.top_up(1) }.to raise_error("Error: Cannot top-up balance beyond #{Oystercard::MAX_BALANCE} current balance is #{card.balance}")
  end

  it 'deducts money from current balance' do
    card = Oystercard.new

    card.top_up(50)
    card.deduct_money(2)

    expect(card.balance).to eq(48)
  end

  it 'in_journey? is initialized at false' do
    card = Oystercard.new

    expect(card.in_journey).to eq(false)
  end

  it 'can touch in card' do
    card = Oystercard.new
    station = double(:Station)

    card.top_up(50)
    card.touch_in(station)

    expect(card.in_journey).to be(true)
  end

  it "can touch out card" do
    card = Oystercard.new
    station = double(:Station)

    card.top_up(50)
    card.touch_in(station)
    card.touch_out

    expect(card.in_journey).to be(false)
  end

  it 'knows the minimum balance' do
    expect(Oystercard::MIN_BALANCE).to eq(1)
  end

  it 'refuses touch in if balance is less than minimum balance' do
    card = Oystercard.new

    expect { card.touch_in }.to raise_error("Insufficient funds. Minimum balance is #{Oystercard::MIN_BALANCE}")
  end

  it 'deducts money from balance when the journey has ended.' do
    card = Oystercard.new
    station = double(:Station)
    initial_balance = card.top_up(50)
    card.touch_in(station)

    expect { card.touch_out }.to change { card.balance }.by((Oystercard::MIN_BALANCE * -1))
  end

  it 'records entry station upon touching in.' do
    card = Oystercard.new
    station = double(:Station)

    card.top_up(50)
    card.touch_in(station)

    expect(card.entry_station).to eq(station)

  end
end
