//
//  PackagesViewController.swift
//  Pony-Express
//
//  Created by Josh Dinges on 7/16/20.
//  Copyright © 2020 Josh Dinges. All rights reserved.
//

import UIKit

protocol PackageDelegate: AnyObject {
    func createNewPackage(_ package: Package)
}

final class PackagesViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!

    private(set) var packages = [
        Package(trackingNumber: "abc123", carrier: "FedEx", description: "Sample Package")
    ] {
        didSet {
            tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let createPackageNavigationViewController = segue.destination as? UINavigationController, let createPackageViewController = createPackageNavigationViewController.viewControllers.first as? CreatePackageViewController else { return }
        createPackageViewController.packageDelegate = self
    }
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

extension PackagesViewController: PackageDelegate {
    func createNewPackage(_ package: Package) {
        packages.append(package)
    }
}
