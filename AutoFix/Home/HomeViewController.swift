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

    let collectionView: UICollectionView = {
        
        let _flowLayout = UICollectionViewFlowLayout()

        // edit properties here
        _flowLayout.itemSize = CGSize(width: 70, height: 110)
        _flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        _flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        _flowLayout.minimumInteritemSpacing = 0.0
        
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: _flowLayout)
        collectionView.register(MakeCell.self, forCellWithReuseIdentifier: MakeCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
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
        
        // searchBar
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search for cars"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        navigationItem.titleView = searchBar
        
        tableView.keyboardDismissMode = .interactive
        collectionView.keyboardDismissMode = .interactive
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
                    self.collectionView.reloadData()
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
