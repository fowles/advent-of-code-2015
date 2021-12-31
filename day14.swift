import Foundation;

private func DistanceTraveled(deer: (Int, Int, Int), elapsed: Int) -> Int {
    let (speed, time, rest) = deer
    let cycles = elapsed/(time + rest)
    let remainder = elapsed%(time + rest)
    return speed * time * cycles + speed * min(remainder, time)
}

struct Day14 {
static func part1(_ raw:[(Int, Int, Int)]) -> Int {
  return raw.map { DistanceTraveled(deer:$0, elapsed:2503) }.max()!
}

static func part2(_ raw:[(Int, Int, Int)]) -> Int {
  var score = Array(repeating:0, count:raw.count)
  for i in 1...2503 {
    let dist = raw.map { DistanceTraveled(deer:$0, elapsed:i) }
    let m = dist.max()!
    for (index, value) in dist.enumerated() {
      if (value == m) {
        score[index] += 1
      }
    }
  }
  return score.max()!
}

static func main() throws {
  let raw: [(Int, Int, Int)] = try String(contentsOfFile:"input/day14.txt").split(separator:"\n").map {
    let parts = $0.extract(regex:#"fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds."#)!
    return (Int(parts[0])!, Int(parts[1])!, Int(parts[2])!)
  }

  print("Day 14 part 1:", part1(raw));
  print("Day 14 part 2:", part2(raw));
}
}
