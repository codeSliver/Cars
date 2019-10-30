//
//  ListViewController.swift
//  Cars
//
//  Created by Arslan Faisal on 28/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import UIKit

/// shows list of cars in a table view
class ListViewController: UIViewController {

    @IBOutlet weak var carsTableView: UITableView!
    var viewModel: ListViewModel? {
        didSet {
            reloadDataOnMainThread()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
}
//MARK:- View Model setup
extension ListViewController {
    /// Binds view  model closures
    private func bindViewModel() {
        viewModel?.cars.bind({ [weak self] _ in
            self?.reloadDataOnMainThread()
        })
    }
    
    /// Reload table view on main thread as closure call backs to update datasource  can be sent over background thread
    private func reloadDataOnMainThread()  {
        DispatchQueue.main.async { [weak self] in
            self?.carsTableView.reloadData()
        }
    }
}
//MARK:- UITableView delegate and Data source methods
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.numberOfCars()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.carCellIdentifier, for: indexPath) as? CarTableViewCell, let vm = viewModel, let car = vm.carAtIndex(index: indexPath.section) else { return UITableViewCell() }
        
        cell.setupCell(car)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
