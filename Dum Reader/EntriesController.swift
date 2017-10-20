import UIKit
import SafariServices

let feeds = [
    Feed(name: "Heroku"),
    Feed(name: "FiveThirtyEight"),
    Feed(name: "Swift.org")
]

let entries: [Entry] = [
    Entry(date: "10/17/17", feed: feeds[0], title: "PostgreSQL 10 Now Available in Beta on Heroku Postgres", url: "https://blog.heroku.com/postgres-10-beta"),
    Entry(date: "10/17/17", feed: feeds[1], title: "A Blood Test Promised To Make Me A Better Runner, But It Just Made Me Worry I Pee Too Much", url: "https://fivethirtyeight.com/features/a-blood-test-promised-to-make-me-a-better-runner-but-it-just-made-me-worry-i-pee-too-much/"),
    Entry(date: "10/17/17", feed: feeds[2], title: "Swift 4.1 Release Process", url: "https://swift.org/blog/swift-4-1-release-process/"),
    Entry(date: "10/17/17", feed: feeds[0], title: "PostgreSQL 10 Now Available in Beta on Heroku Postgres", url: "https://blog.heroku.com/postgres-10-beta"),
    Entry(date: "10/17/17", feed: feeds[0], title: "PostgreSQL 10 Now Available in Beta on Heroku Postgres", url: "https://blog.heroku.com/postgres-10-beta"),
    Entry(date: "10/17/17", feed: feeds[0], title: "PostgreSQL 10 Now Available in Beta on Heroku Postgres", url: "https://blog.heroku.com/postgres-10-beta"),
    Entry(date: "10/17/17", feed: feeds[0], title: "PostgreSQL 10 Now Available in Beta on Heroku Postgres", url: "https://blog.heroku.com/postgres-10-beta"),
    Entry(date: "10/17/17", feed: feeds[0], title: "PostgreSQL 10 Now Available in Beta on Heroku Postgres", url: "https://blog.heroku.com/postgres-10-beta"),
    Entry(date: "10/17/17", feed: feeds[0], title: "PostgreSQL 10 Now Available in Beta on Heroku Postgres", url: "https://blog.heroku.com/postgres-10-beta"),
    Entry(date: "10/17/17", feed: feeds[0], title: "PostgreSQL 10 Now Available in Beta on Heroku Postgres", url: "https://blog.heroku.com/postgres-10-beta"),
    Entry(date: "10/17/17", feed: feeds[0], title: "PostgreSQL 10 Now Available in Beta on Heroku Postgres", url: "https://blog.heroku.com/postgres-10-beta"),
    Entry(date: "10/17/17", feed: feeds[0], title: "PostgreSQL 10 Now Available in Beta on Heroku Postgres", url: "https://blog.heroku.com/postgres-10-beta")
]

class EntriesController: UIViewController {
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        Router.hit(.unreadEntries, handler: unreadEntriesHandler)

        tableView.delegate = self
        tableView.dataSource = self
    }

    private func unreadEntriesHandler(data: Data?, response: URLResponse?, error: Error?) {
        print(data, response, error)
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
