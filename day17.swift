import Foundation;
import Algorithms

struct Day17 {
static func part1(_ raw:[Int]) -> Int {
  var res = 0
  for i in 1...raw.count {
    for c in raw.combinations(ofCount:i) {
      if c.reduce(0, +) == 150 {
        res += 1
      }
    }
  }
  return res
}

static func part2(_ raw:[Int]) -> Int {
  for i in 1...raw.count {
    var res = 0
    for c in raw.combinations(ofCount:i) {
      if c.reduce(0, +) == 150 {
        res += 1
      }
    }
    if res > 0 {
      return res
    }
  }
  return -1
}

static func main() throws {
  let raw = try String(contentsOfFile:"input/day17.txt")
      .split(separator:"\n").map {
    Int($0)!
  }

  print("Day 17 part 1:", part1(raw));
  print("Day 17 part 2:", part2(raw));
}
}
