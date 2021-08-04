class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @tire      = tire
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    # Gearクラスが、
    # Wheelクラスを知っている。
    # Wheelクラスのメソッドを知っている
    # Wheelクラスのインスタンス化（＝メッセージ）に要求される引数を知っている
    # Wheelクラスの引数の順番を知っている
    # これが依存。依存関係
    ratio * Wheel.new(rim, tire).diameter
  end
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim  = rim
    @tire = tire
  end

  def diameter # 直径
    rim + (tire * 2)
  end

  def circumference # 周
    diameter * Math::PI
  end
end

p Gear.new(52, 11, 26, 1.5).gear_inches