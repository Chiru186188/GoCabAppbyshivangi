////
////  AboutViewController.swift
////  Driver
////
////  Copyright © 2018 minimalistic apps. All rights reserved.
////
//
//import UIKit
//import Eureka
//
//class AboutViewController: FormViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        form +++ Section(header: NSLocalizedString("Info", comment: ""), footer: NSLocalizedString("© 2019 Minimalistic Apps All rights reserved.", comment: ""))
//            <<< LabelRow(){
//                $0.title = NSLocalizedString("Application Name", comment: "")
//                $0.value = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
//            }
//            <<< LabelRow(){
//                $0.title = NSLocalizedString("Version", comment: "")
//                $0.value = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
//            }
//            <<< LabelRow(){
//                $0.title = NSLocalizedString("Website", comment: "")
//                $0.value = "http://www.ridy.io"
//            }
//            <<< LabelRow(){
//                $0.title = NSLocalizedString("Phone Number", comment: "")
//                $0.value = "-"
//        }
//    }
//}
import UIKit
import Eureka

//class AboutViewController: FormViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Setting the background color
//        self.view.backgroundColor = UIColor.white
//
//        // Adding a header image
//        let headerImageView = UIImageView(image: UIImage(named: "logo_go_cab")) // Replace "yourImageName" with your actual image name
//        headerImageView.contentMode = .scaleAspectFit
//        headerImageView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(headerImageView)
//
//        // Adding constraints to the header image
//        NSLayoutConstraint.activate([
//            headerImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            headerImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            headerImageView.widthAnchor.constraint(equalToConstant: 200), // Adjust the width as needed
//            headerImageView.heightAnchor.constraint(equalToConstant: 200) // Adjust the height as needed
//        ])
//
//        // Creating the form
//        form +++ Section(header: NSLocalizedString("Info", comment: ""), footer: NSLocalizedString("© 2019 Minimalistic Apps All rights reserved.", comment: ""))
//            <<< LabelRow() {
//                $0.title = NSLocalizedString("Application Name", comment: "")
//                $0.value = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
//            }
//            <<< LabelRow() {
//                $0.title = NSLocalizedString("Version", comment: "")
//                $0.value = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
//            }
//            <<< LabelRow() {
//                $0.title = NSLocalizedString("Website", comment: "")
//                $0.value = "http://www.ridy.io"
//            }
//            <<< LabelRow() {
//                $0.title = NSLocalizedString("Phone Number", comment: "")
//                $0.value = "-"
//            }
//
//        // Adjusting form appearance
//        form[0].header?.height = { return 0.1 }
//        form[0].footer?.height = { return 30 }
//
//        for row in form.allRows {
//            row.baseCell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//            row.baseCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
//            row.baseCell.detailTextLabel?.textColor = UIColor.darkGray
//        }
//    }
//}
import UIKit

class AboutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    let logoImageView = UIImageView(image: UIImage(named: "logo_go_cab")) // Replace "logo" with your image name

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupLogoImageView()
        setupTableView()
    }

    func setupLogoImageView() {
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 250),
            logoImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = nil
        tableView.backgroundColor = .white
       // tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.isScrollEnabled = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 2
//        } else {
//            return 2
//        }
        
        return 2
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 1 {
//            return 40 // Adjust the height as needed
//        }
//        return 0.1 // Set a minimal height for other sections
//    }


//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 1 {
//            let headerView = UIView()
//            headerView.backgroundColor = UIColor.white
//
//            let headerLabel = UILabel()
//            headerLabel.font = UIFont.systemFont(ofSize: 16) // Change the font size and style as needed
//            headerLabel.textColor = UIColor.black
//            headerLabel.translatesAutoresizingMaskIntoConstraints = false
//            headerLabel.text = NSLocalizedString("Contact Information", comment: "")
//            headerView.addSubview(headerLabel)
//
//            NSLayoutConstraint.activate([
//                headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
//                headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
//            ])
//
//            return headerView
//
//        }else{
////            let headerView = UIView()
////            headerView.backgroundColor = UIColor.white
////
////            let headerLabel = UILabel()
////            headerLabel.font = UIFont.systemFont(ofSize: 16) // Change the font size and style as needed
////            headerLabel.textColor = UIColor.black
////            headerLabel.translatesAutoresizingMaskIntoConstraints = false
////            headerLabel.text = ""
////            headerView.addSubview(headerLabel)
////
////            NSLayoutConstraint.activate([
////                headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
////                headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
////            ])
////
//            return nil
//        }
//
//    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text = NSLocalizedString("Go Cabs Driver application.", comment: "")
            } else if indexPath.row == 1 {
                cell.textLabel?.textAlignment = .left

                cell.textLabel?.text = NSLocalizedString("Version development 0.1", comment: "")
            }
        } else if indexPath.section == 1 {
            
            
            if indexPath.row == 0 {
                cell.textLabel?.textAlignment = .left
                cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)//UIFont.systemFont(ofSize: 18)
                cell.textLabel?.text = NSLocalizedString("Contact Information", comment: "")
                cell.textLabel?.textColor = .gray
            }
            else if indexPath.row == 1 {
                cell.textLabel?.textAlignment = .left
                cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
                cell.imageView?.image = UIImage(named: "copyright")
                cell.textLabel?.text = NSLocalizedString("Legal Notices", comment: "")
            }
            
           
        }
        
        return cell
    }
}
