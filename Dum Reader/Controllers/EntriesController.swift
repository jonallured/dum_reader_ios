import UIKit
import SafariServices

class EntriesController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusLabel: StatusLabel!

    private let refreshControl = UIRefreshControl()

    var entries: [Entry] {
        return EntryStore.shared.entries
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshStore), for: UIControlEvents.valueChanged)
        EntryStore.shared.delegate = self
        EntryStore.shared.load()
    }

    @objc func refreshStore(_ sender: Any?) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        statusLabel.count = nil
        EntryStore.shared.load()
    }
}

extension EntriesController: EntryStoreDelegate {
    func didUpdateEntries() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.statusLabel.count = EntryStore.shared.entries.count
            self.refreshControl.endRefreshing()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}

extension EntriesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let entry = EntryStore.shared.entries[indexPath.row]

        let action = UIContextualAction(style: .destructive, title: "save") { _, _, completionHandler in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            EntryStore.shared.save(entry: entry)
            completionHandler(true)
        }

        action.backgroundColor = UIColor.green

        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let entry = EntryStore.shared.entries[indexPath.row]

        let action = UIContextualAction(style: .destructive, title: "archive") { _, _, completionHandler in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            EntryStore.shared.archive(entry: entry)
            completionHandler(true)
        }

        action.backgroundColor = UIColor.gray

        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = entries[indexPath.row]

        let url = URL(string: entry.url)!
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = true
        let svc = SFSafariViewController(url: url, configuration: configuration)
        svc.delegate = self
        self.present(svc, animated: true, completion: nil)
    }
}

extension EntriesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Entry", for: indexPath) as? EntryCell else { fatalError() }
        let entry = entries[indexPath.row]
        cell.entry = entry
        return cell
    }
}

extension EntriesController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
