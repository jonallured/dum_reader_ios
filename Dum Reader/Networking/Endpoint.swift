import Foundation

enum Endpoint {
    case entries(ids: [Int])
    case unreadEntries
    case starredEntries
    case recentlyReadEntries
    case subscriptions

    var data: Data? {
        return nil
    }

    var method: String {
        return "GET"
    }

    var path: String {
        switch self {
        case .entries(let ids):
            let idList = ids.flatMap { String($0) }.joined(separator: ",")
            return "/v2/entries.json?ids=\(idList)"
        case .unreadEntries:
            return "/v2/unread_entries.json"
        case .starredEntries:
            return "/v2/starred_entries.json"
        case .recentlyReadEntries:
            return "/v2/recently_read_entries.json"
        case .subscriptions:
            return "/v2/subscriptions.json"
        }
    }
}
