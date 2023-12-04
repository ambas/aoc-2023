import Foundation
import Algorithms

struct Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String
  
  struct Card {
    let win: [Int]
    let curr: [Int]
    
    init(_ input: String) {
      let splited = input.split(separator: "|")
      win = splited[0].split(separator: " ", omittingEmptySubsequences: true).compactMap { Int($0) }
      curr = splited[1].split(separator: " ", omittingEmptySubsequences: true).compactMap { Int($0) }
    }
    
    var calSame: Int {
      let set1 = Set(win)
      let set2 = Set(curr)
      let same = set1.intersection(set2)
      return same.count
    }
    
    var calWin: Int {
      let res = pow(Double(2), Double(calSame) - 1)
      
      return Int(res)
      
    }
  }
  
  // Splits input data into its component parts and convert from string.
  let entities: [Card]
  
  init(data: String) {
    self.data = data
    self.entities = data
      .split(separator: "\n")
      .map {
        let splited = $0.split(separator: ":")
        return Card(String(splited[1]))
      }
  }
  
  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    entities.map(\.calWin).reduce(0, +)
  }
  
  
  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var numberOfCard = Array(repeating: 1, count: entities.count)
    for (index, card) in entities.enumerated() {
      let rightBound = min(index + card.calSame, entities.count)
      for i in (index + 1)..<rightBound + 1 {
        numberOfCard[i] += numberOfCard[index]
      }
    }
    let res = numberOfCard.reduce(0, +)
    return "\(res)"
  }
  
}
