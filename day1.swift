import Foundation;

struct Day1 {
static func part1(_ raw:String) -> Int {
  var lvl = 0;
  for c in raw {
    switch c {
      case "(": lvl += 1
      case ")": lvl -= 1
      default: break
    }
  }
  return lvl
}

static func part2(_ raw:String) -> Int {
  var lvl = 0;
  for (i, c) in raw.enumerated() {
    switch c {
      case "(": lvl += 1
      case ")": lvl -= 1
      default: break
    }
    if lvl < 0 {
      return i + 1
    }
  }
  return -1
}

static func main() throws {
  let raw = try String(contentsOfFile:"input/day1.txt")

  print("Day 1 part 1:", part1(raw));
  print("Day 1 part 2:", part2(raw));
}
}
