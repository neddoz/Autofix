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
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(ListingCell.self, forCellReuseIdentifier: ListingCell.reuseIdentifier)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
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
        cell.setUpWith(viewModel: viewModel.item(for: indexPath.row))
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let viewModel = viewModel else {return}
//        let item = viewModel.item(for: indexPath.row)
//        if let datum = item.data.first,
//           let urString = item.links.first?.href.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
//           let url = URL(string: urString) {
//            AppRouter.shared.presentImageDetailViewController(for: datum, imageURL: url)
//        }
//    }
}
