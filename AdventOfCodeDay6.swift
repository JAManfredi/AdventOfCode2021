
import Foundation

func part1(_ input: [Int], days: Int) -> Int {
    var fish = input
    for _ in 1 ... days {
        processLanternfish(fish: &fish)
    }
    return fish.count
}

func processLanternfish(fish: inout [Int]) {
    let fishCopy = fish
    for index in 0 ..< fishCopy.count {
        let currentFish = fish[index]
        if currentFish == 0 {
            // Spawn new fish
            fish.append(8)
            fish[index] = 6
            continue
        }
        fish[index] = currentFish - 1
    }
}

func part2(_ input: [Int], days: Int) -> Int {
    // Prepare fish
    let rawFish = input.sorted()
    var fishDictionary = [0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0]
    for fish in rawFish {
        let count = fishDictionary[fish] ?? 0
        fishDictionary[fish] = count + 1
    }

    // Process fish by days
    for _ in 1 ... days {
        processLanternfish2(fish: &fishDictionary)
    }
    return fishDictionary.values.map { Int($0) }.reduce(0, +)
}

func processLanternfish2(fish: inout [Int: Int]) {
    var overwritingValue = 0
    // Reduce each fish by 1
    for key in stride(from: 8, to: 0, by: -2) {
        let movingCount = fish[key] ?? 0
        fish[key] = overwritingValue
        overwritingValue = fish[key - 1] ?? 0
        fish[key - 1] = movingCount
    }

    // Handle spawning fish
    let spawningFish = fish[0] ?? 0
    if spawningFish > 0 {
        let count = fish[6] ?? 0
        fish[6] = count + spawningFish

        // Add spawns
        fish[8] = spawningFish
    }

    fish[0] = overwritingValue
}

let rawFileContents = try! String(contentsOfFile: "AOCInput6.txt")
let inputArray = rawFileContents.split(separator: "\n")[0].split(separator: ",").map { Int($0) ?? 0 }
print("Part1: \(part1(inputArray, days: 80)) Part2: \(part2(inputArray, days: 256))")

// swiftc -o AdventOfCodeDay6 AdventOfCodeDay6.swift
// ./AdventOfCodeDay6
