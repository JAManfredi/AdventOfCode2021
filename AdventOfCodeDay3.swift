
import Foundation

func part1(_ input: [String]) -> Int {
    var bitCountArray = [Int]()
    for binary in input {
        for (index, value) in binary.enumerated() {
            let bit = Int(String(value)) ?? 0

            if bitCountArray.count == index {
                bitCountArray.insert(bit, at: index)
                continue
            }

            let currentValue = bitCountArray[index]
            bitCountArray[index] = currentValue + (bit == 1 ? 1 : -1)
        }
    }

    let gamma = bitCountArray.map { ($0 > 0) ? "1" : "0" }.joined()
    let gammaDecimal = Int(gamma, radix: 2) ?? 0
    
    let epsilon = bitCountArray.map { ($0 > 0) ? "0" : "1" }.joined()
    let epsilonDecimal = Int(epsilon, radix: 2) ?? 0

    return gammaDecimal * epsilonDecimal
}

func findCommonBit(_ input: [String], at index: Int) -> String {
    var bitCount = 0
    for binary in input {
        let binaryIndex = binary.index(binary.startIndex, offsetBy: index)
        let bitValue = String(binary[binaryIndex])
        let bit = Int(bitValue) ?? 0
        bitCount += (bit == 1 ? 1 : -1)
    }
    return bitCount >= 0 ? "1" : "0"
}

func findLeastCommonBit(_ input: [String], at index: Int) -> String {
    var bitCount = 0
    for binary in input {
        let binaryIndex = binary.index(binary.startIndex, offsetBy: index)
        let bitValue = String(binary[binaryIndex])
        let bit = Int(bitValue) ?? 0
        bitCount += (bit == 1 ? 1 : -1)
    }
    return bitCount >= 0 ? "0" : "1"
}

func part2(_ input: [String]) -> Int {
    var iteration = 0
    var oxygenInput = input
    while oxygenInput.count > 1 {
        let bitToMatchOn = findCommonBit(oxygenInput, at: iteration)
        oxygenInput = oxygenInput.filter { value in
            let index = value.index(value.startIndex, offsetBy: iteration)
            let bitAtIndex = String(value[index])
            return bitAtIndex == bitToMatchOn
        }
        iteration += 1
    }

    iteration = 0
    var co2Input = input
    while co2Input.count > 1 {
        let bitToMatchOn = findLeastCommonBit(co2Input, at: iteration)
        co2Input = co2Input.filter { value in
            let index = value.index(value.startIndex, offsetBy: iteration)
            let bitAtIndex = String(value[index])
            return bitAtIndex == bitToMatchOn
        }
        iteration += 1
    }

    print(oxygenInput)
    print(co2Input)

    let oxygenDecimal = Int(oxygenInput.joined(), radix: 2) ?? 0
    let co2Decimal = Int(co2Input.joined(), radix: 2) ?? 0

    return oxygenDecimal * co2Decimal
}

let rawFileContents = try! String(contentsOfFile: "AOCInput3.txt")
let inputArray = rawFileContents.split(separator: "\n").map { String($0) }
print("Part1: \(part1(inputArray)) Part2: \(part2(inputArray))")

// swiftc -o AdventOfCodeDay3 AdventOfCodeDay3.swift; ./AdventOfCodeDay3
