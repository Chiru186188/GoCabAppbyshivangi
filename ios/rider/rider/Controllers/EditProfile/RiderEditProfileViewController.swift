////
////  EditProfileViewController.swift
////  Rider
////
////  Copyright © 2018 minimalistic apps. All rights reserved.
////
//
//import UIKit
//import Eureka
import SPAlert
import ImageRow
import Kingfisher

//class RiderEditProfileViewController: FormViewController {
//    var downloading = false
//    var rider: Rider!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        rider = try! Rider(from: UserDefaultsConfig.user!)
//        form +++ Section(NSLocalizedString("Images", comment: "Profile's image section header"))
//            <<< ImageRow() {
//                $0.tag = "profile_row"
//                $0.title = NSLocalizedString("Profile Image", comment: "Profile's image field title")
//                $0.allowEditor = true
//                $0.useEditedImage = true
//                if let address = rider.media?.address {
//                    let url = URL(string: Config.Backend + address.replacingOccurrences(of: " ", with: "%20"))
//                    ImageDownloader.default.downloadImage(with: url!, completionHandler: { result in
//                        switch result {
//                        case .success(let value):
//                            self.downloading = true
//                            (self.form.rowBy(tag: "profile_row")! as! ImageRow).value = value.image
//                            (self.form.rowBy(tag: "profile_row")! as! ImageRow).reload()
//                            self.downloading = false
//                        case .failure(let error):
//                            print(error)
//                        }
//                    })
//                }
//                $0.sourceTypes = .PhotoLibrary
//                $0.clearAction = .no
//                }.onChange {
//                    if(!self.downloading) {
//                        let data = $0.value?.jpegData(compressionQuality: 0.7)
//                        $0.title = NSLocalizedString("Uploading, Please wait...", comment: "Uploading image state")
//                        $0.disabled = true
//                        $0.reload()
//                        UpdateProfileImage(data: data!).execute() { result in
//                            self.form.rowBy(tag: "profile_row")!.title = NSLocalizedString("Profile Image", comment: "Profile's image field title")
//                            self.form.rowBy(tag: "profile_row")!.disabled = false
//                            self.form.rowBy(tag: "profile_row")!.reload()
//                            switch result {
//                            case .success(let response):
//                                SPAlert.present(title: NSLocalizedString("Profile image updated", comment: ""), preset: .done)
//                                self.rider.media = response
//                                UserDefaultsConfig.user = try! self.rider.asDictionary()
//
//                            case .failure(let error):
//                                error.showAlert()
//                            }
//                        }
//                    }
//                }
//                .cellUpdate { cell, row in
//                    cell.accessoryView?.layer.cornerRadius = 17
//                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
//            }
//            +++ Section(NSLocalizedString("Basic Info", comment: "Profile Basic Info section header"))
//            <<< PhoneRow(){
//                $0.title = NSLocalizedString("Mobile Number", comment: "Profile Mobile Number field title")
//                $0.disabled = true
//                $0.value = String(rider.mobileNumber!)
//            }
//            <<< EmailRow(){
//                $0.title = NSLocalizedString("E-Mail", comment: "Profile Email field title")
//                $0.value = rider.email
//            }.onChange { self.rider.email = $0.value }
//            <<< TextRow(){
//                $0.title = NSLocalizedString("Name", comment: "Profile Name field")
//                $0.value = rider.firstName
//                $0.placeholder = NSLocalizedString("First Name", comment: "Profile First Name Field")
//                }.onChange { self.rider.firstName = $0.value }
//            <<< TextRow(){
//                $0.title = " "
//                $0.placeholder = NSLocalizedString("Last Name", comment: "Profile Last Name field")
//                $0.value = rider.lastName
//                }.onChange { self.rider.lastName = $0.value }
//            +++ Section(NSLocalizedString("Additional Info", comment: "Profile's additional Info section"))
//            <<< PushRow<String>() {
//                $0.title = NSLocalizedString("Gender", comment: "Profile's gender field title")
//                $0.selectorTitle = NSLocalizedString("Select Your Gender", comment: "Profile's gender field selector title")
//                $0.options = ["Male","Female","Unspecified"]
//                $0.value = rider.gender?.capitalizingFirstLetter()
//            }.onChange { self.rider.gender = ($0.value! as String).lowercased() }
//            <<< TextRow(){
//                $0.title = NSLocalizedString("Address", comment: "Profile Address field title")
//                $0.value = rider.address
//                }.onChange { self.rider.address = $0.value }
//    }
//    @IBAction func onSaveProfileClicked(_ sender: Any) {
//        UpdateProfile(user: self.rider).execute() { result in
//            switch result {
//            case .success(_):
//                _ = self.navigationController?.popViewController(animated: true)
//                UserDefaultsConfig.user = try! self.rider.asDictionary()
//
//            case .failure(let error):
//                error.showAlert()
//            }
//        }
//    }
//}
//import UIKit
//import SPAlert
//import Kingfisher
//
//class RiderEditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    var downloading = false
//    var rider: Rider!
//
//    // UI Elements
//    let scrollView = UIScrollView()
//    let contentView = UIView()
//    let profileImageView = UIImageView()
//    let mobileNumberLabel = UILabel()
//    let emailTextField = UITextField()
//    let firstNameTextField = UITextField()
//    let lastNameTextField = UITextField()
//    let genderSegmentedControl = UISegmentedControl(items: ["Male", "Female", "Unspecified"])
//    let addressTextField = UITextField()
//    let saveButton = UIButton(type: .system)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        rider = try! Rider(from: UserDefaultsConfig.user!)
//
//        setupUI()
//        layoutUI()
//        populateData()
//    }
//
//    func setupUI() {
//        view.backgroundColor = .white
//        title = "Edit Profile"
//
//        // Setup ScrollView and ContentView
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//
//        // Profile Image View
//        profileImageView.contentMode = .scaleAspectFill
//        profileImageView.layer.cornerRadius = 50
//        profileImageView.layer.masksToBounds = true
//        profileImageView.isUserInteractionEnabled = true
//        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
//        contentView.addSubview(profileImageView)
//
//        // Mobile Number Label
//        mobileNumberLabel.text = NSLocalizedString("Mobile Number", comment: "Profile Mobile Number field title")
//        contentView.addSubview(mobileNumberLabel)
//
//        // Email TextField
//        emailTextField.placeholder = NSLocalizedString("E-Mail", comment: "Profile Email field title")
//        emailTextField.borderStyle = .roundedRect
//        contentView.addSubview(emailTextField)
//
//        // First Name TextField
//        firstNameTextField.placeholder = NSLocalizedString("First Name", comment: "Profile First Name Field")
//        firstNameTextField.borderStyle = .roundedRect
//        contentView.addSubview(firstNameTextField)
//
//        // Last Name TextField
//        lastNameTextField.placeholder = NSLocalizedString("Last Name", comment: "Profile Last Name field")
//        lastNameTextField.borderStyle = .roundedRect
//        contentView.addSubview(lastNameTextField)
//
//        // Gender Segmented Control
//        genderSegmentedControl.selectedSegmentIndex = 0
//        contentView.addSubview(genderSegmentedControl)
//
//        // Address TextField
//        addressTextField.placeholder = NSLocalizedString("Address", comment: "Profile Address field title")
//        addressTextField.borderStyle = .roundedRect
//        contentView.addSubview(addressTextField)
//
//        // Save Button
//        saveButton.setTitle(NSLocalizedString("Save", comment: "Save button title"), for: .normal)
//        saveButton.addTarget(self, action: #selector(onSaveProfileClicked), for: .touchUpInside)
//        contentView.addSubview(saveButton)
//    }
//
//    func layoutUI() {
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        profileImageView.translatesAutoresizingMaskIntoConstraints = false
//        mobileNumberLabel.translatesAutoresizingMaskIntoConstraints = false
//        emailTextField.translatesAutoresizingMaskIntoConstraints = false
//        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
//        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
//        genderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
//        addressTextField.translatesAutoresizingMaskIntoConstraints = false
//        saveButton.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//
//            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
//            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            profileImageView.widthAnchor.constraint(equalToConstant: 100),
//            profileImageView.heightAnchor.constraint(equalToConstant: 100),
//
//            mobileNumberLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
//            mobileNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            mobileNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//
//            emailTextField.topAnchor.constraint(equalTo: mobileNumberLabel.bottomAnchor, constant: 20),
//            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//
//            firstNameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
//            firstNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            firstNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//
//            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20),
//            lastNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            lastNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//
//            genderSegmentedControl.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20),
//            genderSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            genderSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//
//            addressTextField.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: 20),
//            addressTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            addressTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//
//            saveButton.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
//            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
//        ])
//    }
//
//    func populateData() {
//        if let address = rider.media?.address {
//            let url = URL(string: Config.Backend + address.replacingOccurrences(of: " ", with: "%20"))
//            profileImageView.kf.setImage(with: url)
//        }
//        mobileNumberLabel.text = NSLocalizedString("Mobile Number: ", comment: "Profile Mobile Number field title") + String(rider.mobileNumber!)
//        emailTextField.text = rider.email
//        firstNameTextField.text = rider.firstName
//        lastNameTextField.text = rider.lastName
//        if let gender = rider.gender?.capitalizingFirstLetter() {
//            genderSegmentedControl.selectedSegmentIndex = ["Male", "Female", "Unspecified"].firstIndex(of: gender) ?? 0
//        }
//        addressTextField.text = rider.address
//    }
//
//    @objc func selectProfileImage() {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        present(imagePicker, animated: true, completion: nil)
//    }
//
//    @objc func onSaveProfileClicked() {
//        rider.email = emailTextField.text
//        rider.firstName = firstNameTextField.text
//        rider.lastName = lastNameTextField.text
//        rider.gender = ["male", "female", "unspecified"][genderSegmentedControl.selectedSegmentIndex]
//        rider.address = addressTextField.text
//
//        UpdateProfile(user: self.rider).execute() { result in
//            switch result {
//            case .success(_):
//                _ = self.navigationController?.popViewController(animated: true)
//                UserDefaultsConfig.user = try! self.rider.asDictionary()
//
//            case .failure(let error):
//                error.showAlert()
//            }
//        }
//    }
//
//    // MARK: - UIImagePickerControllerDelegate
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[.originalImage] as? UIImage {
//            profileImageView.image = image
//            let data = image.jpegData(compressionQuality: 0.7)
//            // Upload the image
//            UpdateProfileImage(data: data!).execute() { result in
//                switch result {
//                case .success(let response):
//                    SPAlert.present(title: NSLocalizedString("Profile image updated", comment: ""), preset: .done)
//                    self.rider.media = response
//                    UserDefaultsConfig.user = try! self.rider.asDictionary()
//
//                case .failure(let error):
//                    error.showAlert()
//                }
//            }
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//}
import UIKit

class RiderEditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // UI Elements
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let profileImageView = UIImageView()
    let uploadButton = UIButton()
    let mobileNumberTextField = UITextField()
    let emailTextField = UITextField()
    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let genderSegmentedControl = UISegmentedControl(items: ["Male", "Female", "Transgender"])
    let addressTextField = UITextField()
    let saveButton = UIBarButtonItem()
    let logoutButton = UIButton()
    let deleteAccountButton = UIButton()
    
    var rider: Rider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rider = try! Rider(from: UserDefaultsConfig.user!)
        setupUI()
        populateData()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        title = "Your Account"
        // Navigation Bar
        saveButton.title = "SAVE"
        saveButton.style = .done
        saveButton.target = self
        saveButton.action = #selector(onSaveProfileClicked)
        navigationItem.rightBarButtonItem = saveButton
        
        // Scroll View and Content View
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Profile Image View
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        contentView.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Upload Button
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        uploadButton.setImage(UIImage(systemName: "icloud.and.arrow.up.fill"), for: .normal)
        uploadButton.backgroundColor = UIColor(named: "ThemeYellow")
        uploadButton.tintColor = .black
        uploadButton.layer.cornerRadius = 20
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        contentView.addSubview(uploadButton)
        
        NSLayoutConstraint.activate([
            uploadButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            uploadButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            uploadButton.widthAnchor.constraint(equalToConstant: 40),
            uploadButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Mobile Number Text Field
        setupTextField(mobileNumberTextField, placeholder: "Mobile Number", isEnabled: false)
        mobileNumberTextField.text =  String(rider.mobileNumber!)
        
        // Email Text Field
        setupTextField(emailTextField, placeholder: "E-Mail")
        emailTextField.text = rider.email
        
        // First Name Text Field
        setupTextField(firstNameTextField, placeholder: "First Name")
        firstNameTextField.text = rider.firstName
        
        // Last Name Text Field
        setupTextField(lastNameTextField, placeholder: "Last Name")
        lastNameTextField.text = rider.lastName
        
        // Gender Segmented Control
        genderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(genderSegmentedControl)
        
        genderSegmentedControl.selectedSegmentIndex = rider.gender == "male" ? 0 : rider.gender == "female" ? 1 : 2
        
        NSLayoutConstraint.activate([
            genderSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genderSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            genderSegmentedControl.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20),
            genderSegmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Address Text Field
        setupTextField(addressTextField, placeholder: "Your Address")
        addressTextField.text = rider.address
        
        // Logout Button
        setupButton(logoutButton, title: "Log out", titleColor: .blue)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        // Delete Account Button
        setupButton(deleteAccountButton, title: "Delete my account", titleColor: .red)
        deleteAccountButton.addTarget(self, action: #selector(deleteAccountButtonTapped), for: .touchUpInside)
    }
    
    func setupTextField(_ textField: UITextField, placeholder: String, isEnabled: Bool = true) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        textField.isEnabled = isEnabled
        contentView.addSubview(textField)
        
        let previousView = contentView.subviews[contentView.subviews.count - 2]
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textField.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupButton(_ button: UIButton, title: String, titleColor: UIColor) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        contentView.addSubview(button)
        
        let previousView = contentView.subviews[contentView.subviews.count - 2]
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            button.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func populateData() {
        if let address = rider.media?.address {
            let url = URL(string: Config.Backend + address.replacingOccurrences(of: " ", with: "%20"))
            ImageDownloader.default.downloadImage(with: url!, completionHandler: { result in
                switch result {
                case .success(let value):
                    self.profileImageView.image = value.image
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    
    @objc func uploadButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func onSaveProfileClicked() {
        rider.email = emailTextField.text
        rider.firstName = firstNameTextField.text
        rider.lastName = lastNameTextField.text
        rider.gender = genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex)?.lowercased()
        rider.address = addressTextField.text
        
        UpdateProfile(user: self.rider).execute() { result in
            switch result {
            case .success(_):
                UserDefaultsConfig.user = try! self.rider.asDictionary()
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                error.showAlert()
            }
        }
    }
    
    @objc func logoutButtonTapped() {
        // Handle logout
    }
    
    @objc func deleteAccountButtonTapped() {
        // Handle account deletion
    }
    
    // UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
            
            let data = selectedImage.jpegData(compressionQuality: 0.7)
            UpdateProfileImage(data: data!).execute() { result in
                switch result {
                case .success(let response):
                    SPAlert.present(title: "Profile image updated", preset: .done)
                    self.rider.media = response
                    UserDefaultsConfig.user = try! self.rider.asDictionary()
                case .failure(let error):
                    error.showAlert()
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
