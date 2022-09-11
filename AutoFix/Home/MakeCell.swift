//
//  MakeCell.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//

import Foundation
import UIKit
import SDWebImage

class MakeCell: UICollectionViewCell {
    
    private let carImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    fileprivate let imageViewHeight: CGFloat = 60
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubViews()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func bind(item: Make) {
        let URL: URL = URL(string: item.imageURL) ?? URL(string: "")!
        carImageView.sd_setImage(with: URL, placeholderImage: UIImage(named: "placeholder"))
        infoLabel.text = item.name
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        carImageView.layer.cornerRadius = CGFloat(imageViewHeight / 2)
        carImageView.layer.masksToBounds = true
        carImageView.clipsToBounds = true
        carImageView.layer.borderWidth = 3.0
        carImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        carImageView.image = nil
        infoLabel.text = ""
    }

    fileprivate func configureSubViews() {
        contentView.addSubview(carImageView)
        contentView.addSubview(infoLabel)
        
        
        carImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        carImageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        carImageView.widthAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        carImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        
        infoLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 5).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5).isActive = true
    }
    
}
