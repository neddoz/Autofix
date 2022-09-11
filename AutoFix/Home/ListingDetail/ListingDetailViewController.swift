//
//  ListingDetailViewController.swift
//  AutoFix
//
//  Created by kayeli dennis on 11/09/2022.
//

import Foundation
import UIKit
import RxSwift


class ListingDetailViewController: UIViewController {
    
    // TODO: Replace with a carousel for the car media
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let tableView = UITableView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let viewModel: ListingDetailViewModel

    init(viewModel: ListingDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        setUpUI()
        bind()
    }
    
    func bind() {
        viewModel.infoItems.bind(to: tableView.rx.items(cellIdentifier: UITableViewCell.reuseIdentifier)) { row, item, cell in
           cell.textLabel?.text = "\(item.key):     \(item.value)"
        }.disposed(by: disposeBag)
        
        viewModel
            .imageURL
            .asDriver()
            .drive(onNext: { [weak self] value in
            guard let value = value else {return}
                self?.titleLabel.text = self?.viewModel.title
                self?.imageView.sd_setImage(with: value, placeholderImage: UIImage(named: "placeholder"))
            }).disposed(by: disposeBag)

        viewModel
            .error
            .skip(1)
            .asObservable()
            .subscribe { error in
                guard let error = error.element else { return }
                DispatchQueue.main.async {
                    if let error = error as? NetworkError {
                        self.showAlert("That didn't work!", body: error.errorMessage())
                    } else {
                        self.showAlert("That didn't work!", body: NetworkError.other.errorMessage())
                    }
                }
            }.disposed(by: disposeBag)
    }

    private let disposeBag = DisposeBag()
}



