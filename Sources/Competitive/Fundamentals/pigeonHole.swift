import Foundation
import ArgumentParser

struct PigeonHole: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Find a number only with 0's and 1's which is divisible by given number")

    @Argument(help: "Number to be divisible by")
    private var n: Int

    @Flag(name: .long, help: "Show extra logging for debugging purposes")
    private var verbose: Bool = false

    func run() throws {
        let startTime = Date()

        var fr:[Int:Int] = [:]
        
        var cur_rem = 0
        var result = ""

        // i.e. n = 5
        // i=1 -> cur_rem = 1 % n = 1 % 5 = 1
        // i=2 -> cur_rem = 11 % n = 11 % 5 = 1  (same reminder that i=1)
        // result = 11 - 1 = 10

        // i.e. n = 7
        // i=1 -> cur_rem = 1 % n = 1 % 7 = 1
        // i=2 -> cur_rem = 11 % n = 11 % 7 = 4
        // i=3 -> cur_rem = 41 % n = 41 % 7 = 6
        // i=4 -> cur_rem = 61 % n = 61 % 7 = 5
        // i=5 -> cur_rem = 51 % n = 51 % 7 = 2
        // i=6 -> cur_rem = 21 % n = 21 % 7 = 0 (divisible)
        // Divisible number = 111111 (1's six times)

        for i in 1...n {
            if verbose { print("----- Iteration i=\(i) -----") }
            if verbose { print("    Current number: (\(cur_rem)) * 10 + 1 = \(cur_rem * 10 + 1) (Equivalent to \(String(repeating: "1", count: i)))") }
            if verbose { print("        Current remainder: \(cur_rem * 10 + 1) % \(n) = \((cur_rem * 10 + 1) % n)") }
            cur_rem = (cur_rem * 10 + 1) % n
            
            // Found
            if cur_rem == 0 {
                result = String(repeating: "1", count: i)
                if verbose { print("Found divisible number: \(result)") }
                break
            }
            
            if let curr_fr = fr[cur_rem], curr_fr != 0 {
                if verbose { print("    Found remainder \(cur_rem) in frequency table") }
                result = "\(String(repeating: "1", count: i-curr_fr))\(String(repeating: "0", count: curr_fr))"
                break
            }
            
            if verbose { print("            fr[\(cur_rem)]=\(i)") }
            fr[cur_rem] = i
        }
        
        print("------------------------------------------------")
        print("Result number divisible by \(n): \(result)")
        print("------------------------------------------------")

        let endTime = Date()
        print("[ Exec time: \(endTime.timeIntervalSince(startTime)) ms ]")
    }
}
