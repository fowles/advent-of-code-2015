import Foundation;

struct Day2 {
static func part1(_ dims:[(Int, Int, Int)]) -> Int {
  var res = 0
  for (h, w, l) in dims {
      res += 2*l*w + 2*w*h + 2*h*l
      res += min(l*w, w*h, h*l)
  }
  return res
}

static func part2(_ dims:[(Int, Int, Int)]) -> Int {
  var res = 0
  for (h, w, l) in dims {
      res += h*w*l
      res += min(2*(l+w), 2*(w+h), 2*(h+l))
  }
  return res
}

static func main() throws {
  let raw = try String(contentsOfFile:"input/day2.txt")
  let lines: [(Int, Int, Int)] = raw.split(separator:"\n").map {
     $0.extract(regex:#"(\d+)"#)!.map({ Int($0)! }).splat()
  }

  print("Day 2 part 1:", part1(lines))
  print("Day 2 part 2:", part2(lines))
}
}
