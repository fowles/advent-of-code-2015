import Foundation;

struct Day6 {
enum Command {
  case On
  case Off
  case Toggle
}

struct Lights {
  var v = Array(repeating:Array(repeating:false, count:1000), count:1000);
}

static func part1(_ commands:[(Command, [Int])]) -> Int {
  var lights = Lights()
  for (cmd, coords) in commands {
    for i in coords[0]...coords[2] {
      for j in coords[1]...coords[3] {
        switch cmd {
          case .On: lights.v[i][j] = true
          case .Off: lights.v[i][j] = false
          case .Toggle: lights.v[i][j] = !lights.v[i][j]
        }
      }
    }
  }
  var sum = 0
  for row in lights.v {
    for bulb in row {
      if bulb {
        sum += 1
      }
    }
  }
  return sum
}

static func part2(_ commands:[(Command, [Int])]) -> Int {
  return 0;
}

static func main() throws {
  let lines = try String(contentsOfFile:"input/day6.txt").split(separator:"\n")
  let commands: [(Command, [Int])] = try lines.map {
    let cmd: Command;
    switch $0[6] {
      case "n": cmd = Command.On
      case "f": cmd = Command.Off
      default:  cmd = Command.Toggle
    }
    let coordinates = try $0.extract(regex:#"(\d+)"#).map({ Int($0)! })
    return (cmd, coordinates)
  }

  print("Day 6 part 1:", part1(commands));
  print("Day 6 part 2:", part2(commands));
}
}
