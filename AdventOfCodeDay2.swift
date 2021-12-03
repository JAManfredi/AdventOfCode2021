
import Foundation

func part1(_ input: [Any]) -> Int {
    var depth = 0
    var position = 0

    for case let value as String in input {
        let move = value.split(separator: " ")
        let direction = move[0]
        let units = Int(move[1]) ?? 0

        switch direction {
        case "forward":
            position += units
        case "down":
            depth += units
        case "up":
            depth -= units
        default: ()
        }
    }

    return depth * position
}

func part2(_ input: [Any]) -> Int {
    var depth = 0
    var position = 0
    var aim = 0

    for case let value as String in input {
        let move = value.split(separator: " ")
        let direction = move[0]
        let units = Int(move[1]) ?? 0

        switch direction {
        case "forward":
            position += units
            depth += aim * units
        case "down":
            aim += units
        case "up":
            aim -= units
        default: ()
        }
    }

    return depth * position
}

let rawFileContents = try! String(contentsOfFile: "AOCInput2.txt")
let inputArray = rawFileContents.split(separator: "\n").map { String($0) }
print("Part1: \(part1(inputArray)) Part2: \(part2(inputArray))")

// swiftc -o AdventOfCodeDay2 AdventOfCodeDay2.swift; ./AdventOfCodeDay2
