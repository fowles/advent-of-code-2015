import Foundation;

struct Day9 {
struct Path: Comparable {
  var current: String.SubSequence;
  var visited: Set<String.SubSequence>;
  var distance: Int

  init(_ c: String.SubSequence, _ v: Set<String.SubSequence>, _ d: Int) {
    current = c
    visited = v
    visited.insert(c)
    distance = d
  }

  func expand(_ graph: [String.SubSequence:[(String.SubSequence, Int)]]) -> [Path] {
    var res = [Path]()
    for (dest, cost) in graph[current]! {
      if !visited.contains(dest) {
        res.append(Path(dest, visited, distance + cost))
      }
    }
    return res
  }

  static func < (lhs: Path, rhs: Path) -> Bool {
    if (lhs.distance == rhs.distance) {
      return lhs.visited.count > rhs.visited.count;
    }
    return lhs.distance < rhs.distance;
  }

  static func == (lhs: Path, rhs: Path) -> Bool {
    return lhs.distance == rhs.distance
        && lhs.current == rhs.current
        && lhs.visited == rhs.visited;
  }
}



static func part1(_ graph:[String.SubSequence:[(String.SubSequence, Int)]]) -> Int {
  var toExpand = [Path]()
  for k in graph.keys {
    toExpand.append(Path(k, [], 0))
  }
  var res = Int.max
  while let next = toExpand.popLast() {
    if (next.visited.count == graph.count) {
      res = min(res, next.distance)
    }
    toExpand.append(contentsOf:next.expand(graph))
  }
  return res
}

static func part2(_ routes:[(String.SubSequence, String.SubSequence, Int)]) -> Int {
  return 0;
}

static func main() throws {
  let routes: [(String.SubSequence, String.SubSequence, Int)] = try String(contentsOfFile:"input/day9.txt")
        .split(separator:"\n").map {
     let parts = $0.extract(regex:#"(\w+) to (\w+) = (\d+)"#)!;
     return (parts[0], parts[1], Int(parts[2])!)
  }

  var graph = [String.SubSequence:[(String.SubSequence, Int)]]()
  for (orig, dest, distance) in routes {
    graph[orig, default:[]].append((dest, distance))
    graph[dest, default:[]].append((orig, distance))
  }
  print("Day 9 part 1:", part1(graph));
  print("Day 9 part 2:", part2(routes));
}
}
