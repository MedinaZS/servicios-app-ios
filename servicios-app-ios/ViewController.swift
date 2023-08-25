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
    @IBOutlet weak var tableView: UITableView!
    
    var servicesList : Dictionary = [String: [String]]()
    var sKeys : [String] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up the design of buttons
        setUpTabsButtons()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //Get the list
        servicesList = getServices()
        sKeys = getServicesKeys()
        
    }
    
}

//MARK: Tab bar
extension ViewController {
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

//MARK: - Tableview
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Total count of elements divide by 4 display elements in the row
        let displayElements = 4
        let key = sKeys[section]
        let totalCount = servicesList[key]?.count ?? 0
        
        //Calculate the number of rows
        let totalRowsDecimal = Decimal(totalCount) / Decimal(displayElements)
        var totalRows = NSDecimalNumber(decimal: totalRowsDecimal).doubleValue
        totalRows = ceil(totalRows)
        
        //        print("Total rows \(totalRows)")
        
        return Int(totalRows)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //        print("Sections \(servicesList.count)")
        return servicesList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ServiceTableViewCell
        
        var imageList : [UIImageView] = []
        var labelList : [UILabel] = []
        
        imageList.append(cell.image1)
        imageList.append(cell.image2)
        imageList.append(cell.image3)
        imageList.append(cell.image4)
        
        labelList.append(cell.label1)
        labelList.append(cell.label2)
        labelList.append(cell.label3)
        labelList.append(cell.label4)
        
        
        //Get the info
        let row = indexPath.row
        let col = indexPath.section
        let numberOfElements = 4
        
        //Get the data
        let key = sKeys[col]
        
//        print("Row \(row) Section \(col) key \(key)")
        
        let startIndex = row * numberOfElements
        var endIndex = startIndex + numberOfElements
        let totalElements = servicesList[key]?.count
        
        //If endIndex is > totalElements
        if endIndex > totalElements! {
            print("Entra aca")
            endIndex = totalElements!
        }
        
        /// Get the subarray for example: key [phoneServices][elements 0 to 4]
        let optionalSubArray = servicesList[key]?[startIndex..<endIndex]
        var data : [String] = []
        
        /// Unwrap the subarray and convert to an Array
        if let optionalSubArray{
            data = Array(optionalSubArray)
        } else {
            print("The optional slice is nil.")
        }
        
        print("Data for row \(String(describing: data[0])) count \(data.count)")

        //Loop with the number of elements display for every row
        for index in 0..<numberOfElements {
            
            //Si el indice recorrido es menor al total de datos para la fila colocar los datos
            if index < data.count {
                imageList[index].image = UIImage(named: data[index].lowercased())
                labelList[index].text = data[index]
            }else{
                imageList[index].isHidden = true
                labelList[index].isHidden = true
            }
            
        }
        
        
        return cell
    }

    
    
}


//MARK: TableView DELEGATE Methods
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Section title \(section)"
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
//        header.backgroundColor = .green
        
    
        //Generate a stackview
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.alignment = .fill
//        horizontalStackView.backgroundColor = .red
        
        horizontalStackView.frame = CGRect(x: 5, y: 5, width: header.frame.size.width-10, height: header.frame.size.height-10)
        
        header.addSubview(horizontalStackView)
        
        
        
        // Create Labels
        let titleLabel = UILabel()
        titleLabel.text = sKeys[section]
        titleLabel.textAlignment = .left
        titleLabel.textColor = .darkGray
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)

        let showMoreLabel = UILabel()
        showMoreLabel.text = "Mostrar Mas"
        showMoreLabel.textAlignment = .right
        showMoreLabel.font = .systemFont(ofSize: 18, weight: .bold)
        showMoreLabel.textColor = .darkRed

        //Add labels to stackview
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(showMoreLabel)
        
        //Border view
        let borderView = UIView(frame: CGRect(x: 5, y: header.frame.size.height-5, width: header.frame.size.width-10, height: 3))
        borderView.backgroundColor = .systemGray5
        
        header.addSubview(borderView)
        
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}


