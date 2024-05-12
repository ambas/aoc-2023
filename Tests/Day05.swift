import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day05Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testDataPart1 = """
    seeds: 79 14 55 13
    X
    50 98 2
    52 50 48
    X
    0 15 37
    37 52 2
    39 0 15
    X
    49 53 8
    0 11 42
    42 0 7
    57 7 4
    X
    88 18 7
    18 25 70
    X
    45 77 23
    81 45 19
    68 64 13
    X
    0 69 1
    1 0 69
    X
    60 56 37
    56 93 4
    """
  
  func testPart1() throws {
    let challenge = Day05(data: testDataPart1)
    XCTAssertEqual(String(describing: challenge.part1()), "35")
  }

  func testPart2() throws {
    let challenge = Day05(data: testDataPart1)
    XCTAssertEqual(String(describing: challenge.part2()), "46")
  }

}
