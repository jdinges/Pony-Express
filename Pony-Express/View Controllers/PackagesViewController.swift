//
//  PackagesViewController.swift
//  Pony-Express
//
//  Created by Josh Dinges on 7/16/20.
//  Copyright © 2020 Josh Dinges. All rights reserved.
//

import UIKit

final class PackagesViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!

    private(set) var packages = [
        Package(trackingNumber: "abc123", carrier: "FedEx", description: "Sample Package")
    ]
}

extension PackagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        packages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let packageCell = tableView.dequeueReusableCell(withIdentifier: PackageCell.defaultReuseIdentifier) as? PackageCell
            else { return UITableViewCell() }
        let package = packages[indexPath.row]
        packageCell.package = package
        return packageCell
    }
}
