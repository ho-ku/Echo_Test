//
//  ViewController.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import UIKit

final class MainVC: UIViewController {
 
    // MARK: - IBOutlets
    @IBOutlet var mainView: MainView!
    // MARK: - Properties
    private let requestManager = RequestManager()
    private var fetchedText: String = ""
    private var occurrences: [Occurrence] = []
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
  
        if User.shared.name == "" {
            Router.presentSignUpView(from: self)
        }
        mainView.delegate = self
        mainView.registerCell(for: C.mainViewCellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupView()
        performRequest()
    }
    
    private func performRequest() {
        requestManager.fetchText(locale: "en_US") { [unowned self] result in
            switch result {
            case .failure(_):
                DispatchQueue.main.async { [unowned self] in
                    AlertManager.presentSimpleAlert(self, title: C.oops, message: C.textFetchErrorMessage)
                }
            case.success(let data):
                self.fetchedText = Decoder.decodeText(from: data)
                self.occurrences = OccurrenceCounter.countOccurrences(in: self.fetchedText.lowercased())
                DispatchQueue.main.async { [unowned self] in
                    self.updateUI()
                }
            }
        }
    }
    
    private func setupView() {
        self.title = User.shared.name
    }
    
    private func updateUI() {
        mainView.setText(self.fetchedText)
        mainView.updateUI()
    }
    
    // MARK: - IBActions
    @IBAction func logOutBtnPressed(_ sender: UIBarButtonItem) {
        User.shared.delete()
        Router.presentSignUpView(from: self)
    }
    
}
// MARK: - MainViewDelegate
extension MainVC: MainViewDelegate { }
// MARK: - UITableViewDelegate
extension MainVC: UITableViewDelegate { }
// MARK: - UITableViewDataSource
extension MainVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return occurrences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.mainViewCellIdentifier, for: indexPath)
        let occurrence = occurrences[indexPath.row]
        cell.textLabel?.text = "'\(occurrence.character)' - \(occurrence.count) times"
        return cell
    }
    
}
