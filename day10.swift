import Foundation;

private func grow(_ s:String) -> String {
  var r = String()
  r.reserveCapacity(Int(Double(s.count) * 1.3))
  var run : Character = s[s.startIndex]
  var count = 0
  for c in s {
    if c == run {
      count += 1
      continue
    }

    r.append(String(count))
    r.append(run)

    run = c
    count = 1
  }
  r.append(String(count))
  r.append(run)
  return r
}

struct Day10 {
static func part1(_ raw:String) -> Int {
  var m = raw
  for _ in 0..<40 {
    m = grow(m)
  }
  return m.count
}

static func part2(_ raw:String) -> Int {
  var m = raw
  for _ in 0..<50 {
    m = grow(m)
  }
  return m.count
}

static func main() throws {
  print("Day 10 part 1:", part1("1113222113"));
  print("Day 10 part 2:", part2("1113222113"));
}
}
