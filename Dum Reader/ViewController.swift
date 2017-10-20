//
//  ViewController.swift
//  Dum Reader
//
//  Created by Jonathan Allured on 10/18/17.
//  Copyright © 2017 Jonathan Allured. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate {
    @IBAction func buttonTapped(_ sender: Any) {
        let url = URL(string: "http://jonallured.com")!
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = true
        let svc = SFSafariViewController(url: url, configuration: configuration)
        svc.delegate = self
        self.present(svc, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

