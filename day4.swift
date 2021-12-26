import Foundation
import CryptoKit

private func MD5(of s: String, preceeds: [uint8] ) -> Int {
  var buf = s
  buf.append(String(Int.max))

  for i in 1... {
    buf.removeAll(keepingCapacity:true)
    buf.append(s)
    buf.append(String(i))
    let computed = buf.data(using:.utf8)!.withUnsafeBytes { 
      return Insecure.MD5.hash(data:$0)
    }
    if (computed.lexicographicallyPrecedes(preceeds)) {
      return i
    }
  }
  return -1;
}

struct Day4 {
static func part1(_ raw:String) -> Int {
  return MD5(of: raw, preceeds:[0x00, 0x00, 0x0F])
}

static func part2(_ raw:String) -> Int {
  return MD5(of: raw, preceeds:[0x00, 0x00, 0x00, 0xFF])
}

static func main() throws {
  print("Day 4 part 1:", part1("iwrupvqb"));
  print("Day 4 part 2:", part2("iwrupvqb"));
}
}
