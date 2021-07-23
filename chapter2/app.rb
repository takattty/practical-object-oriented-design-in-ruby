class Gear
  # インスタンス変数を呼び出す為だけのメソッド
  # 各メソッドが振る舞い（1箇所で定義される）になっている。
  attr_reader :chainring, :cog, :wheel

  # def chainring
  #   @chainring
  # end

  # def cog
  #   @cog
  # end

  def initialize(chainring, cog, wheel=nil)
    @chainring = chainring
    @cog       = cog
    @wheel     = wheel
  end

  def ratio
    # ここは変数を呼び出しているのではなく、上のアクセサメソッドを呼び出している
    # 変数をクラスからも隠蔽し、直接参照されない様にしている。
    # to_f = to floatのメソッド
    chainring / cog.to_f
  end

  def gear_inches
    # ratio * (rim + (tire * 2))
    # 計算の分割
    ratio * wheel.diameter
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

@wheel = Wheel.new(26, 1.5)
p @wheel.circumference
p Gear.new(52, 11, @wheel).gear_inches
p Gear.new(52, 11).ratio