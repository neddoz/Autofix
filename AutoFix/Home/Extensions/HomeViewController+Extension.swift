//
//  HomeViewController+Extension.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//

import UIKit

extension HomeViewController {
    
    func setUpUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.backgroundView = activityIndicator
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        collectionView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(ListingCell.self, forCellReuseIdentifier: ListingCell.reuseIdentifier)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: ListingCell.reuseIdentifier,
                                     for: indexPath) as? ListingCell, let viewModel = viewModel else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.setUpWith(viewModel: viewModel.item(for: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return collectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {return}
        let item = viewModel.item(for: indexPath.row)
        AppRouter.shared.presentImageDetailViewController(for: item.listingID)
    }
}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOFMakes() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: MakeCell.reuseIdentifier,
                                     for: indexPath) as? MakeCell, let make = viewModel?.make(at: indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.bind(item: make)
        return cell
    }
}
