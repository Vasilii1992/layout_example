//
//  ViewBuilder.swift
//  Verstka Card's
//
//  Created by Василий Тихонов on 05.07.2024.
//

import UIKit

final class ViewBuilder: NSObject {
    
    private let manager = ViewManager.shared
    private var card = UIView()
    private let balance: Float = 9.999
    private let cardNumber: Int = 1234
    
    private var colorCollection: UICollectionView!
    private var imageCollection: UICollectionView!


    
    
    var controller: UIViewController
    var view: UIView
    
    var cardColor: [String] = ["#16A085FF","#003F32FF"] {

        // вилсет нужен для того чтоб когда мы меняем карточку, чтоб цвет карты менялся
        willSet {
            // находим на нашем вью именно вью с цветов, мы ей дали для этого тег
            if let colorView = view.viewWithTag(7) {
                // если нашли то удаляем лэер
                colorView.layer.sublayers?.remove(at: 0)
                
                let gradient = manager.getGradient(colors: newValue)
                // и устанавливаем лэер с тем же тегом чтобы потом опять его найти и поменять
                colorView.layer.insertSublayer(gradient, at: 0)
            }
        }
    }
    
    var cardIcon: UIImage = .icon1 {
        willSet {
            if let imageView = view.viewWithTag(8) as? UIImageView {
                
                imageView.image = newValue
            }
        }
    }
    
    init(controller: UIViewController) {
        self.controller = controller
        self.view = controller.view
    }
    
    // во virwBilder сразу объявим то что будет только один раз и не будет переиспользоваться
    
    private lazy var pageTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18,weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
 
        return label
    }()
    
    func setPageTitle(title: String) {
        pageTitle.text = title
        view.addSubview(pageTitle)
        
        NSLayoutConstraint.activate([
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            pageTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

        
        
        ])
        
    }
    
    func getCard() {
        
        card = manager.getCard(colors: cardColor,
                               balance: balance,
                               cardNumber: cardNumber,
                               cardImage: cardIcon)
        
        view.addSubview(card)
        
        NSLayoutConstraint.activate([
        
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            card.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 30)
        
            
        ])
        
    }
    
    func getColorSlider() {
        
        let colorTitle = manager.slideTitle(titleText: "Select color")
        
        colorCollection = manager.getCollection(id: RestoreId.colors.rawValue,dataSource: self, delegate: self)
        colorCollection.register(ColorCell.self, forCellWithReuseIdentifier: "cell")
        
        
        
        view.addSubview(colorTitle)
        view.addSubview(colorCollection)
        
        NSLayoutConstraint.activate([
        
            colorTitle.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 50),
            colorTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            colorTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            colorCollection.topAnchor.constraint(equalTo: colorTitle.bottomAnchor, constant: 20),
            colorCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            colorCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            

        ])
// так я сделал выбор первой ячейки сразу
        DispatchQueue.main.async {
            let firstIndexPath = IndexPath(item: 0, section: 0)
            self.colorCollection.selectItem(at: firstIndexPath, animated: false, scrollPosition: [])
            self.collectionView(self.colorCollection, didSelectItemAt: firstIndexPath)
        }
   
    }
    
    func setIconSlider() {
        let iconSliderTitle = manager.slideTitle(titleText: "Add shapes")
        
        imageCollection = manager.getCollection(id: RestoreId.images.rawValue, dataSource: self, delegate: self)
        imageCollection.register(IconCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(iconSliderTitle)
        view.addSubview(imageCollection)
        NSLayoutConstraint.activate([
            iconSliderTitle.topAnchor.constraint(equalTo: colorCollection.bottomAnchor, constant: 40),
            iconSliderTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            iconSliderTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            imageCollection.topAnchor.constraint(equalTo: iconSliderTitle.bottomAnchor, constant: 20),
            imageCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),

        ])
        // так я сделал выбор первой ячейки сразу

        DispatchQueue.main.async {
            let firstIndexPath = IndexPath(item: 0, section: 0)
            self.imageCollection.selectItem(at: firstIndexPath, animated: false, scrollPosition: [])
            self.collectionView(self.imageCollection, didSelectItemAt: firstIndexPath)
        }

    }
    
    func setDescriptionText() {
        let description: UILabel = {
            let text = UILabel()
            text.text = "Don't worry. You can always change the design of your virtual card later. Just enter the settings."
            text.textColor = UIColor(hex: "#6F6F6FFF")
            text.setLineHeight(lineHeight: 10)
            text.numberOfLines = 0
            text.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
            text.translatesAutoresizingMaskIntoConstraints = false
            return text
        }()
        
        view.addSubview(description)
        
        NSLayoutConstraint.activate([
        
            description.topAnchor.constraint(equalTo: imageCollection.bottomAnchor, constant: 40),
            description.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            description.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

        ])
    }
    
    func addContinueBtn() {
        let btn = {
            let btn = UIButton(primaryAction: nil)
            btn.setTitle("Continue", for: .normal)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 20
            btn.setTitleColor(.black, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .bold)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.heightAnchor.constraint(equalToConstant: 60).isActive = true
            btn.layer.shadowColor = UIColor.white.cgColor
            btn.layer.shadowRadius = 10
            btn.layer.shadowOpacity = 0.5
            return btn
        }()
        
        view.addSubview(btn)
        
        NSLayoutConstraint.activate([
        
            btn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            btn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            btn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),

        ])
    }
    
    
}


// наш вью билдер это не вью контроллер который наследуется обычно от NSObject и по этому когда я хочу реализовать делегаты, то меня просят реализовать Все методы, Чтобы того не было, нужно подписать наш класс на NSObject
extension ViewBuilder: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.restorationIdentifier {
        case RestoreId.colors.rawValue:
            return manager.colors.count
        case RestoreId.images.rawValue:
            return manager.images.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        switch collectionView.restorationIdentifier {
            
        case RestoreId.colors.rawValue:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ColorCell {
               // в таблице пишут row, в коллекции пишут item, а так одно и тоже
                let color = manager.colors[indexPath.item]
                cell.setCell(colors: color)
                return cell
            }
        case RestoreId.images.rawValue:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? IconCell {
                let icon = manager.images[indexPath.item]
                cell.setIcon(icon: icon)
                
                return cell
            }
        default:
            return UICollectionViewCell()
            
        }
        
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView.restorationIdentifier {
        case RestoreId.colors.rawValue:
            let colors = manager.colors[indexPath.item]
            self.cardColor = colors
            
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cell?.selectItem()
            
        case RestoreId.images.rawValue:
            let icons = manager.images[indexPath.item]
            self.cardIcon = icons
            
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell
            cell?.selectItem()
      
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
        case RestoreId.colors.rawValue:
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cell?.deselectItem()
        case RestoreId.images.rawValue:
            let cell = collectionView.cellForItem(at: indexPath) as? IconCell
            cell?.deselectItem()
        default:
            return
        }
        
    }
}

enum RestoreId: String {
    case colors,images
}
