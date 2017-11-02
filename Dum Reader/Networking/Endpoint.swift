import Foundation

enum Endpoint {
    case entries(ids: [Int])
    case unreadEntries
    case destroyUnreadEntries(ids: [Int])
    case createRecentlyReadEntries(ids: [Int])
    case createStarredEntries(ids: [Int])
    case subscriptions

    var data: Data? {
        switch self {
        case .createRecentlyReadEntries(let ids):
            let payload = ["recently_read_entries": ids]
            let json = try? JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
            return json
        case .createStarredEntries(let ids):
            let payload = ["starred_entries": ids]
            let json = try? JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
            return json
        case .destroyUnreadEntries(let ids):
            let payload = ["unread_entries": ids]
            let json = try? JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
            return json
        default:
            return nil
        }
    }

    var method: String {
        switch self {
        case .createRecentlyReadEntries, .createStarredEntries:
            return "POST"
        case .destroyUnreadEntries:
            return "DELETE"
        default:
            return "GET"
        }
    }

    var path: String {
        switch self {
        case .entries(let ids):
            let idList = ids.flatMap { String($0) }.joined(separator: ",")
            return "/v2/entries.json?ids=\(idList)"
        case .destroyUnreadEntries, .unreadEntries:
            return "/v2/unread_entries.json"
        case .createStarredEntries:
            return "/v2/starred_entries.json"
        case .createRecentlyReadEntries:
            return "/v2/recently_read_entries.json"
        case .subscriptions:
            return "/v2/subscriptions.json"
        }
    }
}
