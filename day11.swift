import Foundation;

// Passwords may not contain the letters i, o, or l, as these letters can be
// mistaken for other characters and are therefore confusing.
private func increment(_ raw: String) -> String {
  var next = Array(raw)
  for i in next.indices.reversed() {
    var n = next[i].asciiValue!
    switch n {
      case UInt8(ascii:"i") - 1: n += 2
      case UInt8(ascii:"o") - 1: n += 2
      case UInt8(ascii:"l") - 1: n += 2
      case UInt8(ascii:"z"):     n = UInt8(ascii:"a")
      default:                   n += 1
    }
    next[i] = Character(UnicodeScalar(n))
    if (n != UInt8(ascii:"a")) {
      break;
    }
  }

  return String(next)
}

// Passwords must contain at least two different, non-overlapping pairs of
// letters, like aa, bb, or zz.
private func hasTwoPair(_ s: String.SubSequence) -> Bool {
  var first: Int? = nil
  for i in 0..<s.count - 1 {
    if s[i] == s[i+1] {
      if first == nil {
        first = i
        continue
      }
      if first! == i-1 {
        continue
      }
      return true
    }
  }
  return false
}

// Passwords must include one increasing straight of at least three letters,
// like abc, bcd, cde, and so on, up to xyz. They cannot skip letters; abd
// doesn't count.
private func hasTriple(_ s: String.SubSequence) -> Bool {
  for i in 0..<s.count - 2 {
    if s[i].asciiValue! == s[i+1].asciiValue! - 1 &&
       s[i].asciiValue! == s[i+2].asciiValue! - 2 {
      return true
    }
  }
  return false
}

struct Day11 {
static func part1(_ raw:String) -> String {
  var next = raw
  while true {
    next = increment(next)
    if hasTwoPair(Substring(next)) && hasTriple(Substring(next)) {
      return next
    }
  }
}

static func main() throws {
  print("Day 11 part 1:", part1("cqjxjnds"));
  print("Day 11 part 2:", part1("cqjxxyzz"));
}
}
