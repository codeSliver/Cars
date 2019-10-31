//
//  CarsViewController.swift
//  Cars
//
//  Created by Arslan Faisal on 28/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import UIKit
import MBProgressHUD
/// View with two container views to display list and map views and a segment control
class CarsViewController: UIViewController {
    
    @IBOutlet weak var mapContainerView:    UIView!
    @IBOutlet weak var listContainerView:   UIView!
    @IBOutlet weak var segmentControl:      UISegmentedControl!
    
    var viewModel = CarsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func segmentChanged(_ sender: Any) {
        viewModel.viewType.value = segmentControl.selectedSegmentIndex == 0 ? .list : .map
    }
}
//MARK:- View Model setup
extension CarsViewController: AlertService {
    
    /// Binds view  model closures
    func bindViewModel() {
        viewModel.carsFetchFailed = { [weak self] errorString in
            self?.hideHud()
            self?.showAlert(titleStr: "Error", messageStr: errorString, okButtonTitle: "OK", cancelButtonTitle: nil, response: nil)
        }
        let carsFetched: CarsFetchedCallBack = { [weak self] cars in
            self?.hideHud()
        }
        viewModel.carsFetched.append(carsFetched)
        
        viewModel.viewType.bind { [weak self] viewType in
            switch viewType {
            case .list:
                UIView.animate(withDuration: 0.5, animations: {
                    self?.listContainerView.alpha = 1
                    self?.mapContainerView.alpha  = 0
                })
            case .map:
                UIView.animate(withDuration: 0.5, animations: {
                    self?.listContainerView.alpha = 0
                    self?.mapContainerView.alpha  = 1
                })
            }
        }
        showHud()
        viewModel.fetchCars()
    }
    private func showHud() {
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = .annularDeterminate
        }
    }
    private func hideHud() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
//MARK:- Segue Methods
extension CarsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == Segues.listEmbeddedSegue {
            if let listVC = segue.destination as? ListViewController {
                listVC.viewModel = ListViewModel(viewModel.cars)
                viewModel.carsFetched.append(listVC.viewModel?.carsFetchedCallBack)
            }
        }else if segue.identifier == Segues.mapEmbeddedSegue {
            if let mapVC = segue.destination as? MapViewController {
                mapVC.viewModel = MapViewModel(viewModel.cars)
                viewModel.carsFetched.append(mapVC.viewModel?.carsFetchedCallBack)
            }
        }
    }
}
