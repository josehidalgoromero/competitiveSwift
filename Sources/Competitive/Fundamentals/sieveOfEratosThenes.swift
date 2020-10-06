import Foundation
import ArgumentParser

struct SieveEratosthenes: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Get a list of prime numbers up to specific limit")

    @Argument(help: "Limit of the list to get the prime numbers from")
    private var upperLimit: Int

    @Flag(name: .long, help: "Show extra logging for debugging purposes")
    private var verbose: Bool = false

    func run() throws {
        let startTime = Date()

        var prime: [Int:Bool] = [:]

        // Array init
        if verbose { print("Array init up to \(upperLimit)") }
        
        for index in 0...upperLimit {
            prime[index] = true
        }
        
        for index in 2...upperLimit/2 {
            if verbose { print("Checking index \(index)") }
            if let isPrime = prime[index], isPrime {
                if verbose { print("\(index) is prime. Marking multiples of \(index) as false") }
                // mark all index multiple as false primes
                for i in stride(from: index*2, to: upperLimit, by: index) {
                    if verbose { print("    Marked \(i) as not prime") }
                    prime[i] = false
                }
            } else {
                if verbose { print("\(index) is not prime. Skipping") }
            }
        }
        
        let primes = prime.filter { $0.1 == true }.keys.sorted(by: { $0 < $1 })
        print("------------------------------------------------")
        print("Prime numbers up to \(upperLimit): \(primes)")
        print("------------------------------------------------")

        let endTime = Date()
        print("[ Exec time: \(endTime.timeIntervalSince(startTime)) ms ]")
    }
}

