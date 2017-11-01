import UIKit
import SafariServices

class EntriesController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    var entryStore = EntryStore()

    var entries: [Entry] {
        return entryStore.entries
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        entryStore.delegate = self
        entryStore.load()
    }
}

extension EntriesController: EntryStoreDelegate {
    func didLoadEntries() {
        DispatchQueue.main.async(execute: tableView.reloadData)
    }
}

extension EntriesController: UITableViewDelegate {
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
