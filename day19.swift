import Foundation;

struct Reduction: Comparable {
  var medicine: String
  var steps: Int

  static func == (lhs: Reduction, rhs: Reduction) -> Bool {
    return lhs.steps == rhs.steps && lhs.medicine == rhs.medicine
  }
  static func < (lhs: Reduction, rhs: Reduction) -> Bool {
    if (lhs.medicine.count < rhs.medicine.count) {
      return true
    }
    if (lhs.steps < rhs.steps) {
      return true
    }
    return lhs.medicine < rhs.medicine
  }
}

struct Day19 {
static private func Expand(_ m: String, _ rules: [String:[String]],
                           _ block: (String) -> Void) {
  let start = m.startIndex
  let end = m.endIndex
  for (key, replacements) in rules {
    var pos = start
    while true {
      if let r = m.range(of:key, options:[], range:pos..<end) {
        for replacement in replacements {
          var temp = m
          temp.replaceSubrange(r, with:replacement)
          block(temp)
        }
        pos = m.index(r.lowerBound, offsetBy:1)
      } else {
        break
      }
    }
  }
}

static private func Reduce(_ m: String, _ rules: [String:[String]],
                           _ block: (String) -> Void) {
  let start = m.startIndex
  let end = m.endIndex
  for (key, replacements) in rules {
    for replacement in replacements {
      var pos = start
      while true {
        if let r = m.range(of:replacement, options:[], range:pos..<end) {
          var temp = m
          temp.replaceSubrange(r, with:key)
          block(temp)
          pos = m.index(r.lowerBound, offsetBy:1)
        } else {
          break
        }
      }
    }
  }
}

static func part1(_ medicine: String, _ replacements: [String:[String]]) -> Int {
  var unique = Set<String>()
  Expand(medicine, replacements) {
    unique.insert($0)
  }
  return unique.count
}

static func part2(_ medicine: String, _ replacements: [String:[String]]) -> Int {
  var states = PriorityQueue(startingValues:[Reduction(medicine:medicine, steps:0)])
  var unique = Set<String>([medicine])
  while let s = states.pop() {
    var found = false
    Reduce(s.medicine, replacements) {
      if unique.insert($0).inserted {
        if $0 == "e" {
          found = true
          return
        }
        states.push(Reduction(medicine:$0, steps:s.steps+1))
      }
    }
    if found {
      return s.steps + 1
    }
  }
  return 0
}

static func main() throws {
  let raw = try String(contentsOfFile:"input/day19.txt").components(separatedBy:"\n\n")
  let medicine = raw[1].replacingOccurrences(of:#"\s"#, with:"", options:.regularExpression)
  var replacements = [String:[String]]()
  for rule in raw[0].split(separator:"\n") {
    let c = rule.components(separatedBy:" => ")
    replacements[c[0], default:[]].append(c[1])
  }
  print("Day 19 part 1:", part1(medicine, replacements));
  print("Day 19 part 2:", part2(medicine, replacements));
}
}
