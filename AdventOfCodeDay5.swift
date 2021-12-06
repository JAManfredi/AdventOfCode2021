
import Foundation

struct Line {
    var startX: Int
    var endX:Int
    var startY: Int
    var endY: Int
}

func updateCount(forKey key: String, dictionary: inout [String: Int]) {
    if let count = dictionary[key] {
        dictionary[key] = count + 1
    } else {
        dictionary[key] = 1
    }
}

func totalOverlaps(inDictionary dictionary: [String: Int]) -> Int {
    var count = 0
    for cross in dictionary.values {
        if cross > 1 {
            count += 1
        }
    }
    return count
}

func part1(_ input: [Line]) -> Int {
    var xyCounts = [String: Int]()

    for line in input {
        if line.startX == line.endX {
            let start = min(line.startY, line.endY)
            let end = max(line.startY, line.endY)
            for y in start ... end {
                let key = "\(line.startX),\(y)"
                updateCount(forKey: key, dictionary: &xyCounts)
            } 
        }
        if line.startY == line.endY {
            let start = min(line.startX, line.endX)
            let end = max(line.startX, line.endX)
            for x in start ... end {
                let key = "\(x),\(line.startY)"
                updateCount(forKey: key, dictionary: &xyCounts)
            } 
        }
    }

    return totalOverlaps(inDictionary: xyCounts)
}

func part2(_ input: [Line]) -> Int {
    var xyCounts = [String: Int]()
    for line in input {
        // Horizontal lines
        if line.startX == line.endX {
            let start = min(line.startY, line.endY)
            let end = max(line.startY, line.endY)
            for y in start ... end {
                let key = "\(line.startX),\(y)"
                updateCount(forKey: key, dictionary: &xyCounts)
            } 
        }
        // Vertical lines
        if line.startY == line.endY {
            let start = min(line.startX, line.endX)
            let end = max(line.startX, line.endX)
            for x in start ... end {
                let key = "\(x),\(line.startY)"
                updateCount(forKey: key, dictionary: &xyCounts)
            }
        }
        // Diagonal lines
        if line.startX != line.endX
            && line.startY != line.endY {

            if line.startX == line.startY
                && line.endX == line.endY {

                    let start = min(line.startX, line.endX)
                    let end = max(line.startY, line.endY)
                    for xy in start ... end {
                        let key = "\(xy),\(xy)"
                        updateCount(forKey: key, dictionary: &xyCounts)
                    }
            } else if line.startX > line.endX
                        && line.startY > line.endY {

                var yIndex = line.startY
                for x in stride(from: line.startX, through: line.endX, by: -1) {
                    let key = "\(x),\(yIndex)"
                    updateCount(forKey: key, dictionary: &xyCounts)
                    yIndex -= 1
                }
            } else if line.startX > line.endX
                        && line.startY < line.endY {

                var yIndex = line.startY
                for x in stride(from: line.startX, through: line.endX, by: -1) {
                    let key = "\(x),\(yIndex)"
                    updateCount(forKey: key, dictionary: &xyCounts)
                    yIndex += 1
                }
            } else if line.startX < line.endX
                        && line.startY > line.endY {

                var xIndex = line.startX
                for y in stride(from: line.startY, through: line.endY, by: -1) {
                    let key = "\(xIndex),\(y)"
                    updateCount(forKey: key, dictionary: &xyCounts)
                    xIndex += 1
                }
            } else if line.startX < line.endX
                        && line.startY < line.endY {

                var yIndex = line.startY
                for x in line.startX ... line.endX {
                    let key = "\(x),\(yIndex)"
                    updateCount(forKey: key, dictionary: &xyCounts)
                    yIndex += 1
                }
            }
        }
    }

    return totalOverlaps(inDictionary: xyCounts)
}

let rawFileContents = try! String(contentsOfFile: "AOCInput5.txt")
let inputArray = rawFileContents.split(separator: "\n").map { String($0) }
let lineArray: [Line] = inputArray.compactMap { rawLine in
    let line = rawLine.components(separatedBy: "->")

    let lineStart = line[0].trimmingCharacters(in: .whitespacesAndNewlines).split(separator: ",")
    let lineEnd = line[1].trimmingCharacters(in: .whitespacesAndNewlines).split(separator: ",")

    let lineStartX = Int(lineStart[0]) ?? 0
    let lineStartY = Int(lineStart[1]) ?? 0
    let lineEndX = Int(lineEnd[0]) ?? 0
    let lineEndY = Int(lineEnd[1]) ?? 0

    return Line(startX: lineStartX, endX: lineEndX, startY: lineStartY, endY: lineEndY)
}
print("Part1: \(part1(lineArray)) Part2: \(part2(lineArray))")

// swiftc -o AdventOfCodeDay5 AdventOfCodeDay5.swift; ./AdventOfCodeDay5
