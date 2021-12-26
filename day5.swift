import Foundation;

private func isNice(_ l:String.SubSequence) -> Bool {
  if (l.contains("ab") ||
      l.contains("cd") ||
      l.contains("pq") ||
      l.contains("xy")) {
    return false;
  }

  var dup = false
  var vowels = 0
  var last: Character = "."
  for c in l {
    if last == c {
      dup  = true
    }
    last = c

    switch c {
      case "a": vowels += 1
      case "e": vowels += 1
      case "i": vowels += 1
      case "o": vowels += 1
      case "u": vowels += 1
      default: ()
    }
  }
  return dup && vowels > 2;
}

private func isNicer(_ l:String.SubSequence) -> Bool {
  var dup = false
  for i in l.indices.dropLast(2) {
    let j = l.index(i, offsetBy:2)
    if l[i] == l[j] {
      dup = true;
      break;
    }
  }
  if !dup {
    return false
  }

  for i in l.indices.dropLast(2) {
    let j = l.index(i, offsetBy:2)
    let p = l[i..<j]
    let s = l[j...]
    if s.contains(p) {
      return true
    }
  }
  return false
}

struct Day5 {
static func part1(_ lines:[String.SubSequence]) -> Int {
  var nice = 0;
  for l in lines {
    if (isNice(l)) {
      nice += 1
    }
  }
  return nice;
}

static func part2(_ lines:[String.SubSequence]) -> Int {
  var nice = 0;
  for l in lines {
    if (isNicer(l)) {
      nice += 1
    }
  }
  return nice;
}

static func main() throws {
  let raw = try String(contentsOfFile:"input/day5.txt")
      .split(separator:"\n")

  print("Day 5 part 1:", part1(raw));
  print("Day 5 part 2:", part2(raw));
}
}
