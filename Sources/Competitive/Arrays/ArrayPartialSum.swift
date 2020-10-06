import Foundation
import ArgumentParser

struct ArrayPartialSum: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Calculate partial sum of array")

    @Argument(help: "Start index of partial sum (position starts in 1)")
    private var startIndex: Int

    @Argument(help: "End index of partial sum")
    private var endIndex: Int

    @Argument(help: "Array of numbers")
    private var intArray: [Int]

    @Flag(name: .long, help: "Show extra logging for debugging purposes")
    private var verbose: Bool = false

    func run() throws {
        guard startIndex>0 else {
            print("Error: Start index must be greater than 0")
            return
        }
        guard endIndex>1 else {
            print("Error: End index must be greater than 1")
            return
        }
        guard endIndex<=intArray.count else {
            print("Error: End index must be lower than array count (\(intArray.count))")
            return
        }
        guard endIndex-startIndex>0 else {
            print("Error: End index must be greater than start index")
            return
        }

        let startTime = Date()

        let partialSumArray = buildPartialSumArray(intArray)
        if verbose { print("Partial sums array: \(partialSumArray)") }

        let startPartialSum = partialSumArray[startIndex-1]
        let endPartialSum = partialSumArray[endIndex]

        if verbose { print("Partial sum of x-1 (\(startIndex-1)):\(startPartialSum)") }
        if verbose { print("Partial sum of y (\(endIndex)):\(endPartialSum)") }

        let partialSum = endPartialSum - startPartialSum
        
        print("------------------------------------------------")
        print("Partial sum from \(startIndex) to \(endIndex): \(partialSum)")
        print("------------------------------------------------")

        let endTime = Date()
        print("[ Exec time: \(endTime.timeIntervalSince(startTime)) ms ]")
    }
    
    fileprivate func buildPartialSumArray(_ array:[Int]) -> [Int] {
        var partialSumArray:[Int] = []
        partialSumArray.append(0)
        for i in 1...array.count {
            partialSumArray.append(partialSumArray[i-1]+array[i-1])
        }
        return partialSumArray
    }
}
