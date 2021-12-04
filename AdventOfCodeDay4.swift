
import Foundation

func part1(_ input: [[Set<Int>]], _ numbers: [Int]) -> Int {
    var mutableBoards = input
    search: for n in 0 ..< numbers.count { 
        let number = numbers[n]

        for x in 0 ..< mutableBoards.count {
            var boardRowColumnSets = mutableBoards[x]
            for y in 0 ..< boardRowColumnSets.count {
                var valueSet = boardRowColumnSets[y]
                valueSet.remove(number)

                if valueSet.count == 0 {
                    boardRowColumnSets[y] = valueSet
                    let remainingSum = calculateRemainder(Array(boardRowColumnSets[0..<5]))
                    return remainingSum * number            
                }

                boardRowColumnSets[y] = valueSet
            }
            mutableBoards[x] = boardRowColumnSets
        } 
    }
    return 0
}

func part2(_ input: [[Set<Int>]], _ numbers: [Int]) -> Int {
    var currentWinningBoardValue = 0

    var winnerSet = Set<Int>()
    var mutableBoards = input
    search: for n in 0 ..< numbers.count { 
        let number = numbers[n]

        boardLoop: for x in 0 ..< mutableBoards.count {
            var boardRowColumnSets = mutableBoards[x]
            for y in 0 ..< boardRowColumnSets.count {
                var valueSet = boardRowColumnSets[y]
                valueSet.remove(number)

                if valueSet.count == 0 {
                    boardRowColumnSets[y] = valueSet
                    let remainingSum = calculateRemainder(Array(boardRowColumnSets[0..<5]))
                    currentWinningBoardValue = remainingSum * number            
                    
                    winnerSet.insert(x)
                    if(winnerSet.count == mutableBoards.count) {
                        return currentWinningBoardValue
                    }
        
                    continue boardLoop
                }

                boardRowColumnSets[y] = valueSet
            }
            mutableBoards[x] = boardRowColumnSets
        } 
    }

    return currentWinningBoardValue
}

func calculateRemainder(_ boardValues: [Set<Int>]) -> Int {
    var total = 0
    for value in boardValues {
        total += value.reduce(0, +)
    }
    return total
}

// Parse input
let rawFileContents = try! String(contentsOfFile: "AOCInput4.txt")
let inputArray = rawFileContents.split(separator: "\n")
let bingoNumbers: [Int] = inputArray[0].split(separator: ",").map{ Int($0) ?? 0 }
let allBoardRowsArray = inputArray[1...].map { $0.split(separator: " ").map{ Int($0) ?? 0 } }

var boardStartIndex = 0
var boardEndIndex = 4
var boardsArray = [[Set<Int>]]()
while boardEndIndex < allBoardRowsArray.count {  
    var currentBoardArray = [Set<Int>]()

    // Add each board row
    for x in boardStartIndex ... boardEndIndex {
        let rowSet = Set(allBoardRowsArray[x])
        currentBoardArray.append(rowSet)
    }
    
    // Add each board column
    for boardColumn in 0 ..< 5 {
        var columnSet = Set<Int>()
        for x in boardStartIndex ... boardEndIndex {
            let test = allBoardRowsArray[x][boardColumn]
            columnSet.insert(test)
        }
        currentBoardArray.append(columnSet)
    }

    // Add all board rows and columns as a full board
    boardsArray.append(currentBoardArray)
    
    boardStartIndex += 5
    boardEndIndex += 5
}

print("Part1: \(part1(boardsArray, bingoNumbers)) Part2: \(part2(boardsArray, bingoNumbers))")

// swiftc -o AdventOfCodeDay4 AdventOfCodeDay4.swift; ./AdventOfCodeDay4
