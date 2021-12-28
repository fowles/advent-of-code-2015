import Foundation
import Algorithms

struct Day13 {
struct Pair: Hashable {
    var lhs: Substring;
    var rhs: Substring;

    init(_ l: Substring, _ r: Substring) {
      if l < r {
        lhs = l
        rhs = r
      } else {
        lhs = r
        rhs = l
      }
    }

    static func == (l: Pair, r: Pair) -> Bool {
        return l.lhs == r.lhs && l.rhs == r.rhs
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(lhs)
        hasher.combine(rhs)
    }
}
static func part1(_ people: [Substring], _ points: [Pair:Int]) -> Int {
  var maxHappy = 0
  for seating in people.permutations() {
    var happy = points[Pair(seating.first!, seating.last!)]!
    for (lhs, rhs) in seating.adjacentPairs() {
      happy += points[Pair(lhs, rhs)]!
    }
    maxHappy = max(happy, maxHappy)
  }
  return maxHappy;
}

static func part2(_ others: [Substring], _ points: [Pair:Int]) -> Int {
  var people = others
  people.append("Me")

  var maxHappy = 0
  for seating in people.permutations() {
    var happy = points[Pair(seating.first!, seating.last!), default:0]
    for (lhs, rhs) in seating.adjacentPairs() {
      happy += points[Pair(lhs, rhs), default:0]
    }
    maxHappy = max(happy, maxHappy)
  }
  return maxHappy;
}

static func main() throws {
  let raw: [(Pair, Int)] = try String(contentsOfFile:"input/day13.txt").split(separator:"\n").map {
    let parts = $0.extract(regex:#"(\w+) would (gain|lose) (\d+).*to (\w+)"#)!
    var happiness = Int(parts[2])!
    if parts[1] == "lose" {
      happiness *= -1
    }
    return (Pair(parts[0], parts[3]), happiness)
  }
  var unique = Set<Substring>()
  var points = [Pair:Int]()
  for (k, v) in raw {
    points[k, default:0] += v
    unique.insert(k.lhs)
    unique.insert(k.rhs)
  }
  let people = Array(unique).sorted()

  print("Day 13 part 1:", part1(people, points));
  print("Day 13 part 2:", part2(people, points));
}
}
