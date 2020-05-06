class Oystercard
  MAX_BALANCE = 90
  attr_accessor :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    return raise "Error: Cannot top-up balance beyond #{MAX_BALANCE} current balance is #{self.balance}" if self.balance + amount > MAX_BALANCE
    self.balance += amount
  end

  def deduct_money(amount)
    self.balance -= amount
  end

end
