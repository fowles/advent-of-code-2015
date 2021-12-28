import Foundation
import Darwin

extension Array {
  func splat() -> (Element,Element) {
    return (self[0],self[1])
  }

  func splat() -> (Element,Element,Element) {
    return (self[0],self[1],self[2])
  }

  func splat() -> (Element,Element,Element,Element) {
    return (self[0],self[1],self[2],self[3])
  }

  func splat() -> (Element,Element,Element,Element,Element) {
    return (self[0],self[1],self[2],self[3],self[4])
  }
}

extension String: Error {}

public extension String.SubSequence {
  func extract(regex: String) -> [String.SubSequence]? {
    let r = try! NSRegularExpression(pattern: regex, options: [])
    let matches = r.matches(in:String(self), options:[], range:NSMakeRange(0, self.count))
    if matches.count == 0 {
      return nil
    }

    var res: [String.SubSequence] = []
    for m in matches {
      for i in 1..<m.numberOfRanges {
        if let range = Range(m.range(at:i), in:self) {
          res.append(self[range])
        }
      }
    }
    return res;
  }

  var length: Int {
    return count
  }

  func substring(fromIndex: Int) -> String.SubSequence {
    return self[Swift.min(fromIndex, count) ..< length]
  }

  func substring(toIndex: Int) -> String.SubSequence {
    return self[0 ..< Swift.max(0, toIndex)]
  }

  subscript (i: Int) -> Character {
    return self[index(startIndex, offsetBy:Swift.min(i, length))]
  }

  subscript (r: Range<Int>) -> String.SubSequence {
    let range = Range(uncheckedBounds:
                      (lower: Swift.max(0, Swift.min(length, r.lowerBound)),
                       upper: Swift.min(length, Swift.max(0, r.upperBound))))
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(start, offsetBy: range.upperBound - range.lowerBound)
    return self[start ..< end]
  }
}

do {
  chdir(getenv("BUILD_WORKING_DIRECTORY"))
  try Day13.main()
} catch {
  print("Error: \(error).")
}
