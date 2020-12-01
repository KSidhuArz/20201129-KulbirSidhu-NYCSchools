//
//  DetailViewProtocol.swift
//  20201129-KulbirSidhu-NYCSchools
//
//  Created by Ramandeep Singh on 11/29/20.
//  Copyright © 2020 Kulbir. All rights reserved.
//

import Foundation

protocol DetailViewControllerConfigurables: AnyObject {
    var schoolSetData: NYCSchoolDetails? {get set}
}

///Thought not create a file for just two line of class used this one for below class.
final class DetailViewControllerViewModel: DetailViewControllerConfigurables {
    var schoolSetData: NYCSchoolDetails?
}
