//
//  ViewController.swift
//  TableAndBottomViewSyncScrollDemo
//
// on 2025/3/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var listView: UITableView!
    
    lazy var inputBarView: InputBarView = {
        let inputBarView = InputBarView()
        return inputBarView
    }()
    
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registeNotifications()
        
        listView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        listView.dataSource = self
        listView.delegate = self
        self.view.addSubview(listView)
        self.view.addSubview(inputBarView)
        
        listView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view)
        }
        
        inputBarView.snp.makeConstraints { make in
            make.top.equalTo(listView.snp.bottom)
            make.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(0)
        }
        // Do any additional setup after loading the view.
    }


}

// MARK: -  UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedIndexPath != nil {
            selectedIndexPath = nil
            inputBarView.resignResponder()
            return
        }
        
        selectedIndexPath = indexPath
        
        inputBarView.becomeResponder()
    }
}

extension ViewController {
    func registeNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ noti: Notification) {
        guard let _ = noti.userInfo else {
            return
        }
        
        let duration = noti.keyboardAnimationDuration()
        
        let cureAnimation = noti.keyboardAnimationCurve()
        
        let keyboardHeight = noti.keyboardHeight()
        
        inputBarView.snp.updateConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-keyboardHeight)
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: cureAnimation) {
            self.view.layoutIfNeeded()
            
            if let indexPath = self.selectedIndexPath {
                let rect = self.listView.rectForRow(at: indexPath)
                self.listView.scrollRectToVisible(rect, animated: false)
            }
        } completion: { _ in
            
        }
    }
    
    @objc func keyboardWillHide(_ noti: Notification) {
        guard let _ = noti.userInfo else {
            return
        }
        let duration = noti.keyboardAnimationDuration()
        
        let cureAnimation = noti.keyboardAnimationCurve()
        
        inputBarView.snp.updateConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(0)
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: cureAnimation) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            
        }
    }
}
