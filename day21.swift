import Foundation;

struct Day21 {
struct Item {
  var cost: Int
  var dmg: Int
  var ac: Int
}

struct Character {
  var hp: Int
  var dmg: Int
  var ac: Int
  var gp: Int

  init(hp: Int, items: [Item]) {
    self.hp = hp
    self.dmg = 0
    self.ac = 0
    self.gp = 0
    for i in items {
      self.dmg += i.dmg
      self.ac += i.ac
      self.gp += i.cost
    }
  }

  init(hp: Int, dmg: Int, ac: Int) {
    self.hp = hp
    self.dmg = dmg
    self.ac = ac
    self.gp = 0
  }
}

// Weapons:    Cost  Damage  Armor
// Dagger        8     4       0
// Shortsword   10     5       0
// Warhammer    25     6       0
// Longsword    40     7       0
// Greataxe     74     8       0
static let weapons = [
  Item(cost: 8, dmg: 4, ac: 0),
  Item(cost: 10, dmg: 5, ac: 0),
  Item(cost: 25, dmg: 6, ac: 0),
  Item(cost: 40, dmg: 7, ac: 0),
  Item(cost: 74, dmg: 8, ac: 0),
]

// Armor:      Cost  Damage  Armor
// Leather      13     0       1
// Chainmail    31     0       2
// Splintmail   53     0       3
// Bandedmail   75     0       4
// Platemail   102     0       5
static let armor = [
  Item(cost: 0, dmg: 0, ac: 0),
  Item(cost: 13, dmg: 0, ac: 1),
  Item(cost: 31, dmg: 0, ac: 2),
  Item(cost: 53, dmg: 0, ac: 3),
  Item(cost: 75, dmg: 0, ac: 4),
  Item(cost: 102, dmg: 0, ac: 5),
]

// Rings:      Cost  Damage  Armor
// Damage +1    25     1       0
// Damage +2    50     2       0
// Damage +3   100     3       0
// Defense +1   20     0       1
// Defense +2   40     0       2
// Defense +3   80     0       3
static let rings = [
  Item(cost: 25, dmg: 1, ac: 0),
  Item(cost: 50, dmg: 2, ac: 0),
  Item(cost: 100, dmg: 3, ac: 0),
  Item(cost: 20, dmg: 0, ac: 1),
  Item(cost: 40, dmg: 0, ac: 2),
  Item(cost: 80, dmg: 0, ac: 3),
]

static func turnsToKill(attacker: Character, defender: Character) -> Int {
  let dmg = max(attacker.dmg - defender.ac, 1)
  return (defender.hp + dmg - 1) / dmg
}

static func wins(_ player: Character, _ enemy: Character) -> Bool {
  return turnsToKill(attacker:player, defender:enemy) <=
         turnsToKill(attacker:enemy, defender:player)
}

static func part1(_ enemy:Character) -> Int {
  var best = Int.max
  for w in weapons {
    for a in armor {
      for i in 0...2 {
        for r in rings.combinations(ofCount:i) {
          let p = Character(hp:100, items:r + [w, a])
          if wins(p, enemy) {
            best = min(best, p.gp)
          }
        }
      }
    }
  }
  return best
}

static func part2(_ enemy:Character) -> Int {
  var worst = 0
  for w in weapons {
    for a in armor {
      for i in 0...2 {
        for r in rings.combinations(ofCount:i) {
          let p = Character(hp:100, items:r + [w, a])
          if !wins(p, enemy) {
            worst = max(worst, p.gp)
          }
        }
      }
    }
  }
  return worst
}

static func main() throws {
  let enemy = Character(hp: 103, dmg: 9, ac: 2)

  print("Day 21 part 1:", part1(enemy));
  print("Day 21 part 2:", part2(enemy));
}
}
