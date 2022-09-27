//
//  StartController.swift
//  Message
//
//  Created by Марк Коваль on 07/09/2022.
//

import UIKit

// MARK: StartController
final class StartController: UIViewController, ObjectAnimatable, UITextFieldDelegate {
    
    private let identifier = "myTableCell"
    private let service = MessageService()
    private let dataImage: Data
    private let urlForImage = URL(string: Constants.instance.urlImage)
    private var offsetStart: Int = 0
    private let headerLabel = CustomLabel()
    private let userDefaults = UserDefaults.standard
    var data: [String] = []
    var indexForCell: Int?
    let indicator = CustomActivityIndicator(frame: .zero)
    let messageTable = CustomTableView(frame: .zero)
    let boxMessage = CustomUIView()
    let messageTextField = CustomTextField()
    let messageButton = CustomButton(type: .custom)
    
    // MARK: Life cycle
    init() {
        self.dataImage = try! Data(contentsOf: urlForImage!)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraints()
        createCustomNavigationBar()
        hideKeyboard()
        registerForKeyboardNotifications()
        saveItemFromData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    // MARK: View
    let segmentedControl: UISegmentedControl = {
        
        let segmentedControl = UISegmentedControl(items: ["Light", "Dark"])
        
        segmentedControl.backgroundColor = UIColor(named: "backgroundColor")
        segmentedControl.selectedSegmentTintColor = UIColor(named: "backgroundColor")
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = UIColor(named: "textColor")
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        return segmentedControl
    }()
    
    // MARK: Setting Views
    private func settingViews() {
        headerLabel.text = "Тестовое задание"
        segmentedControl.selectedSegmentIndex = MTUserDefaults.shared.theme.rawValue
        segmentedControl.addTarget(self, action: #selector(activateControl), for: .valueChanged)
        messageTable.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        messageButton.addTarget(self, action: #selector(tapMessageButton), for: .touchUpInside)
        messageButton.isEnabled = false
        messageButton.alpha = 0.5
    }
    
    @objc private func activateControl() {
        MTUserDefaults.shared.theme = Theme(rawValue: segmentedControl.selectedSegmentIndex) ?? .light
        view.window?.overrideUserInterfaceStyle = MTUserDefaults.shared.theme.getUserInterfaceStyle()
    }
    
    @objc private func tapMessageButton() {
        data.insert(messageTextField.text!, at: 0)
        self.userDefaults.object(forKey: "data")
        messageTable.reloadData()
        messageTextField.text?.removeAll()
        messageButton.isEnabled = false
        messageButton.alpha = 0.5
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (messageTextField.text! as NSString).replacingCharacters(in: range, with: string)
        if text.isEmpty {
            messageButton.isEnabled = false
            messageButton.alpha = 0.5
        } else {
            messageButton.isEnabled = true
            messageButton.alpha = 1.0
        }
        return true
    }
    
    func saveItemFromData() {
        configData()
        self.userDefaults.object(forKey: "data")
    }
    
    func deleteItemFromData() {
        data.remove(at: indexForCell ?? 0)
        userDefaults.removeObject(forKey: "data")
        messageTable.reloadData()
    }
    
    // MARK: Setup Views
    private func setUpView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(headerLabel)
        view.addSubview(segmentedControl)
        view.addSubview(messageTable)
        messageTable.delegate = self
        messageTable.dataSource = self
        messageTextField.delegate = self
        settingViews()
    }
    
    private func configData() {
        service.addMessage(offset: offsetStart) { [weak self] result in
            switch result {
            case .success(let dataMessage):
                self?.data = dataMessage
                DispatchQueue.main.async {
                    self?.messageTable.reloadData()
                }
            case.failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Error connecting to the server")
                }
            }
        }
    }
}

// MARK: Delegate
extension StartController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        messageTable.rowHeight = UITableView.automaticDimension
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        offsetStart = data.count
        startAnimateIndicator()
        service.addMessage(offset: offsetStart) { [weak self] result in
            switch result {
            case .success(let dataMessage):
                self?.data += dataMessage
                self?.offsetStart += self?.offsetStart ?? 0
                DispatchQueue.main.async {
                    self?.messageTable.reloadData()
                    self?.stopAnimateIndicator()
                }
            case.failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self?.showAlert(title: "Sorry", message: "No more new messages")
                    self?.stopAnimateIndicator()
                }
            }
        }
    }
}

// MARK: DataSource
extension StartController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageTable.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.backgroundColor = UIColor(named: "backgroundColor")
        let messageList = data[indexPath.row]
        let avatar = dataImage
        
        var content = cell.defaultContentConfiguration()
        content.text = messageList
        content.image = UIImage(data: avatar)
        content.imageProperties.cornerRadius = 50
        content.imageProperties.maximumSize = CGSize(width: 50, height: 50)
        cell.contentConfiguration = content
        cell.transform = messageTable.transform
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let textMessage = data[indexPath.row]
        let infoController = InfoController()
        infoController.delegate = self
        indexForCell = indexPath.row
        
        infoController.messageLabel.text = textMessage
        navigationController?.pushViewController(infoController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        animatable(with: cell, duration: 1)

        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            indicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        }
    }
}

// MARK: setUpConstraints
extension StartController {
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            headerLabel.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            segmentedControl.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            segmentedControl.bottomAnchor.constraint(equalTo: messageTable.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            messageTable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            messageTable.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            messageTable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            messageTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
