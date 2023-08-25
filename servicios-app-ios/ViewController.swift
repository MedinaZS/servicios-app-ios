//
//  ViewController.swift
//  servicios-app-ios
//
//  Created by Montserrat Medina on 2023-08-25.
//

import UIKit

extension UIColor {
    static var  lightRed = UIColor(red: 1.00, green: 0.80, blue: 0.80, alpha: 1.00)
    static var  darkRed = UIColor(red: 0.60, green: 0.20, blue: 0.20, alpha: 1.00)
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var inicioButton: UIButton!
    @IBOutlet weak var cuentasButton: UIButton!
    @IBOutlet weak var tarjetasButton: UIButton!
    @IBOutlet weak var serviciosButton: UIButton!
    @IBOutlet weak var prestamosButton: UIButton!
    
    var tabsButton : [UIButton] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
        setUpTabsButtons()
    }
    
    private func setUpTabsButtons(){
        tabsButton.append(inicioButton)
        tabsButton.append(cuentasButton)
        tabsButton.append(tarjetasButton)
        tabsButton.append(serviciosButton)
        tabsButton.append(prestamosButton)
        
        for button in tabsButton {
            button.layer.cornerRadius = 10
        }
    }
    
    
    
    @IBAction func tabButtonTapped(_ sender: UIButton) {
        for button in tabsButton {
            button.backgroundColor = .white
            button.titleLabel?.textColor = .lightGray
        }
        
        sender.backgroundColor = .lightRed
        sender.setTitleColor(.darkRed, for: .normal)
        
    }
    
}

