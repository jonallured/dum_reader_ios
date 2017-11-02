import UIKit

class StatusLabel: UILabel {
    var count: Int? {
        didSet {
            if let count = count {
                let date = Date()
                text = "\(count) unread as of \(date)"
            } else {
                text = "loading..."
            }
        }
    }
}
