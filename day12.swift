import Foundation;

private func Count(_ a: Any) -> Int {
  var res = 0
  if let arr = a as? [Any] {
    for p in arr {
      res += Count(p)
    }
  }
  if let dict = a as? [String:Any] {
    for (_, v) in dict {
      switch v {
        case "red" as String:
          return 0
        default:
          res += Count(v)
      }
    }
  }
  if let v = a as? Int {
    res += v
  }
  return res
}

struct Day12 {
static func part1(_ raw:String) -> Int {
  var res = 0
  for d in Substring(raw).extract(regex:#"(-?\d+)"#)! {
    res += Int(d)!
  }
  return res;
}

static func part2(_ raw:String) -> Int {
  let json = try! JSONSerialization.jsonObject(
        with: raw.data(using:.utf8)!, options: [])
  return Count(json)
}

static func main() throws {
  let raw = try String(contentsOfFile:"input/day12.txt")

  print("Day 12 part 1:", part1(raw));
  print("Day 12 part 2:", part2(raw));
}
}
