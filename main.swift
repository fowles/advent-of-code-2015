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

public extension String.SubSequence {
  func extract(regex: String) throws -> [String.SubSequence] {
    let r = try NSRegularExpression(pattern: regex, options: [])
    let matches = r.matches(in:String(self), options:[], range:NSMakeRange(0, self.count))

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
}

do {
  chdir(getenv("BUILD_WORKING_DIRECTORY"))
  try Day4.main()
} catch {
  print("Error: \(error).")
}
