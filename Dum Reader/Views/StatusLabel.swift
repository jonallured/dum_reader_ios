import UIKit

class StatusLabel: UILabel {
    var count: Int? {
        didSet {
            if let count = count {
                let timestamp = DateFormatter.timestamp().string(from: Date())
                text = "\(count) unread as of \(timestamp)"
            } else {
                text = "loading..."
            }
        }
    }
}

private extension DateFormatter {
    class func timestamp() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}
