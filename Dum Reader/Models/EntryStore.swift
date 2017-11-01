import Foundation

protocol EntryStoreDelegate {
    func didLoadEntries()
}

class EntryStore {
    static let shared = EntryStore()

    var delegate: EntryStoreDelegate?
    var entries = [Entry]()
    var feeds = [Feed]()

    func load() {
        Router.hit(.subscriptions, handler: subscriptionsHandler)
    }

    private func subscriptionsHandler(data: Data?, response: URLResponse?, error: Error?) {
        guard let data = data,
            let feeds = try? JSONDecoder().decode([Feed].self, from: data)
            else { fatalError() }

        self.feeds = feeds
        Router.hit(.unreadEntries, handler: unreadEntriesHandler)
    }

    private func unreadEntriesHandler(data: Data?, response: URLResponse?, error: Error?) {
        guard let data = data,
            let entryIds = try? JSONDecoder().decode([Int].self, from: data)
            else { fatalError() }

        Router.hit(.entries(ids: entryIds), handler: entriesHandler)
    }

    private func entriesHandler(data: Data?, response: URLResponse?, error: Error?) {
        guard let data = data,
            let entries = try? JSONDecoder.apiDecoder().decode([Entry].self, from: data)
            else { fatalError() }

        self.entries = entries
        delegate?.didLoadEntries()
    }
}

private extension DateFormatter {
    class func apiDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }
}

private extension JSONDecoder {
    class func apiDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.apiDateFormatter())
        return decoder
    }
}
