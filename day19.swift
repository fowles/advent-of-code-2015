import Foundation;

struct Day19 {
static private func Expand(_ m: String, _ rules: [String:[String]],
                           _ block: (String) -> Void) {
  for (key, replacements) in rules {
    let start = m.startIndex
    let end = m.endIndex
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

static func part1(_ medicine: String, _ replacements: [String:[String]]) -> Int {
  var unique = Set<String>()
  Expand(medicine, replacements) {
    unique.insert($0)
  }
  return unique.count
}

static func part2(_ medicine: String, _ replacements: [String:[String]]) -> Int {
  return 0;
}

static func main() throws {
  let raw = try String(contentsOfFile:"input/day19.txt").components(separatedBy:"\n\n")
  let medicine = raw[1]
  var replacements = [String:[String]]()
  for rule in raw[0].split(separator:"\n") {
    let c = rule.components(separatedBy:" => ")
    replacements[c[0], default:[]].append(c[1])
  }

  print("Day 19 part 1:", part1(medicine, replacements));
  print("Day 19 part 2:", part2(medicine, replacements));
}
}
