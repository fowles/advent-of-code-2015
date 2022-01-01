import Foundation;

struct Day18 {
class Lights {
  public var bulbs = Array(repeating:false, count:100*100)

  func lightCorners() {
    self[0, 0] = true
    self[0, 99] = true
    self[99, 0] = true
    self[99, 99] = true
  }

  subscript(_ x: Int, _ y: Int) -> Bool {
    get {
      return bulbs[100 * y + x]
    }
    set(v) {
      bulbs[100 * y + x] = v
    }
  }

  func Adjacent(_ x: Int, _ y: Int, block: (_ bulb: Bool) -> Void) {
    for j in -1...1 {
      let ny = y + j
      if !(0 <= ny && ny < 100) {
        continue
      }
      for i in -1...1 {
        let nx = x + i
        if !(0 <= nx && nx < 100) {
          continue
        }
        if nx == x && ny == y {
          continue
        }

        block(self[nx, ny])
      }
    }
  }

  func Step() -> Lights {
    let res = Lights()
    for j in 0..<100 {
      for i in 0..<100 {
        var count = 0
        Adjacent(i, j) {
          if ($0) {
            count += 1
          }
        }
        switch count {
          case 2:
            if self[i, j] {
              res[i, j] = true
            }
          case 3:
            res[i, j] = true
          default: ()
        }
      }
    }
    return res
  }
}

static func part1(_ orig:Lights) -> Int {
  var lights = orig
  for _ in 0..<100 {
    lights = lights.Step()
  }

  var res = 0
  for j in 0..<100 {
    for i in 0..<100 {
      res += lights[i, j] ? 1 : 0
    }
  }
  return res
}

static func part2(_ orig:Lights) -> Int {
  var lights = orig
  lights.lightCorners()
  for _ in 0..<100 {
    lights = lights.Step()
    lights.lightCorners()
  }

  var res = 0
  for j in 0..<100 {
    for i in 0..<100 {
      res += lights[i, j] ? 1 : 0
    }
  }
  return res
}

static func main() throws {
  let raw = try String(contentsOfFile:"input/day18.txt").split(separator:"\n")
  let lights = Lights()
  for (j, line) in raw.enumerated() {
    for (i, pos) in line.enumerated() {
      lights[i, j] = pos == "#"
    }
  }

  print("Day 18 part 1:", part1(lights));
  print("Day 18 part 2:", part2(lights));
}
}
