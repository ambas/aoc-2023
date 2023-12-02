
import Algorithms

struct Day02: AdventDay {
  struct Round {
    
    let (mxRed, mxGreen, mxBlue) = (12, 13, 14)
    
    var red: Int = 0
    var green: Int = 0
    var blue: Int = 0
    
    init(_ input: String) {
      let colors = input.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces ) }
      for color in colors {
        let splited = color.split(separator: " ")
        let (count, item) = (Int(String(splited[0]))!, splited[1])
        if item == "red" {
          red = count
        } else if item == "green" {
          green = count
        } else {
          blue = count
        }
      }
    }
    
    var isValid: Bool {
      red <= mxRed && green <= mxGreen && blue <= mxBlue
    }
  }
  struct Game {
    let rounds: [Round]
  }

  var data: String

  var entities: [Game] {
    let games = data.split(separator: "\n")
      .map { (rawGame) -> Game in
        let rawGame = String(rawGame.split(separator: ":")[1]).trimmingCharacters(in: .whitespaces)
        let rawRounds = rawGame.split(separator: ";").map {
          String($0).trimmingCharacters(in: .whitespaces)
        }
        let rounds = rawRounds.map { Round($0) }
        return .init(rounds: rounds)
      }
    return games
  }
  
  func part1() -> Any {
    var res = 0
    for (index, game) in entities.enumerated() where game.rounds.allSatisfy({ $0.isValid }) {
      res += (index + 1)
    }
    return String(res)
  }

  func part2() -> Any {
    var res = 0
    for game in entities {
      var (red, green, blue) = (0, 0, 0)
      for round in game.rounds {
        red = max(red, round.red)
        green = max(green, round.green)
        blue = max(blue, round.blue)
      }
      let power = (max(1, red) * max(1, green) * max(1, blue))
      res += power
    }
    return String(res)
  }

}
