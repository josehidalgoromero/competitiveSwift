import Foundation
import ArgumentParser

struct SubcommandTemplate: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Description of the subcommand purpose")

    @Argument(help: "Mandatory parameter")
    private var argument: Int

    @Option(name: .shortAndLong, help: "Optional parameter")
    private var optional: Int?

    @Flag(name: .long, help: "Show extra logging for debugging purposes")
    private var verbose: Bool = false

    func run() throws {
        let startTime = Date()

        let endTime = Date()
        print("[ Exec time: \(endTime.timeIntervalSince(startTime)) ms ]")
    }
}
