//
//  APIBuilder.swift
//  20201129-KulbirSidhu-NYCSchools
//
//  Created by Ramandeep Singh on 11/29/20.
//  Copyright © 2020 Kulbir. All rights reserved.
//



enum APIUrls {
    // Endpoints
    static let schoolList = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json" // Return school lists
    static let schoolDetail = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json" // Return school details
}
///Set Nav bar title used in app as per controller's name - I think new developer can frequently learn that pattern within team.
enum InAppNavigationBarTitle {
    //If possible for ease please use class name for the title of nav bar
    static let viewControllerNavBarTitle = "NYC - List"
    static let detailViewControllerNavBarTitle = "SAT Score Details"
}
///Tried to give name of storyboard as they are.
enum InAppStoryBoardName {
    static let detailViewIdentifier = "DetailViewController"
    static let mainStoryboard = "Main"
    
}
///Only used for various error/informtio message within App.
enum InAppErrorMessage {
    static let dataNotFoundError = "SAT score is not available for this school."
    static let activityIndicatorLoadingTitle = "Loading..."
}

enum InAppAlertButtonTitle {
    static let alertTitle = "Alert!"
    static let cancelTitle = "Cancel"
}

//API decodable data - Only picking up important values DBN kind of unique id ofschool which will be used to navigate to another screen.
struct NYCSchool: Decodable {
    let dbn: String?
    let school_name: String?
    let city: String?
    let zip: String?
    let state_code: String?
}

struct NYCSchoolDetails: Decodable {
    let dbn: String?
    let school_name: String?
    let num_of_sat_test_takers: String?
    let sat_critical_reading_avg_score: String?
    let sat_math_avg_score: String?
    let sat_writing_avg_score: String?
}

