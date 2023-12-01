
import Algorithms

struct Day01: AdventDay {

  var data: String

  var entities: [String] {
    data.split(separator: "\n").map { String($0) }
  }

  let dict = [
    "one": "1", "two": "2", "three": "3", "four": "4", "five": "5", "six": "6", "seven": "7",
    "eight": "8", "nine": "9",
  ]

  func part1() -> Any {
    var nums = [Int]()
    for input in entities {
      let firstNum = number(from: input, isFirst: true)
      let lastNum = number(from: input, isFirst: false)
      let a = Int(firstNum + lastNum)!
      nums.append(a)
    }
    return nums.reduce(0, +)
  }

  func part2() -> Any {
    part1()
  }

  func number(from input: String, isFirst: Bool) -> String {
    let count = input.count
    let input = Array(input)
    var p = isFirst ? 0 : count - 1

    while p >= 0 && p < count {
      if input[p].isNumber { return String(input[p]) }
      for key in dict.keys {
        let keyCount = key.count
        let bound = min(p + keyCount, count)
        if String(input[p..<bound]) == key {
          return dict[key]!
        }
      }
      p += isFirst ? 1 : -1
    }
    fatalError()
  }
}
