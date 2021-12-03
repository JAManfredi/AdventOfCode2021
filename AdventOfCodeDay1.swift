import Foundation

func part1(_ input: [Int]) -> Int {
    var increases = 0
    var currentValue = 0
    for value in input {
        guard currentValue > 0 else {
            currentValue = value
            continue
        }

        if currentValue < value { increases += 1 }
        currentValue = value
    }

    return increases
}

func part2(_ input: [Int]) -> Int {
    var increases = 0
    var currentValue = 0
    var windowStartIndex = 0
    var windowEndIndex = 2

    while windowEndIndex < input.count {
        let windowValues = input[windowStartIndex ... windowEndIndex]
        let windowTotal = windowValues.reduce(0, { $0 + $1 })

        guard currentValue > 0 else {
            currentValue = windowTotal
            windowStartIndex += 1
            windowEndIndex += 1
            continue
        }

        if currentValue < windowTotal { increases += 1 }
        currentValue = windowTotal
        windowStartIndex += 1
        windowEndIndex += 1
    }

    return increases
}

let rawFileContents = try! String(contentsOfFile: "AOCInput1.txt")
let inputArray = rawFileContents.split(separator: "\n")
let integerInputArray = inputArray.compactMap { Int($0) }
print("Part1: \(part1(integerInputArray)) Part2: \(part2(integerInputArray))")

// swiftc -o AdventOfCodeDay1 AdventOfCodeDay1.swift; ./AdventOfCodeDay1
