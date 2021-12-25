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

static func part2(_ raw:String) -> Int {
  return 0;
}

static func main() throws {
  let raw = try String(contentsOfFile:"input/day2.txt")
  let lines = try raw.split(separator:"\n").map {
     try $0.extract(regex:#"(\d+)"#).map({ Int($0)! })
  }

  print("Day 2 part 1:", part1(lines.map { $0.splat() }))
  print("Day 2 part 2:", part2(raw))
}
}
