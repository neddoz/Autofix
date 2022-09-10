//
//  ListingCell.swift
//  AutoFix
//
//  Created by kayeli dennis on 09/09/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ListingCell: UITableViewCell {

    // Subviews
    
    let carImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        imageview.backgroundColor = .black
        imageview.clipsToBounds = true
        return imageview
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateOfManufactureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "favorite-favorite_symbol"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let reviewsLabel: UIButton = {
        let button = IconInfoButton(icon: .init(named: "star-star_fill1_symbol") ?? UIImage(), title: "")
        button.tintColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let mileageInfoLabel: UIButton = {
        let button = IconInfoButton(icon: .init(named: "av_timer-av_timer_symbol") ?? UIImage(), title: "")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 10)
        return button
    }()
    
    let usageInfoLabel: UIButton = {
        let button = IconInfoButton(icon: .init(named: "av_timer-av_timer_symbol") ?? UIImage(), title: "")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 10)
        return button
    }()
     
    let LocationInfoLabel: UIButton = {
        let button = IconInfoButton(icon: .init(named: "av_timer-av_timer_symbol") ?? UIImage(), title: "")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 10)
        return button
    }()
    
    let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubViews()
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel.accept(nil)
    }
    
    func setUpWith(viewModel: ListingCellViewModel) {
        self.viewModel.accept(viewModel)
    }
    
    private func bind() {
        viewModel
            .asDriver()
            .drive(onNext: { [weak self] viewModel in
            guard let vm = viewModel else { return }
                
                self?.carImageView.loadImage(vm.iconURL)
                self?.priceLabel.text = vm.price
                self?.dateOfManufactureLabel.text = vm.yearOfManufucture
                self?.titleLabel.attributedText = vm.title
                
                self?.mileageInfoLabel.setTitle(vm.mileage, for: .normal)
                self?.LocationInfoLabel.setTitle(vm.location, for: .normal)
                self?.usageInfoLabel.setTitle(vm.usage, for: .normal)
                self?.reviewsLabel.setTitle(vm.reviewsRating, for: .normal)
                
            }).disposed(by: disposeBag)

    }
    
    fileprivate var viewModel = BehaviorRelay<ListingCellViewModel?>(value: nil)
    fileprivate let disposeBag = DisposeBag()
}


// MARK: Configuring of Subviews

extension ListingCell {
    
    fileprivate func configureSubViews() {
        
        contentView.addSubview(carImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateOfManufactureLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(priceLabel)
        contentView.addSubview(reviewsLabel)

        infoStackView.addArrangedSubview(mileageInfoLabel)
        infoStackView.addArrangedSubview(usageInfoLabel)
        infoStackView.addArrangedSubview(LocationInfoLabel)
        contentView.addSubview(infoStackView)
        
        // ImageView Constraint
        
        carImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        carImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        carImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        carImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true

        // Like Button  constraint
        likeButton.topAnchor.constraint(equalTo: carImageView.topAnchor, constant: 5).isActive = true
        likeButton.rightAnchor.constraint(equalTo: carImageView.rightAnchor, constant: -5).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        // Year of Manufacture label
        dateOfManufactureLabel.leftAnchor.constraint(equalTo: carImageView.leftAnchor, constant: 10).isActive = true
        dateOfManufactureLabel.bottomAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: -5).isActive = true
        dateOfManufactureLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dateOfManufactureLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true

        // make constraint
        titleLabel.leadingAnchor.constraint(equalTo: dateOfManufactureLabel.trailingAnchor, constant: 5).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: -5).isActive = true
        
        // Price label constraint
        priceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        priceLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 10).isActive = true
        priceLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1).isActive = true
        
        // review label constraint
        reviewsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        reviewsLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant:  10).isActive = true
        reviewsLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1).isActive = true

        // Info stack view
        infoStackView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20).isActive = true
        infoStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        infoStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        infoStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
    }
}
