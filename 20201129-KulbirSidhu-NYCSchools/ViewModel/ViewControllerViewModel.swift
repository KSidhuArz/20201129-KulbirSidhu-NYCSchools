//
//  ViewControllerViewModel.swift
//  20201129-KulbirSidhu-NYCSchools
//
//  Created by Ramandeep Singh on 11/29/20.
//  Copyright © 2020 Kulbir. All rights reserved.
//


import Foundation
import CoreGraphics

final class ViewControllerViewModel: viewControllerConfigurables {
    var delegate: schoolListControllerCallBack?
    var schoolListArray: [NYCSchoolDetails]?
    ///setting up cache which i will use to store API's data in to temproray storage.
    private let detailInfoCache  = NSCache<NSString, NSArray>()
    var schoolArray: [NYCSchool]? {
        didSet {
            delegate?.reloadTableView()
        }
    }

    func numberOfRows(inSection section: Int) -> Int {
        return schoolArray?.count ?? 0
    }
    
    func heightForRow(at IndexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func cellViewModel(at IndexPath: IndexPath) -> SchoolListTableViewCellConfigurables? {
        if let school = schoolArray?[IndexPath.row], let name = school.school_name, let city = school.city, let state = school.state_code, let zip = school.zip {
            return SchoolListTableViewCellModel(schoolName: name, city: city, zip: zip, state: state)
        }
        return SchoolListTableViewCellModel(schoolName: "", city: "", zip: "", state: "")
    }
    ///Return VOID while return type ANY help me to response with any thing as per my choice.
    func didSelectRow(at indexPath: IndexPath) -> Any? {
        guard let value = schoolArray?[indexPath.row] as? NYCSchool else {
            return Void.self
        }
        ///Given -1 index to make my logic if index is -1 i have to SAT school detail data to display to user.
      var index = (schoolListArray?.firstIndex(where: {
            $0.dbn == value.dbn
        }) ?? -1)
        return (index == -1) ? Void.self : schoolListArray?[index]
    }
    
    func performNYCFetch() {
        LoadingIndicator.show(InAppErrorMessage.activityIndicatorLoadingTitle)
        guard let url = URL(string: APIUrls.schoolList) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        print(request)
        URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("API didn't respond well.")
                LoadingIndicator.hide()
                return
            }
            if let json = data {
                do {
                    ///Take benefit of Decodable
                    self?.schoolArray = try JSONDecoder().decode([NYCSchool].self, from: json)
                } catch let jsonErr {
                    print("Error decoding json:", jsonErr)
                }
            }
            LoadingIndicator.hide()
            if self?.cacheExist() == false {
                // MARK: - Print to test Whether API is not getting called if you saved data in Cache.
            print("-------------> cache called")
                self?.performDetailsFetch()
            }
        }.resume()
    }
    
    fileprivate func cacheExist() -> Bool {
        return  ((self.detailInfoCache.object(forKey: "DetailsList") as? [NYCSchoolDetails]) != nil) ? true : false
    }
    
    func performDetailsFetch() {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: APIUrls.schoolDetail) else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)
            print(request)
            URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    print("API didn't respond well.")
                    LoadingIndicator.hide()
                    return
                }
                if let json = data {
                    do {
                        self?.schoolListArray = try JSONDecoder().decode([NYCSchoolDetails].self, from: json)
                        // MARK: - Important Point
                        ///As a developer for only this API i thought user might or might not go to details so we will only call the API once and save it in cache, so the applcation performance would be better and user would be having a very smooth experience between navigation of these two screens. When user close the app API will call again and new/fresh data will be saved in cache.
                        self?.detailInfoCache.setObject(self?.schoolListArray as! NSArray, forKey: "DetailsList")
                    } catch let jsonErr {
                        print("Error serializing json:", jsonErr)
                    }
                }
            }.resume()
        }
    }
    ///whenever class get deinitialized release this cache memory, We may not need it.
    deinit {
        detailInfoCache.removeObject(forKey: "DetailsList")
    }
}

