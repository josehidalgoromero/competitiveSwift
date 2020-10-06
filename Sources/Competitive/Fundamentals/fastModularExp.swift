import Foundation
import ArgumentParser

struct FastModularExp: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Calculate a modular exponentiation from iterative (default) and recursive approach")

    @Argument(help: "Pow base number")
    private var baseNumber: Int

    @Argument(help: "Pow exponent number")
    private var exponentNumber: Int64

    @Argument(help: "Mod number")
    private var modNumber: Int

    @Flag(name: .long, help: "Runs recursive implementation")
    private var recursiveMode: Bool = false

    @Flag(name: .long, help: "Show extra logging for debugging purposes")
    private var verbose: Bool = false

    func run() throws {
        let startTime = Date()
        
        let result = recursiveMode ? recursiveImplementation(base: baseNumber, exp: exponentNumber, mod: modNumber) : iterativeImplementation(base: baseNumber, exp: exponentNumber, mod: modNumber)

        print("------------------------------------------------")
        print("Fast Modular Exponentiation of \(baseNumber)^\(exponentNumber) mod \(modNumber)")
        print("Result: \(result)")
        print("------------------------------------------------")

        let endTime = Date()
        print("[ Exec time: \(endTime.timeIntervalSince(startTime)) ms ]")
    }
    
    fileprivate func recursiveImplementation(base: Int, exp: Int64, mod: Int) -> Int {
        // (a^0) % mod = 1 [base case]
        if exp == 0 { return 1 }
        
        // if exp is even then
        // a^n = (a^2)^(n/2)
        // a^n % mod = [(a^2)^(n/2)] % mod
        if exp % 2 == 0 {
            return recursiveImplementation(base: (base*base), exp: exp/2, mod: mod)
        }
        
        // if exp is odd then
        // a^n = a * (a^(n-1))
        // a^n % mod = [a * a^(n-1)] % mod = [a % mod * a^(n-1) % mod] % mod
        return ((base % mod) * recursiveImplementation(base: base, exp: exp-1, mod: mod)) % mod
    }

    fileprivate func iterativeImplementation(base: Int, exp: Int64, mod: Int) -> Int {
        // (a^n) % mod
        // sample
        // start with ans=1
        // a = 2, n = 13 -> 2^13 [ ans = 1 ]
        // 1. n is odd : 2 * (2^12) -> 2^12 [ ans = 2 * 1 ]
        // 2. n is even: 2^12 = (2^2)^6 = 4^6 [ ans = 2 * 1 = 2 ]
        // 3. n is even: 4^6 = (4^2)^3 = 16^3 [ ans = 2 * 1 = 2 ]
        // 4. n is odd: 16^3 = 16 * 16^2 = 16^2 [ ans = 16 * 2 * 1 = 32 ]
        // 5. n is even: 16^2 = (16^2)^1 = 256^1 [ ans = 16 * 2 * 1 = 32 ]
        // 6. n is odd: 256^1 = 256 * 256^0 = 1 [ ans = 256 * 16 * 2 * 1 = 8192 ]
        
        var ans = 1
        var tmpBase = base
        var tmpExp = exp
        
        while (tmpExp >= 1) {
            if tmpExp % 2 == 0 {
                tmpBase = (tmpBase * tmpBase) % mod
                tmpExp = tmpExp / 2
            } else {
                ans = (ans * tmpBase) % mod
                tmpExp = tmpExp - 1
            }
        }
        
        return ans
    }
}
