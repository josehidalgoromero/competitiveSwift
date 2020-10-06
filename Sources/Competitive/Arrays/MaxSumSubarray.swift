import Foundation
import ArgumentParser

struct MaxSumSubarray: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Calculate the maximum sum of a subarray from given array")

    @Argument(help: "Array of numbers")
    private var intArray: [Int]

    @Flag(name: .long, help: "If true then apply greedy approach to calculate max sum, if false then apply partial sums approach")
    private var greedy: Bool = false

    @Flag(name: .long, help: "Show extra logging for debugging purposes")
    private var verbose: Bool = false

    func run() throws {
        let startTime = Date()
        
        let (leftIndex, rightIndex, maxSum) = greedy ? maxSumSubarrayGreedy(intArray) : maxSumSubarrayPartialSums(intArray)
        print("------------------------------------------------")
        print("Max sum subarray is \(maxSum) from \(leftIndex) to \(rightIndex): \(Array(intArray[leftIndex...rightIndex]))")
        print("------------------------------------------------")

        let endTime = Date()
        print("[ Exec time: \(endTime.timeIntervalSince(startTime)) ms ]")
    }

    fileprivate func maxSumSubarrayPartialSums(_ intArray:[Int]) -> (Int, Int, Int) {
        let partialSumsArray = buildPartialSumArray(intArray)
        if verbose { print("    Partial sums array: \(partialSumsArray)") }
        
        var minS = 0
        var ans = 0
        var leftIndex = 0
        var rightIndex = 0

        for index in 0..<partialSumsArray.count {
            if verbose { print("    Current sum for partialSumsArray[\(index)]-minS(\(minS)): \(partialSumsArray[index]-minS)") }
            if partialSumsArray[index]-minS > ans {
                ans = partialSumsArray[index]-minS
                rightIndex = index
                if verbose { print("        New accepted answer. Set index: [\(leftIndex),\(rightIndex)]") }
            }
            if partialSumsArray[index]<minS {
                minS = partialSumsArray[index]
                leftIndex = index+1
                if verbose { print("        New minimum: \(minS). Set left index to: \(leftIndex)") }
            }
        }
        return (leftIndex, rightIndex, ans)
    }
    
    fileprivate func buildPartialSumArray(_ array:[Int]) -> [Int] {
        var partialSumArray:[Int] = []
        partialSumArray.append(array[0])
        for i in 1..<array.count {
            partialSumArray.append(partialSumArray[i-1]+array[i])
        }
        return partialSumArray
    }
    
    fileprivate func maxSumSubarrayGreedy(_ intArray:[Int]) -> (Int, Int, Int) {
        var ans = 0
        var sum = 0
        var leftIndex = 0
        var rightIndex = 0
        
        for index in 0..<intArray.count {
            sum = sum + intArray[index]
            if verbose { print("    Current sum for index [\(leftIndex),\(index)]: \(sum)") }
            if sum>ans {
                ans = sum
                rightIndex = index
                if verbose { print("        New accepted answer. Set index: [\(leftIndex),\(rightIndex)]") }
            }
            if sum<0 {
                sum = 0
                leftIndex = index + 1
                rightIndex = index + 1
                if verbose { print("        Wrong subarray. Set index: [\(leftIndex),\(rightIndex)]") }
            }
        }
        
        return (leftIndex, rightIndex, ans)
    }
}
