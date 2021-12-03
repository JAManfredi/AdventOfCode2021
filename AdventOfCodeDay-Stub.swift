
import Foundation

func part1(_ input: [Any]) -> Int {
    return 0
}

func part2(_ input: [Any]) -> Int {
    return 0
}

let rawFileContents = try! String(contentsOfFile: "AOCInput0.txt")
let inputArray = rawFileContents.split(separator: "\n").map { String($0) }
print("Part1: \(part1(inputArray)) Part2: \(part2(inputArray))")

// swiftc -o AdventOfCodeDay0 AdventOfCodeDay0.swift; ./AdventOfCodeDay0
