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

    func fetchTileObjects(completion: @escaping ([MainViewModel.Tile]) -> () ) {
        guard let url = createURL() else {
            return
        }

        session.dataTask(with: createURLRequest(with: url, method: "GET")) { (data: Data?, response: URLResponse?, error: Error?) -> () in
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
            if let defaultTiles = try? JSONDecoder().decode([MainViewModel.Tile].self, from: data) {
                completion(defaultTiles)
            }
        }.resume()
    }

    func validate(_ tile: MainViewModel.Tile, completion: @escaping (Bool) -> ()) {
        guard let jsonData = try? JSONEncoder().encode(tile),
              let url = createURL() else {
            return
        }

        session.uploadTask(with: createURLRequest(with: url, method: "POST"), from: jsonData) { data, response, error in
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
                return completion(isValid)
            }
        }.resume()
    }
}