import Foundation;

struct Day22 {
enum Result {
  case Pending
  case Win
  case Loss
}

struct Game : Comparable {
  var hp = 50
  var mana = 500
  var boss_hp = 58
  var shield_turns = 0
  var poison_turns = 0
  var recharge_turns = 0
  var mana_spent = 0

  static func == (lhs: Game, rhs: Game) -> Bool {
    return lhs.hp == rhs.hp
      && lhs.mana == rhs.mana
      && lhs.boss_hp == rhs.boss_hp
      && lhs.shield_turns == rhs.shield_turns
      && lhs.poison_turns == rhs.poison_turns
      && lhs.recharge_turns == rhs.recharge_turns
      && lhs.mana_spent == rhs.mana_spent
  }
  static func < (lhs: Game, rhs: Game) -> Bool {
    if lhs.mana_spent < rhs.mana_spent {
      return true
    }
    if lhs.boss_hp < rhs.boss_hp {
      return true
    }
    if lhs.hp > rhs.hp {
      return true
    }
    if lhs.mana > rhs.mana {
      return true
    }
    if lhs.shield_turns > rhs.shield_turns {
      return true
    }
    if lhs.poison_turns > rhs.poison_turns {
      return true
    }
    if lhs.recharge_turns > rhs.recharge_turns {
      return true
    }
    return false
  }

  func Expand() -> [Game] {
    var res = [Game]()

    // Magic Missile costs 53 mana. It instantly does 4 damage.
    if mana >= 53 {
      var n = self
      n.mana -= 53
      n.mana_spent += 53
      n.boss_hp -= 4
      res.append(n)
    }

    // Drain costs 73 mana. It instantly does 2 damage and heals you for 2 hit points.
    if mana >= 73 {
      var n = self
      n.mana -= 73
      n.mana_spent += 73
      n.boss_hp -= 2
      n.hp += 2
      res.append(n)
    }

    // Shield costs 113 mana. It starts an effect that lasts for 6 turns. While
    // it is active, your armor is increased by 7.
    if mana >= 113 && shield_turns == 0 {
      var n = self
      n.mana -= 113
      n.mana_spent += 113
      n.shield_turns = 6
      res.append(n)
    }

    // Poison costs 173 mana. It starts an effect that lasts for 6 turns. At
    // the start of each turn while it is active, it deals the boss 3 damage.
    if mana >= 173 && poison_turns == 0 {
      var n = self
      n.mana -= 173
      n.mana_spent += 173
      n.poison_turns = 6
      res.append(n)
    }

    // Recharge costs 229 mana. It starts an effect that lasts for 5 turns. At
    // the start of each turn while it is active, it gives you 101 new mana.
    if mana >= 229 && recharge_turns == 0 {
      var n = self
      n.mana -= 229
      n.mana_spent += 229
      n.recharge_turns = 5
      res.append(n)
    }

    return res
  }

  mutating func AdvanceTurn() -> Result {
    AdvanceSpells()
    if boss_hp <= 0 {
      return .Win
    }
    BossDmg()
    if hp <= 0 {
      return .Loss
    }
    AdvanceSpells()
    if boss_hp <= 0 {
      return .Win
    }
    return .Pending
  }

  mutating func BossDmg() {
    hp -= 9
    if (shield_turns > 0) {
      hp += 7
    }
  }

  mutating func AdvanceSpells() {
    if (shield_turns > 0) {
      shield_turns -= 1
    }
    if (poison_turns > 0) {
      boss_hp -= 3
      poison_turns -= 1;
    }
    if (recharge_turns > 0) {
      mana += 101
      recharge_turns -= 1
    }
  }
}


static func part1(_ raw:String) -> Int {
  var states = PriorityQueue(startingValues:Game().Expand())
  var best = Int.max
  while var s = states.pop() {
    switch s.AdvanceTurn() {
      case .Win:
        best = min(best, s.mana_spent)
      case .Loss:
        break
      case .Pending:
        for n in s.Expand() {
          if n.mana_spent < best {
            states.push(n)
          }
        }
    }
  }
  return best
}

static func part2(_ raw:String) -> Int {
  var states = PriorityQueue(startingValues:Game().Expand())
  var best = Int.max
  while var s = states.pop() {
    s.hp -= 1
    if s.hp > 0 {
      switch s.AdvanceTurn() {
        case .Win:
          best = min(best, s.mana_spent)
        case .Loss:
          break
        case .Pending:
          for n in s.Expand() {
            if n.mana_spent < best {
              states.push(n)
            }
          }
      }
    }
  }
  return best
}

static func main() throws {
  let raw = try String(contentsOfFile:"input/day22.txt")

  print("Day 22 part 1:", part1(raw));
  print("Day 22 part 2:", part2(raw));
}
}
