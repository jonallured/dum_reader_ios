import Foundation

struct Entry: Codable {
    let date: String
//    var feed: Feed?
    let title: String
    let url: String
    let feedId: Int
    let id: Int

    var feedName: String {
        return "omg"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case feedId = "feed_id"
        case title
        case date = "published"
        case url
    }
}
