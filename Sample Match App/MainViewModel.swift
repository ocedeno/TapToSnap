import Foundation
//This is not ideal to be including UIKit into viewModel, but for the sake of not having to convert the returned image into another format, I have included it.
import UIKit

final class MainViewModel {
    struct State {
        var tiles: [Tile]

        //To handle and maintain awareness of Timer
        var runningTime: TimeInterval = 0
        var time: Date = Date()
        var countdownText: String = ""
    }

    let cal: Calendar = Calendar.current
    let startTime: Date = Date()
    let duration: TimeInterval = 1441 * 60
    let formatter = DateComponentsFormatter()

    struct Tile {
        var state: State = .default
        var title: String = ""
        var image: UIImage? = nil

        enum State {
            case `default`
            case incorrect
            case success
            case verify
        }
    }



    var state: State

    init(initialState: State) {
        state =  initialState
    }

    func beginTimer() {
        repeat {
            state.time = cal.date(byAdding: .minute, value: 1, to: state.time) ?? Date()
            state.runningTime = state.time.timeIntervalSince(startTime)

            if state.runningTime < duration {
                state.countdownText = formatter.string(from: duration - state.runningTime) ?? ""
            }
        } while state.runningTime > duration
    }
}
