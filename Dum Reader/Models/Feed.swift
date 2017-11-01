import Foundation

struct Feed: Codable {
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case id = "feed_id"
        case title
    }
}
