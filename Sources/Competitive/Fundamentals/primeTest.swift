import Foundation
import ArgumentParser

struct PrimeTest: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Check if a number from the given input is prime")

    @Argument(help: "The number to check")
    private var number: Int

    @Flag(name: .long, help: "Show extra logging for debugging purposes")
    private var verbose: Bool = false

    func run() throws {
        let startTime = Date()
                
        for index in 2..<number {
            if verbose { print("Check if \(number) is divisible by \(index)") }
            if (number % index == 0) {
                print("------------------------------------------------")
                print("\(number) is not prime")
                print("------------------------------------------------")
                let endTime = Date()
                print("[ Exec time: \(endTime.timeIntervalSince(startTime)) ms ]")
                return
            }
        }
        print("------------------------------------------------")
        print("\(number) is prime")
        print("------------------------------------------------")
        let endTime = Date()
        print("[ Exec time: \(endTime.timeIntervalSince(startTime)) ms ]")
    }
}
