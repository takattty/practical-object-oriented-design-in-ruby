class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(args)
    @chainring = args[:chainring] || 40
    @cog       = args[:cog] || 18
    @wheel     = args[:wheel]
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
    # ratio * Whell.new(rim, tire).diameter
    # ratio * Chain.new(rim, tire).diameter
    # ratio * Hoge.new(rim, tire).diameter
    ratio * diameter
  end

  # 上のメッセージはself(=Gear)にしか依存していない
  # このメソッドのみが@wheelに依存している
  def diameter
    wheel.diameter
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

# Wheelクラスのインスタンス生成を、Gearクラスの外に出す。疎結合に。
p Gear.new(
  :chainring => 52,
  :cog       => 11,
  :wheel     => Wheel.new(26, 1.5)).gear_inches