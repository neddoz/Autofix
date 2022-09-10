//
//  HomeViewController.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    // Views
    
    let tableView = UITableView()
    let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // viewModel
    
    var viewModel: HomeViewModel? {
        didSet {
            bindViewModel()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        viewModel = HomeViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func bindViewModel() {
        guard isViewLoaded,
              let viewModel = viewModel else { return  }
        
        viewModel
            .isLoading
            .asDriver()
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel
            .items
            .asObservable().subscribe(onNext: { items in
                guard !items.isEmpty else {return}
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
        
        viewModel
            .error
            .asObservable()
            .subscribe { error in
                guard let error = error.element else { return }
                if !(viewModel.isLoading.value) {
                    DispatchQueue.main.async {
                        if let error = error as? NetworkError {
                            self.showAlert("That didn't work!", body: error.errorMessage())
                        } else {
                            self.showAlert("That didn't work!", body: NetworkError.other.errorMessage())
                        }
                    }
                }
        }.disposed(by: disposeBag)
    }
}
