import Foundation

enum Endpoint {
    case entries
    case unreadEntries
    case starredEntries
    case recentlyReadEntries

    var data: Data? {
        return nil
    }

    var method: String {
        return "GET"
    }

    var path: String {
        switch self {
        case .entries:
            return "/v2/entries.json"
        case .unreadEntries:
            return "/v2/unread_entries.json"
        case .starredEntries:
            return "/v2/starred_entries.json"
        case .recentlyReadEntries:
            return "/v2/recently_read_entries.json"
        }
    }
}
