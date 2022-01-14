import Foundation;

struct Day23 {
enum Inst {
  case Hlf(Int)
  case Tpl(Int)
  case Inc(Int)
  case Jmp(Int)
  case Jie(Int, Int)
  case Jio(Int, Int)
}
// hlf r sets register r to half its current value, then continues with the
// next instruction.
// tpl r sets register r to triple its current value, then continues with the
// next instruction.
// inc r increments register r, adding 1 to it, then continues with the next
// instruction.
// jmp offset is a jump; it continues with the instruction offset away relative
// to itself.
// jie r, offset is like jmp, but only jumps if register r is even ("jump if
// even").
// jio r, offset is like jmp, but only jumps if register r is 1 ("jump if one",
// not odd).

static func eval(_ raw:[Inst], registers r: inout [Int]) {
  var pc = 0
  while pc < raw.count {
    switch raw[pc] {
      case .Hlf(let i): r[i] /= 2
      case .Tpl(let i): r[i] *= 3
      case .Inc(let i): r[i] += 1
      case .Jmp(let off): 
        pc += off
        continue
      case .Jie(let i, let off): 
        if r[i] % 2 == 0 {
          pc += off
          continue
        }
      case .Jio(let i, let off): 
        if r[i] == 1 {
          pc += off
          continue
        }
    }
    pc += 1
  }
}

static func part1(_ raw:[Inst]) -> Int {
  var r = [0, 0]
  eval(raw, registers:&r)
  return r[1]
}

static func part2(_ raw:[Inst]) -> Int {
  var r = [1, 0]
  eval(raw, registers:&r)
  return r[1]
}

static func main() throws {
  let raw: [Inst] = try String(contentsOfFile:"input/day23.txt")
      .split(separator:"\n").map {
    let parts = $0.split(separator:" ")
    switch parts[0] {
      case "hlf": return Inst.Hlf(parts[1] == "a" ? 0 : 1)
      case "tpl": return Inst.Tpl(parts[1] == "a" ? 0 : 1)
      case "inc": return Inst.Inc(parts[1] == "a" ? 0 : 1)
      case "jmp": return Inst.Jmp(Int(parts[1])!)
      case "jie": return Inst.Jie(parts[1] == "a," ? 0 : 1, Int(parts[2])!)
      case "jio": return Inst.Jio(parts[1] == "a," ? 0 : 1, Int(parts[2])!)
      default: throw "Parse error: " + $0
    }
  }

  print("Day 23 part 1:", part1(raw));
  print("Day 23 part 2:", part2(raw));
}
}
