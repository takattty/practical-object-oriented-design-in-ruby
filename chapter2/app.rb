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

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @wheel     = Wheel.new(rim. tire)
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

  Wheel = Struct.new(:rim, :tire) do
    def diameter
      rim + (tire * 2)
    end
  end

end

puts Gear.new(52, 11, 26, 1.5).gear_inches
puts Gear.new(30, 27, 24, 1.25).gear_inches