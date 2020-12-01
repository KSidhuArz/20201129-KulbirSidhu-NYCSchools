//
//  ViewControllerProtocol.swift
//  20201129-KulbirSidhu-NYCSchools
//
//  Created by Ramandeep Singh on 11/29/20.
//  Copyright © 2020 Kulbir. All rights reserved.
//

import Foundation
import CoreGraphics
///Protocol based MVVM

///Only for Bi-Directional data transfer, below protocol is responsible to give you a callbak to your controller for any kind of UI updation from your VIEWMODEL.
public protocol schoolListControllerCallBack {
    func reloadTableView()
}

///View model methods and getter/setters.
public protocol viewControllerConfigurables: AnyObject {
    var delegate: schoolListControllerCallBack? {get set}
    func numberOfRows(inSection section: Int) -> Int
    func heightForRow(at IndexPath: IndexPath) -> CGFloat
    func cellViewModel(at IndexPath: IndexPath) -> SchoolListTableViewCellConfigurables?
    func didSelectRow(at indexPath: IndexPath) -> Any?
    func performNYCFetch()
    func performDetailsFetch()
}

///Tableviewcell's TIny model, Though i think even its a small but this is also a VIew which can have its own little viewmodel like this one.
public protocol SchoolListTableViewCellConfigurables: AnyObject {
    var schoolName: String? {get}
    var city: String? {get}
    var zip: String? {get}
    var state_code: String? {get}
}


final class SchoolListTableViewCellModel: SchoolListTableViewCellConfigurables {
    var schoolName: String?
       var city: String?
       var zip: String?
       var state_code: String?
    
    init(schoolName: String, city: String, zip: String, state: String) {
        self.schoolName = schoolName
        self.city = city
        self.zip = zip
        self.state_code = state
    }
}

