require File.expand_path("./lib/ombre")
TEXT = (("#" * 100) + "\n") * 30

max_x = TEXT.lines.map(&:size).max
max_y = TEXT.lines.size

puts max_x, max_y


def distance(x1, y1, x2, y2)
  Math.sqrt(((x2 - x1) ** 2.0 + (y2 - y1) ** 2.0))
end

POINTS = 3

points = POINTS.times.map do
  # init x, init y, v x, v y]
  [rand(max_x).to_f, rand(max_y).to_f, rand() * 10.0, rand() * 5.0]
end

max_distance = ((max_x.to_f ** 2 + max_y.to_f ** 2) ** 0.5)

while true do
  puts "\e[H\e[2J"
  puts(Ombre.by_block(TEXT, ["#000000", "#00ff00"]) do |_, _, x, y|
    points.map do |(px, py, _, _)|
      1.0 - (Math.sin((distance(x, y, px, py) / max_distance) * (Math::PI / 2.0)) ** 0.4)
      # distance(px, py, x, y) < 3.0 ? 0.0 : 1.0
    end.max
  end)

  points.each do |point|
    point[0] += point[2]
    point[1] += point[3]

    point[2] *= -1 if point[0] > max_x || point[0].negative?
    point[3] *= -1 if point[1] > max_y || point[1].negative?
  end

  sleep 0.4
end
