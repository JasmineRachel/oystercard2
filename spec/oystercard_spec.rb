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
end
