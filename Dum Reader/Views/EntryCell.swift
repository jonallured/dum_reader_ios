import UIKit

class EntryCell: UITableViewCell {
    @IBOutlet weak var feedTitleLabel: UILabel!
    @IBOutlet weak var entryTitleLabel: UILabel!
    @IBOutlet weak var entryDateLabel: UILabel!

    var entry: Entry? {
        didSet {
            feedTitleLabel.text = entry?.feed.title
            entryTitleLabel.text = entry?.title
            entryDateLabel.text = entry?.dateString
        }
    }
}
