import Foundation
import ArgumentParser

struct Competitive: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to execute several competitive programming tests",
        subcommands: [
            PrimeTest.self,
            PrimeFactorization.self,
            SieveEratosthenes.self,
            FastModularExp.self,
            PigeonHole.self,
            ArrayPartialSum.self,
            MaxSumSubarray.self
        ])

    init() { }
}

Competitive.main()
