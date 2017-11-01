import Foundation

struct Entry: Codable {
    let date: Date
    let feedId: Int
    let id: Int
    let title: String
    let url: String

    var dateString: String {
        return DateFormatter.shortDate().string(from: date)
    }

    lazy var feed: Feed = {
        return EntryStore.shared.feeds.first { $0.id == feedId }!
    }()

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
