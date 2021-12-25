import Foundation;

func day1() throws {
  let raw = try String(contentsOfFile:"input/day1.txt")

  var lvl = 0;
  for c in raw {
    switch c {
      case "(": lvl += 1
      case ")": lvl -= 1
      default: break
    }
  }
  print("Day 1 part 1:", lvl);
}
