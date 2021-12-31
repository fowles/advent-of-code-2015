import Foundation;

struct Day16 {
static func part1(_ goal: [Substring:Int], _ candidates:[[Substring:Int]]) -> Int {
  NEXT: for (i, c) in candidates.enumerated() {
    for (k, v) in c {
      if goal[k]! != v {
        continue NEXT
      }
    }
    return i + 1
  }
  return -1;
}

static func part2(_ goal: [Substring:Int], _ candidates:[[Substring:Int]]) -> Int {
  NEXT: for (i, c) in candidates.enumerated() {
    for (k, v) in c {
      switch k {
        case "cats", "trees":
          if goal[k]! >= v {
            continue NEXT
          }
        case "pomeranians", "goldfish":
          if goal[k]! <= v {
            continue NEXT
          }

        default:
          if goal[k]! != v {
            continue NEXT
          }
      }
    }
    return i + 1
  }
  return -1;
}

static func main() throws {
  let raw: [[Substring:Int]] = try String(contentsOfFile:"input/day16.txt")
        .split(separator:"\n").map {
    return Dictionary(uniqueKeysWithValues: $0.split(separator:",").map {
      let parts = $0.extract(regex:#"(\w+): (\d+)"#)!
      return (parts[0], Int(parts[1])!)
    })
  }
  let goal: [Substring:Int] = [
    "children": 3,
    "cats": 7,
    "samoyeds": 2,
    "pomeranians": 3,
    "akitas": 0,
    "vizslas": 0,
    "goldfish": 5,
    "trees": 3,
    "cars": 2,
    "perfumes": 1,
  ]

  print("Day 16 part 1:", part1(goal, raw));
  print("Day 16 part 2:", part2(goal, raw));
}
}
