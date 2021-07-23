class ObscuringReferences
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def diameters
    data.collect{ |cell| cell[0] + (cell[1] * 2) }
  end
end

obscuring_references = ObscuringReferences.new([[22, 33], [44, 55]])
p obscuring_references.diameters # [88, 154]

class RevealingReferences
  attr_reader :wheels

  def initialize(data)
    @wheels = wheelify(data)
  end

  def diameters
    # collectを使っているから、何かwheelが列挙されているものであること
    # その列挙されているものは、rimとtireに紐付いていること
    # 上記の二つが下のコードからわかる。配列の内部構造は何も知らない
    # wheels.collect { |wheel| wheel.rim + (wheel.tire * 2) }
    wheels.collect { |wheel| diameter(wheel) }
  end

  # ここで計算を抽出。繰り返し処理と分割する
  def diameter(wheel)
    wheel.rim + (wheel.tire * 2)
  end

  # ここでStructクラスを用いて簡易的なクラスを用意。
  Wheel = Struct.new(:rim, :tire)
  p Wheel # RevealingReferences::Wheel

  # このメソッドが、渡されてくる配列の構造に関する知識を全て隔離している
  # つまり渡されてくるデータが変われば、こことStructのみを変更すれば対応出来る。
  def wheelify(data)
    data.collect { |cell| Wheel.new(cell[0], cell[1]) }
  end
end

revealing_references = RevealingReferences.new([[22, 33], [44, 55]])
p revealing_references.diameters # [88, 154]