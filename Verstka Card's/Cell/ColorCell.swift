//
//  ColorCell.swift
//  Verstka Card's
//
//  Created by Василий Тихонов on 07.07.2024.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
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
    
    func setCell(colors: [String]) {
        let gradient = ViewManager.shared.getGradient(frame: CGRect(origin: .zero, size: CGSize(width: 62, height: 62)), colors: colors)
        self.layer.addSublayer(gradient)
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        self.addSubview(checkImage)
        
        NSLayoutConstraint.activate([
        
            checkImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            checkImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),

        ])
    }
    
    func selectItem() {
        checkImage.isHidden = false
        
    }
    
    func deselectItem() {
        checkImage.isHidden = true
    }
    
    
}
