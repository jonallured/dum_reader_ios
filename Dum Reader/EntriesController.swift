import UIKit
import SafariServices

class EntriesController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    var entries = [Entry]()

    override func viewDidLoad() {
        super.viewDidLoad()

        Router.hit(.unreadEntries, handler: unreadEntriesHandler)

        tableView.delegate = self
        tableView.dataSource = self
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

private extension DateFormatter {
    class func apiDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
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
