import Foundation

struct Entry: Codable {
    let date: Date
//    var feed: Feed?
    let feedId: Int
    let id: Int
    let title: String
    let url: String

    var dateString: String {
        return DateFormatter.shortDate().string(from: date)
    }

    var feedName: String {
        return "omg"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.date = try container.decode(Date.self, forKey: .date)
        self.feedId = try container.decode(Int.self, forKey: .feedId)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
    }

    enum CodingKeys: String, CodingKey {
        case date = "published"
        case feedId = "feed_id"
        case id
        case title
        case url
    }
}

private extension DateFormatter {
    class func shortDate() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
