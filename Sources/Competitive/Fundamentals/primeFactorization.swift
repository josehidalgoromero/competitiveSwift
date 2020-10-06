import Foundation
import ArgumentParser

struct PrimeFactorization: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Factorize a given number in its prime numbers")

    @Argument(help: "The number to factorize")
    private var number: Int

    @Flag(name: .long, help: "Apply frute force implementation")
    private var brute: Bool = false

    @Flag(name: .long, help: "Show extra logging for debugging purposes")
    private var verbose: Bool = false

    func run() throws {
        let startTime = Date()

        let result = brute ? bruteForceFactorization(of: number) : optimizedFactorization(of: number)        
        let sortedResult = result.sorted( by: { $0.0 < $1.0 } )
        
        print("------------------------------------------------")
        print("Factorization result:")
        for (factor,exp) in sortedResult {
            print(" - \(factor)^\(exp)")
        }
        print("------------------------------------------------")

        let endTime = Date()
        print("[ Exec time: \(endTime.timeIntervalSince(startTime)) ms ]")
    }
    
    // Optimized: O(√n)
    fileprivate func optimizedFactorization(of n:Int) -> [Int:Int] {
        var num = n
        var div = 2
        var factorization: [Int:Int] = [:]
        
        while (num>1 && div*div<=num) {
            var k = 0
            
            if verbose { print("Checking \(div) divisor...") }
            
            while (num % div == 0) {
                num = num / div
                k = k + 1
                if verbose {
                    print("    \(div) is divisor")
                    print("    Result of division \(num)")
                }
            }
            
            if k > 0 {
                factorization[div] = k
            }
            
            div = div + 1
        }
        
        if num>1 {
            factorization[num] = 1
        }
        
        return factorization
    }
    
    // Brute force: O(n)
    fileprivate func bruteForceFactorization(of n:Int) -> [Int:Int] {
        var num = n
        var div = 2
        var factorization: [Int:Int] = [:]
        
        while (num>1) {
            var k = 0
            
            if verbose { print("Checking \(div) divisor...") }
            
            while (num % div == 0) {
                num = num / div
                k = k + 1
                if verbose {
                    print("    \(div) is divisor")
                    print("    Result of division \(num)")
                }
            }
            
            if k > 0 {
                factorization[div] = k
            }
            
            div = div + 1
        }
        
        return factorization
    }
}
