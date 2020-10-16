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
        var currentlySelectedTile: Tile? = nil
    }

    struct Tile: Codable {
        var id: Int = 0
        var state: State = .default
        var title: String = ""
        var image: UIImage? = nil

        enum State: String {
            case `default`
            case incorrect
            case success
            case verify
        }

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case title = "name"
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(title, forKey: .title)
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            try id = container.decode(Int.self, forKey: .id)
            try title = container.decode(String.self, forKey: .title)
        }

        init() {
            self.title = ""
            self.state = .default
            self.id = 0
            self.image =  nil
        }
    }

    var state: State
    let cal: Calendar = Calendar.current
    let startTime: Date = Date()
    let duration: TimeInterval = 1441 * 60
    let formatter = DateComponentsFormatter()
    let service: MainService = MainService()
    var notificationName = Notification.Name("updatedState")

    init(initialState: State) {
        state =  initialState
        beginTimer()
//        service.fetchTileObjects { [self] tiles in
//            state.tiles = tiles
//            DispatchQueue.main.async {
//                NotificationCenter.default.post(name: notificationName, object: nil)
//            }
//        }
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

    func getTile(with id: Int) -> Tile? {
        state.tiles.first(where: { $0.id == id })
    }

    func updateSelectedTile(with id: Int, tileState: Tile.State, image: UIImage? = nil) {
        guard let tileIndex = state.tiles.firstIndex(where: { $0.id == id }) else {
            return
        }

        var selectedTile = state.tiles.remove(at: tileIndex)
        selectedTile.state = tileState
        selectedTile.image = image
        state.tiles.insert(selectedTile, at: tileIndex)
        DispatchQueue.main.async { [self] in
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
    }

    func verifyMatch(with image: UIImage, for id: Int) {
        guard var tile = state.tiles.first(where: { $0.id == id }) else {
            //TODO: Handle
            return
        }

        tile.image = image

        service.validate(tile) { isSuccess in
            if isSuccess {
                self.updateSelectedTile(with: id, tileState: .success)
            } else {
                self.updateSelectedTile(with: id, tileState: .incorrect)
            }
        }
    }
}
