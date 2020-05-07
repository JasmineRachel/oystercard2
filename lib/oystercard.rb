class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_accessor :balance
  attr_accessor :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    return raise "Error: Cannot top-up balance beyond #{MAX_BALANCE} current balance is #{self.balance}" if self.balance + amount > MAX_BALANCE
    self.balance += amount
  end

  def touch_in(station)
    return raise "Insufficient funds. Minimum balance is #{MIN_BALANCE}" if self.balance < MIN_BALANCE
    self.in_journey = true
  end

  def touch_out
    self.in_journey = false
    self.deduct_money(MIN_BALANCE)
  end

  private

  def deduct_money(amount)
    self.balance -= amount
  end

end
