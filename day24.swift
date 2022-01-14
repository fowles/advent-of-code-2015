import Foundation;

struct Day24 {

static func canSplit(target: Int, orig:[Int], used:[Int]) -> Bool {
  var v = orig
  v.removeAll { used.contains($0) }
  for c in 5...v.count-5 {
    for p in v.combinations(ofCount:c) {
      if p.reduce(0, +) != target {
        continue
      }
      return true
    }
  }
  return false
}


static func part1(_ raw:[Int]) -> Int {
  let target = raw.reduce(0, +)/3
  for c in 5...raw.count-5 {
    for p in raw.combinations(ofCount:c) {
      if p.reduce(0, +) != target {
        continue
      }
      if canSplit(target:target, orig:raw, used:p) {
        return p.reduce(1, *)
      }
    }
  }
  return 0
}

static func part2(_ raw:[Int]) -> Int {
  return 0;
}

static func main() throws {
  let raw = try String(contentsOfFile:"input/day24.txt").split(separator:"\n").map {
    Int($0)!
  }

  print("Day 24 part 1:", part1(raw));
  print("Day 24 part 2:", part2(raw));
}
}
