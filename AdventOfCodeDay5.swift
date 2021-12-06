
import Foundation

struct Line {
    var startX: Int
    var endX:Int
    var startY: Int
    var endY: Int
}

func part1(_ input: [Line]) -> Int {
    var xyCounts = [String: Int]()
    for line in input {
        if line.startX == line.endX {
            let start = min(line.startY, line.endY)
            let end = max(line.startY, line.endY)
            for y in start ... end {
                if let count = xyCounts["\(line.startX),\(y)"] {
                    xyCounts["\(line.startX),\(y)"] = count + 1
                } else {
                    xyCounts["\(line.startX),\(y)"] = 1
                }
            } 
        }
        if line.startY == line.endY {
            let start = min(line.startX, line.endX)
            let end = max(line.startX, line.endX)
            for x in start ... end {
                if let count = xyCounts["\(x),\(line.startY)"] {
                    xyCounts["\(x),\(line.startY)"] = count + 1
                } else {
                    xyCounts["\(x),\(line.startY)"] = 1
                }
            } 
        }
    }

    var count = 0
    for cross in xyCounts.values {
        if cross > 1 {
            count += 1
        }
    }

    return count
}

func part2(_ input: [Line]) -> Int {
    var xyCounts = [String: Int]()
    for line in input {
        if line.startX == line.endX {
            let start = min(line.startY, line.endY)
            let end = max(line.startY, line.endY)
            for y in start ... end {
                if let count = xyCounts["\(line.startX),\(y)"] {
                    xyCounts["\(line.startX),\(y)"] = count + 1
                } else {
                    xyCounts["\(line.startX),\(y)"] = 1
                }
            } 
        }
        if line.startY == line.endY {
            let start = min(line.startX, line.endX)
            let end = max(line.startX, line.endX)
            for x in start ... end {
                if let count = xyCounts["\(x),\(line.startY)"] {
                    xyCounts["\(x),\(line.startY)"] = count + 1
                } else {
                    xyCounts["\(x),\(line.startY)"] = 1
                }
            } 
        }
        if line.startX != line.endX 
            && line.startY != line.endY {
            print("Found a diagonal: \(line)")
            if line.startX == line.endX 
                && line.startY == line.endY {

                    let start = min(line.startX, line.startY)
                    let end = max(line.startX, line.startY)
                    for xy in start ... end {
                        if let count = xyCounts["\(xy),\(xy)"] {
                            xyCounts["\(xy),\(xy)"] = count + 1
                        } else {
                            xyCounts["\(xy),\(xy)"] = 1
                        }
                    }
            } else {
                
            }
        }
    }

    var count = 0
    for cross in xyCounts.values {
        if cross > 1 {
            count += 1
        }
    }

    return count
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