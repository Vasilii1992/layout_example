//
//  IconCell.swift
//  Verstka Card's
//
//  Created by Василий Тихонов on 07.07.2024.
//

import UIKit

class IconCell: UICollectionViewCell {
    
   private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 44).isActive = true
        image.widthAnchor.constraint(equalToConstant: 44).isActive = true
        image.layer.opacity = 0.2
    
        return image
    }()
    
    private lazy var checkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "checkmark")
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 24).isActive = true
        image.heightAnchor.constraint(equalToConstant: 24).isActive = true
        image.isHidden = true

        return image
    }()
    
    
    func setIcon(icon: UIImage) {
        imageView.image = icon
        self.addSubview(imageView)
        self.addSubview(checkImage)
        self.backgroundColor = UIColor(hex: "#1F1F1FFF")
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),

            checkImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            checkImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        ])
        
    }
    
    func selectItem() {
        checkImage.isHidden = false
        
    }
    
    func deselectItem() {
        checkImage.isHidden = true
    }
}
