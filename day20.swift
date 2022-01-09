import Foundation;

struct Day20 {
static func part1(_ target:Int) -> Int {
  for i in 831600...target {
    var sum = 0
    for j in 1...Int(Double(i).squareRoot()) {
      let k = i / j
      if k * j == i {
        sum += j + k
      }
    }
    if sum >= target {
      return i
    }
  }
  return 0;
}

static func part2(_ target:Int) -> Int {
  for i in 831600...target {
    var sum = 0
    for j in 1...Int(Double(i).squareRoot()) {
      let k = i / j
      if k * j == i {
        if k <= 50 {
          sum += 11 * j
        }
        if j <= 50 {
          sum += 11 * k
        }
      }
    }
    if sum >= target {
      return i
    }
  }
  return 0;
}

static func main() throws {
  print("Day 20 part 1:", part1(3600000));
  print("Day 20 part 2:", part2(36000000));
}
}
