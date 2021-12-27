import Foundation;

private func Count(_ s: String.SubSequence) -> (Int, Int) {
  var bytes = -2  // for the first and last "
  var i = s.startIndex
  while i != s.endIndex {
    if s[i] == "\\" {
      i = s.index(i, offsetBy:1)
      if s[i] == "x" {
        i = s.index(i, offsetBy:3)
      } else {
        i = s.index(i, offsetBy:1)
      }
    } else {
      i = s.index(i, offsetBy:1)
    }
    bytes += 1
  }
  return (s.count, bytes);
}

struct Day8 {
static func part1(_ lines:[String.SubSequence]) -> Int {
  var res = 0
  for l in lines {
    let (chars, bytes) = Count(l)
    res += chars - bytes
  }
  return res
}

static func part2(_ lines:[String.SubSequence]) -> Int {
  return 0;
}

static func main() throws {
  let lines = try String(contentsOfFile:"input/day8.txt").split(separator:"\n")

  print("Day 8 part 1:", part1(lines));
  print("Day 8 part 2:", part2(lines));
}
}
