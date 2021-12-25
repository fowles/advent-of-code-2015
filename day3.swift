import Foundation;

struct Day3 {

struct Point: Hashable {
    var x: Int;
    var y: Int;

    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

static func part1(_ raw:String) -> Int {
  var visited: Set<Point> = []
  var pos = Point(x:0, y:0)
  visited.insert(pos)
  for c in raw {
      switch c {
          case "^": pos.y += 1
          case "v": pos.y -= 1
          case "<": pos.x -= 1
          case ">": pos.x += 1
          default: ()
      }
      visited.insert(pos)

  }
  return visited.count
}

static func part2(_ raw:String) -> Int {
  return 0;
}

static func main() throws {
  let raw = try String(contentsOfFile:"input/day3.txt")

  print("Day 3 part 1:", part1(raw));
  print("Day 3 part 2:", part2(raw));
}
}
