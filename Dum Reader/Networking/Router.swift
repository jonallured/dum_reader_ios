import Foundation

struct Router {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void

    static func hit(_ endpoint: Endpoint, handler: Handler? = nil) {
        let basePath = "https://api.feedbin.com"
        let url = URL(string: "\(basePath)\(endpoint.path)")!
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        let passwordString = "\(feedbinUsername):\(feedbinPassword)"
        let passwordData = passwordString.data(using: .utf8)!
        let encodedCredentials = passwordData.base64EncodedString()
        let authString = "Basic \(encodedCredentials)"
        request.addValue(authString, forHTTPHeaderField: "Authorization")

        // might not need this?
        if let data = endpoint.data {
            request.httpBody = data
        }

        let task: URLSessionDataTask

        if let handler = handler {
            task = URLSession.shared.dataTask(with: request, completionHandler: handler)
        } else {
            task = URLSession.shared.dataTask(with: request)
        }

        task.resume()
    }
}
