
import Algorithms

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String
  
  init(data: String) {
    self.data = data
    self.entities = data.split(separator: "\n").map {
      Array($0) + ["."]
    }
  }
  
  // Splits input data into its component parts and convert from string.
  let entities: [[Character]]
  
  var rowCount: Int {
    entities.count
  }
  
  var colCount: Int {
    entities[0].count
  }
  
  func isSymbol(_ row: Int, _ col: Int) -> Bool {
    !entities[row][col].isNumber && entities[row][col] != "."
  }
  
  func symbolAround(_ row: Int, _ startIndex: Int, _ endIndex: Int) -> [[Int]] {
    var symbolPoints = [[Int]]()
    let aboveRow = row - 1
    let belowRow = row + 1
    if aboveRow >= 0 {
      let (startIndex, endIndex) = (startIndex - 1, endIndex + 1)
      for col in startIndex..<endIndex where col >= 0 && col < colCount {
        if isSymbol(aboveRow, col) {
          symbolPoints.append([aboveRow, col])
        }
      }
    }
    if belowRow < rowCount {
      let (startIndex, endIndex) = (startIndex - 1, endIndex + 1)
      for col in startIndex..<endIndex where col >= 0 && col < colCount {
        if isSymbol(belowRow, col) {
          symbolPoints.append([belowRow, col])
        }
      }
    }
    if startIndex > 0 && isSymbol(row, startIndex - 1) {
      symbolPoints.append([row, startIndex - 1])
    }
    if endIndex < (colCount - 2) && isSymbol(row, endIndex) {
      symbolPoints.append([row, endIndex])
    }
    return symbolPoints
  }
  
  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var res = 0
    for row in 0..<rowCount {
      var startIndex: Int?
      for col in 0..<colCount {
        let currChar = entities[row][col]
        if startIndex == nil && currChar.isNumber {
          startIndex = col
        } else if startIndex != nil && (!currChar.isNumber) {
          let num = Int(String(entities[row][startIndex!..<col]))!
          if !symbolAround(row, startIndex!, col).isEmpty {
            res += num
          }
          
          startIndex = nil
        }
      }
    }
    return String(res)
  }
  
  
  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var dict = [[Int]: [Int]]()
    for row in 0..<rowCount {
      var startIndex: Int?
      for col in 0..<colCount {
        let currChar = entities[row][col]
        if startIndex == nil && currChar.isNumber {
          startIndex = col
        } else if startIndex != nil && (!currChar.isNumber) {
          let num = Int(String(entities[row][startIndex!..<col]))!
          symbolAround(row, startIndex!, col)
            .filter {
              let (row, col) = ($0[0], $0[1])
              return entities[row][col] == "*"
            }
            .forEach {
              let (row, col) = ($0[0], $0[1])
              dict[[row, col], default: []].append(num)
            }
          startIndex = nil
        }
        
        
      }
    }
   
    var res = 0
    for value in dict.values where value.count == 2 {
        res += (value[0] * value[1])
    }
    return String(res)
  }
  
}
