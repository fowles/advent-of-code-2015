import Foundation;

struct Day15 {
struct Ingredient {
  var capacity: Int = 0
  var durability: Int = 0
  var flavor: Int = 0
  var texture: Int = 0
  var calories: Int = 0
};

static private func mix(_ parts: [Int], _ ingredients:[Ingredient]) -> Ingredient {
  var total = Ingredient()
  for i in 0..<parts.count {
    total.capacity += parts[i] * ingredients[i].capacity
    total.durability += parts[i] * ingredients[i].durability
    total.flavor += parts[i] * ingredients[i].flavor
    total.texture += parts[i] * ingredients[i].texture
    total.calories += parts[i] * ingredients[i].calories
  }
  total.capacity = max(total.capacity, 0)
  total.durability = max(total.durability, 0)
  total.flavor = max(total.flavor, 0)
  total.texture = max(total.texture, 0)
  total.calories = max(total.calories, 0)
  return total;
}

static private func score(_ m: Ingredient) -> Int {
  return m.capacity * m.durability * m.flavor * m.texture;
}

static func TestMix(_ parts: inout [Int], depth: Int, remainder: Int,
                    test: (_ parts: [Int]) -> Void) {
  if remainder == 0 || depth == parts.count {
    test(parts);
    return;
  }
  for i in 0...remainder {
    parts[depth] = i
    TestMix(&parts, depth: depth + 1,
            remainder: remainder - i, test:test)
  }
  parts[depth] = 0
}

static func part1(_ ingredients:[Ingredient]) -> Int {
  var parts = Array(repeating:0, count:ingredients.count)
  var best = 0
  TestMix(&parts, depth: 0, remainder: 100) {
    let m = mix($0, ingredients)
    let s = score(m)
    best = max(best, s)
  }
  return best
}

static func part2(_ ingredients:[Ingredient]) -> Int {
  return 0;
}

static func main() throws {
  let raw: [Ingredient] = try String(contentsOfFile:"input/day15.txt").split(separator:"\n").map {
    let parts = $0.extract(regex:#"capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)"#)!
    return Ingredient(capacity:Int(parts[0])!, durability:Int(parts[1])!,
                      flavor:Int(parts[2])!, texture:Int(parts[3])!,
                      calories:Int(parts[4])!)
  }

  print("Day 15 part 1:", part1(raw));
  print("Day 15 part 2:", part2(raw));
}
}
