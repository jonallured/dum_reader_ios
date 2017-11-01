import Foundation

struct Entry: Codable {
    let date: Date
//    var feed: Feed?
    let title: String
    let url: String
    let feedId: Int
    let id: Int

    var dateString: String {
        return DateFormatter.shortDate().string(from: date)
    }

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

private extension DateFormatter {
    class func shortDate() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
