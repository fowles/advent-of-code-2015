import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

private func MD5(_ string: String) -> String {
  let length = Int(CC_MD5_DIGEST_LENGTH)
  let messageData = string.data(using:.utf8)!
  var digestData = Data(count: length)

  _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
    messageData.withUnsafeBytes { messageBytes -> UInt8 in
      if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
        let messageLength = CC_LONG(messageData.count)
          CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
      }
      return 0
    }
  }
  return digestData.map { String(format: "%02hhx", $0) }.joined()
}

struct Day4 {
static func part1(_ raw:String) -> Int {
  for i in 1... {
    let hex = MD5(raw + String(i));
    if hex.starts(with:"00000") {
      return i
    }
  }
  return 0;
}

static func part2(_ raw:String) -> Int {
  for i in 346387... {
    let hex = MD5(raw + String(i));
    if hex.starts(with:"000000") {
      return i
    }
  }
  return 0;
}

static func main() throws {
  print("Day 4 part 1:", part1("iwrupvqb"));
  print("Day 4 part 2:", part2("iwrupvqb"));
}
}
