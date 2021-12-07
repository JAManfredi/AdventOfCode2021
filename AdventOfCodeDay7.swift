
import Foundation

func part1(_ input: [Int]) -> Int {
    let sortedInput = input.sorted()
    var currentAlignmentPosition = 0
    var lowestFuelUsage = Int.max
    let maxHorizontalPosition = sortedInput.last ?? 0

    while currentAlignmentPosition < maxHorizontalPosition {
        var fuel = 0
        for x in 0 ..< sortedInput.count {
            let currentPosition = sortedInput[x]
            guard currentPosition != currentAlignmentPosition else {
                continue
            }
            fuel += abs(currentPosition - currentAlignmentPosition)
        }
        lowestFuelUsage = min(lowestFuelUsage, fuel)
        currentAlignmentPosition += 1
    }

    return lowestFuelUsage
}

func part2(_ input: [Int]) -> Int {
    let sortedInput = input.sorted()
    var currentAlignmentPosition = 0
    var lowestFuelUsage = Int.max
    let maxHorizontalPosition = sortedInput.last ?? 0

    while currentAlignmentPosition < maxHorizontalPosition {
        var fuel = 0
        for x in 0 ..< sortedInput.count {
            let currentPosition = sortedInput[x]
            guard currentPosition != currentAlignmentPosition else {
                continue
            }
            let diff = abs(currentPosition - currentAlignmentPosition)
            fuel += (diff*(diff + 1)/2)
        }
        lowestFuelUsage = min(lowestFuelUsage, fuel)
        currentAlignmentPosition += 1
    }

    return lowestFuelUsage}

let rawFileContents = try! String(contentsOfFile: "AOCInput7.txt")
let inputArray = rawFileContents.split(separator: "\n")[0].split(separator: ",").map { Int($0) ?? 0 }
print("Part1: \(part1(inputArray))")
print("Part2: \(part2(inputArray))")

// swiftc -o AdventOfCodeDay6 AdventOfCodeDay6.swift
// ./AdventOfCodeDay6




