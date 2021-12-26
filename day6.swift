import Foundation;

struct Day6 {
enum Command {
  case On
  case Off
  case Toggle
}

static func part1(_ commands:[(Command, [Int])]) -> Int {
  var lights = Array(repeating:Array(repeating:false, count:1000), count:1000);
  for (cmd, coords) in commands {
    for i in coords[0]...coords[2] {
      for j in coords[1]...coords[3] {
        switch cmd {
          case .On: lights[i][j] = true
          case .Off: lights[i][j] = false
          case .Toggle: lights[i][j] = !lights[i][j]
        }
      }
    }
  }
  var sum = 0
  for row in lights {
    for bulb in row {
      if bulb {
        sum += 1
      }
    }
  }
  return sum
}

static func part2(_ commands:[(Command, [Int])]) -> Int64 {
  var lights = Array(repeating:Array(repeating:Int64(0), count:1000), count:1000);
  for (cmd, coords) in commands {
    for i in coords[0]...coords[2] {
      for j in coords[1]...coords[3] {
        switch cmd {
          case .On: lights[i][j] += 1
          case .Off: lights[i][j] = max(0, lights[i][j] - 1)
          case .Toggle: lights[i][j] += 2
        }
      }
    }
  }
  var sum = Int64(0)
  for row in lights {
    for bulb in row {
      sum += bulb
    }
  }
  return sum
}

static func main() throws {
  let lines = try String(contentsOfFile:"input/day6.txt").split(separator:"\n")
  let commands: [(Command, [Int])] = lines.map {
    let cmd: Command;
    switch $0[6] {
      case "n": cmd = Command.On
      case "f": cmd = Command.Off
      default:  cmd = Command.Toggle
    }
    let coordinates = $0.extract(regex:#"(\d+)"#)!.map({ Int($0)! })
    return (cmd, coordinates)
  }

  print("Day 6 part 1:", part1(commands));
  print("Day 6 part 2:", part2(commands));
}
}
