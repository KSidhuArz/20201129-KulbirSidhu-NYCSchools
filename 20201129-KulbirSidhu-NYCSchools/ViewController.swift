//
//  ViewController.swift
//  20201129-KulbirSidhu-NYCSchools
//
//  Created by Ramandeep Singh on 11/29/20.
//  Copyright © 2020 Kulbir. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, schoolListControllerCallBack {
    @IBOutlet weak var schoolListTableView: UITableView!
    
    var viewModel: viewControllerConfigurables! {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    private func setupDelegate(){
        ///Dependecy injection
        self.viewModel = ViewControllerViewModel()
        schoolListTableView.delegate = self
        schoolListTableView.dataSource = self
    }
    
    fileprivate func setUpUI() {
        self.title = InAppNavigationBarTitle.viewControllerNavBarTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        registerCell()
        self.viewModel.performNYCFetch()
    }
    
    ///Bottom right button action to refresh the Home view again, This will call the API again and again.
    @IBAction func reloadData(sender: UIButton) {
        self.viewModel.performNYCFetch()
    }
    
    func reloadTableView() {
        ///Bidirectional POP communication.
        DispatchQueue.main.async {
            self.schoolListTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let secondVC = UIStoryboard(name: InAppStoryBoardName.mainStoryboard, bundle: nil).instantiateViewController(identifier: InAppStoryBoardName.detailViewIdentifier) as? DetailViewController {
            secondVC.viewModel = DetailViewControllerViewModel()
            guard  let schoolDetail = self.viewModel.didSelectRow(at: indexPath) as? NYCSchoolDetails else {
                showErrorAlert()
                return
            }
            /// Use the approach MVVM - Where Model talk to model , we could have assign a segue value to Detail class but using that it will lost its data abstraction,
            secondVC.viewModel?.schoolSetData = schoolDetail
            self.navigationController?.pushViewController(secondVC, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolListTableViewCell.reUseID(), for: indexPath) as? SchoolListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.purple.withAlphaComponent(0.05) : UIColor.white
        cell.cellViewModel = self.viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    ///Final keyword doesn't check dynamic referene method index for subclass that makes it fast, So mostly function i used the final.
   final func registerCell(){
        self.schoolListTableView.register(UINib(nibName: SchoolListTableViewCell.reUseID(), bundle: nil), forCellReuseIdentifier: SchoolListTableViewCell.reUseID())
    }
    
 ///Final keyword doesn't check dynamic referene method index for subclass that makes it fast, So mostly function i used the final.
  final func showErrorAlert() {
        let errorAlert = UIAlertController(title: InAppAlertButtonTitle.alertTitle, message: InAppErrorMessage.dataNotFoundError, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: InAppAlertButtonTitle.cancelTitle, style: .cancel, handler: {
            alert -> Void in
        }))
        self.present(errorAlert, animated: true, completion: nil)
    }
    
}


