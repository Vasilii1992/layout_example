//
//  ViewController.swift
//  Verstka Card's
//
//  Created by Василий Тихонов on 05.07.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var builder = {
        return ViewBuilder(controller: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#141414FF")
        
        builder.setPageTitle(title: "Design your virtual card")
        builder.getCard()
        builder.getColorSlider()
        builder.setIconSlider()
        builder.setDescriptionText()
        builder.addContinueBtn()
        
    }


}

