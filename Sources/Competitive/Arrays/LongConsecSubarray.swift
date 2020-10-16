import Foundation
import ArgumentParser

struct LongConsecSubarray: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Calculate the longest consecutive subarray")
    
    // Have two conditions to be true:
    // 1. All numbers in subarray must be different
    // 2. (Max - Min + 1) in subarray must be the numbers in subarray
    // execution order: O(n^2)

    @Argument(help: "Array of numbers")
    private var intArray: [Int]

    @Flag(name: .long, help: "Show extra logging for debugging purposes")
    private var verbose: Bool = false

    func run() throws {
        let startTime = Date()

        var fr = [Int:Bool]()
        var leftIndex = 0
        var rightIndex = 0
        var answer = 0
        
        for left in 0..<intArray.count-1 {
            if verbose { print("Reset dictionary and min/max values") }
            fr.removeAll()

            if verbose { print("Set left index to \(left)") }
            var minValue = intArray[left]
            var maxValue = intArray[left]

            for right in left+1..<intArray.count {
                if verbose { print("Set right index to \(right)") }

                if let numberExists = fr[right], numberExists {
                    if verbose { print("Found duplicate number (\(intArray[right]) in current subarray)") }
                    break
                }
                
                fr[right] = true
                minValue = min(minValue, intArray[right])
                maxValue = max(maxValue, intArray[right])
                if verbose { print("Min: \(minValue) - Max: \(maxValue)") }

                if (right - left == maxValue - minValue) {
                    if (right-left+1)>answer {
                        answer = right-left+1
                        leftIndex = left
                        rightIndex = right
                    }
                }
            }
        }
        
        print("------------------------------------------------")
        print("Max consecutive subarray is \(answer) length")
        print("[\(leftIndex):\(rightIndex)] = \(Array(intArray[leftIndex...rightIndex]))")
        print("------------------------------------------------")

        let endTime = Date()
        print("[ Exec time: \(endTime.timeIntervalSince(startTime)) ms ]")
    }
}
