import Foundation;

private func Decode(_ s: String.SubSequence) -> (Int, Int) {
  var bytes = -2  // for the first and last "
  var i = 0
  while i < s.count {
    if s[i] == "\\" {
      i += 1
      if s[i] == "x" {
        i += 3
      } else {
        i += 1
      }
    } else {
      i += 1
    }
    bytes += 1
  }
  return (s.count, bytes);
}

private func Encode(_ s: String.SubSequence) -> (Int, Int) {
  var chars = 2  // for the first and last "
  for c in s {
    switch c {
      case "\"": chars += 2;
      case "\\": chars += 2;
      default: chars += 1
    }
  }
  return (chars, s.count);
}

struct Day8 {
static func part1(_ lines:[String.SubSequence]) -> Int {
  var res = 0
  for l in lines {
    let (chars, bytes) = Decode(l)
    res += chars - bytes
  }
  return res
}

static func part2(_ lines:[String.SubSequence]) -> Int {
  var res = 0
  for l in lines {
    let (encoded, chars) = Encode(l)
    res += encoded - chars
  }
  return res
}

static func main() throws {
  let lines = try String(contentsOfFile:"input/day8.txt").split(separator:"\n")

  print("Day 8 part 1:", part1(lines));
  print("Day 8 part 2:", part2(lines));
}
}
