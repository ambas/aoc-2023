import Algorithms
import Foundation

struct Day05: AdventDay {
  
  struct Map {
    let source: Int
    let destination: Int
    let length: Int
    
    func extract(_ input: ClosedRange<Int>) -> (ClosedRange<Int>?, [ClosedRange<Int>]) {
      var res1: ClosedRange<Int>?
      var res = [ClosedRange<Int>]()
      let currRange = sourceRange
      
      if input.overlaps(currRange) {
        let clamped = max(input.lowerBound, currRange.lowerBound)...min(input.upperBound, currRange.upperBound)
        let start = clamped.lowerBound + shift
        let end = clamped.upperBound + shift
        res1 = start...end
        if input.lowerBound < currRange.lowerBound {
          let start = input.lowerBound
          let end = min(currRange.lowerBound - 1, input.upperBound)
          res.append(start...end)
        }
        if input.upperBound > currRange.upperBound {
          let start = max(currRange.upperBound + 1, input.lowerBound)
          let end = input.upperBound
          res.append(start...end)
        }
      } else {
        res1 = input
      }


      return (res1, res)
    }
    
    var sourceRange: ClosedRange<Int> {
      source...(source + length - 1)
    }
    
    var destinationRange: ClosedRange<Int> {
      destination...(destination + length - 1)
    }
    
    var shift: Int {
      source - destination
    }
    
    func makeTransformedRange(from original: Map) -> Map {
      let clamped = original.destinationRange.clamped(to: sourceRange)
      if clamped.isEmpty { return original }
      let start = clamped.lowerBound
      return .init(source: start, destination: start + original.shift, length: clamped.count)
    }
    
    func checkLenght(_ val: Int) -> Int? {
      if (source...(source + length - 1)).contains(val) {
        let advance = val - source
        return destination + advance
      }
      return nil
    }
  }
  
  // 2025334497 3876763368 16729580
  typealias Entities = [[Map]]
  
  // Splits input data into its component parts and convert from string.
  var entities: Entities!
  let seeds: [Int]
  
  init(data: String) {
    let splited = data.split(separator: "X")
    seeds = splited[0].split(separator: ":")[1].trimmingCharacters(in: .newlines).split(separator: " ", omittingEmptySubsequences: true).map { Int(String($0))! }
    var entities: Entities = []
    for cat in splited.dropFirst() {
      let lines = String(cat).split(separator: "\n")
      var can = [Map]()
      for line in lines {
        let input = makeMap(String(line))
        can.append(input)
      }
      entities.append(can)
    }
    self.entities = entities
  }
  
  func makeMap(_ input: String) -> Map {
    let splited = input.split(separator: " ").map { Int($0)! }
    return Map(source: splited[1], destination: splited[0], length: splited[2])
  }
  
  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var res = Int.max
    var dp = [[Int]: Int]()
    for seed in seeds {
      res = min(res, dfs(seed, 0, &dp))
    }
    return res
  }
  
  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var ranges = [ClosedRange<Int>]()
    for i in stride(from: 0, to: seeds.count, by: 2) {
      let to = seeds[i] + seeds[i + 1] - 1
      ranges.append(seeds[i]...to)
    }
    
    for cats in entities {
      var newRange = [ClosedRange<Int>]()
      while let range = ranges.popLast() {
        for cat in cats {
          let a = cat.extract(range)
          if let dd = a.0 {
            newRange.append(dd)
            ranges.append(contentsOf: a.1)
            break
          }
          
        }
      }
      ranges = newRange
    }
    
    return ranges.map { $0.lowerBound }.min()!
  }
  
  
  func dfs(_ val: Int, _ i: Int, _ dp: inout [[Int]: Int]) -> Int {
    func makeDestination(_ val: Int) -> Int {
      for map in entities[i] {
        if let found = map.checkLenght(val) {
          return found
        }
      }
      return val
    }
    let key = [val, i]
    if let res = dp[key] { return res }
    let des = makeDestination(val)
    if i == entities.count - 1 { return des }
    
    let res = dfs(des, i + 1, &dp)
    dp[key] = res
    return res
  }
  
}
