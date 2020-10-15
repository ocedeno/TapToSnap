import Foundation

final class MainService {
    let session = URLSession.shared

    func createURL() -> URL? {
        URL(string: "https://hoi4nusv56.execute-api.us-east-1.amazonaws.com/iositems/items")
    }

    func createURLRequest(with url: URL, method: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method

        return request
    }

    func fetchTileObjects() {
        guard let url = createURL() else {
            return
        }

        let task = session.dataTask(with: createURLRequest(with: url, method: "GET")) { (data: Data?, response: URLResponse?, error: Error?) -> () in
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return
            }

            guard error == nil else {
                //Handle Network Error
                return
            }

            guard let data = data else {
                //Handle flow if data is empty
                return
            }

            print(data)
            if let json = try? JSONSerialization.jsonObject(with: data) as? [MainViewModel.Tile] {
                //TODO: Post notification
                print(json)
            }
        }

        task.resume()
    }

    func validate(_ tile: MainViewModel.Tile) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: tile),
              let url = createURL() else {
            return
        }

        let task = session.uploadTask(with: createURLRequest(with: url, method: "POST"), from: jsonData) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return
            }

            guard error == nil else {
                //Handle Network Error
                return
            }

            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                //Handle flow if data is empty
                return
            }

            if let isValid = json["matched"] as? Bool {
                //TODO: Post notification
                print(isValid)
            }
        }

        task.resume()
    }
}