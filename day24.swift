import Foundation;

struct Day24 {

static func split(target: Int, groups: Int, from:[Int], without:[Int]) -> Int {
  if groups == 1 {
    return target  // not actually entanglement, but doesn't matter
  }

  var v = from
  v.removeAll { without.contains($0) }
  for c in 0...v.count {
    for p in v.combinations(ofCount:c) {
      if p.reduce(0, +) != target {
        continue
      }
      if split(target:target, groups:groups - 1, from:v, without:p) != 0 {
        return p.reduce(1, *)
      }
    }
  }
  return 0
}


static func part1(_ raw:[Int]) -> Int {
  let target = raw.reduce(0, +)/3
  return split(target:target, groups:3, from:raw, without:[])
}

static func part2(_ raw:[Int]) -> Int {
  let target = raw.reduce(0, +)/4
  return split(target:target, groups:4, from:raw, without:[])
}

static func main() throws {
  let raw = try String(contentsOfFile:"input/day24.txt").split(separator:"\n").map {
    Int($0)!
  }

  print("Day 24 part 1:", part1(raw));
  print("Day 24 part 2:", part2(raw));
}
}
