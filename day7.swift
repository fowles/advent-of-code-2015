import Foundation;

struct Day7 {
enum Input {
  case Val(UInt16)
  case Wire(String.SubSequence)
  case And(String.SubSequence, String.SubSequence)
  case Or(String.SubSequence, String.SubSequence)
  case LShift(String.SubSequence, UInt16)
  case RShift(String.SubSequence, UInt16)
  case Not(String.SubSequence)
}

static private func eval(_ val: String.SubSequence,
                         with wires: inout [String.SubSequence: Input]) -> UInt16 {
  if let v = UInt16(val) {
    return v
  }
  let r: UInt16
  switch wires[val]! {
    case let .Val(v): return v
    case let .Wire(lhs): r = eval(lhs, with:&wires)
    case let .And(lhs, rhs): r = eval(lhs, with:&wires) & eval(rhs, with:&wires)
    case let .Or(lhs, rhs): r = eval(lhs, with:&wires) | eval(rhs, with:&wires)
    case let .LShift(lhs, v): r = eval(lhs, with:&wires) << v
    case let .RShift(lhs, v): r = eval(lhs, with:&wires) >> v
    case let .Not(lhs): r = ~eval(lhs, with:&wires)
  }
  wires[val] = Input.Val(r)
  return r
}

static func part1(_ wires:[(Input, String.SubSequence)]) -> Int {
  var ctxt = [String.SubSequence:Input]()
  for (input, wire) in wires {
    ctxt[wire] = input
  }
  return Int(eval("a", with:&ctxt))
}

static func part2(_ wires:[(Input, String.SubSequence)]) -> Int {
  var ctxt = [String.SubSequence:Input]()
  for (input, wire) in wires {
    ctxt[wire] = input
  }
  var ctxt2 = ctxt
  ctxt2["b"] = Input.Val(eval("a", with:&ctxt))
  return Int(eval("a", with:&ctxt2))
}

static func main() throws {
  let wires : [(Input, String.SubSequence)]
      = try! String(contentsOfFile:"input/day7.txt").split(separator:"\n").map {
    let out = $0.extract(regex:#"-> (\w+)"#)![0]
    if let v = $0.extract(regex:#"^(\d+) ->"#) {
      return (Input.Val(UInt16(v[0])!), out)
    }
    if let v = $0.extract(regex:#"^(\w+) ->"#) {
      return (Input.Wire(v[0]), out)
    }
    if let and = $0.extract(regex:#"(\w+) AND (\w+)"#) {
      return (Input.And(and[0], and[1]), out)
    }
    if let or = $0.extract(regex:#"(\w+) OR (\w+)"#) {
      return (Input.Or(or[0], or[1]), out)
    }
    if let lshift = $0.extract(regex:#"(\w+) LSHIFT (\d+)"#) {
      return (Input.LShift(lshift[0], UInt16(lshift[1])!), out)
    }
    if let rshift = $0.extract(regex:#"(\w+) RSHIFT (\d+)"#) {
      return (Input.RShift(rshift[0], UInt16(rshift[1])!), out)
    }
    if let not = $0.extract(regex:#"NOT (\w+)"#) {
      return (Input.Not(not[0]), out)
    }
    throw "Parse error: " + $0
  }

  print("Day 7 part 1:", part1(wires));
  print("Day 7 part 2:", part2(wires));
}
}
