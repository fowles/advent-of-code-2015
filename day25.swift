import Foundation;

struct Day25 {
static func next(_ prev:Int) -> Int {
  return (prev * 252533) % 33554393
}

static func count(row:Int, col: Int) -> Int {
  var c = (1...col).reduce(0, +)
  for i in 1..<row {
    c += col + i - 1
  }
  return c
}
static func part1(row:Int, col: Int) -> Int {
  var code = 20151125
  for _ in 1..<count(row:row, col:col) {
    code = next(code)
  }
  return code
}

static func part2(_ raw:String) -> Int {
  return 0;
}

static func main() throws {
  let raw = try String(contentsOfFile:"input/day25.txt")
  print("Day 25 part 1:", part1(row:2981, col:3075));
  print("Day 25 part 2:", part2(raw));
}
}
