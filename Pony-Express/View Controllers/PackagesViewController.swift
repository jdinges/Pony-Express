//
//  PackagesViewController.swift
//  Pony-Express
//
//  Created by Josh Dinges on 7/16/20.
//  Copyright © 2020 Josh Dinges. All rights reserved.
//

import UIKit
import CoreData

protocol PackageDelegate: AnyObject {
    func createNewPackage(_ packageObject: PackageObject)
}

final class PackagesViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!

//    private(set) var packages = [PackageObject(trackingNumber: "abc123", carrier: "FedEx", description: "Sample Package")] {
    private(set) var packages = [NSManagedObject]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext

        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Package")

        //3
        do {
            packages = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
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
//        packageCell.package = package
        packageCell.setUp(trackingNumber: package.value(forKey: "tracking_number") as? String, carrier: package.value(forKey: "courier") as? String, description: package.value(forKey: "name") as? String)
        return packageCell
    }
}

extension PackagesViewController: PackageDelegate {
    func createNewPackage(_ packageObject: PackageObject) {
//        packages.append(package)
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }

        // 1
        let managedContext =
          appDelegate.persistentContainer.viewContext

        // 2
        let entity =
          NSEntityDescription.entity(forEntityName: "Package",
                                     in: managedContext)!

        let package = NSManagedObject(entity: entity,
                                     insertInto: managedContext)

        // 3
        package.setValue(packageObject.trackingNumber, forKeyPath: "tracking_number")
        package.setValue(packageObject.carrier, forKey: "courier")
        package.setValue(packageObject.description, forKey: "name")

        // 4
        do {
          try managedContext.save()
          packages.append(package)
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
