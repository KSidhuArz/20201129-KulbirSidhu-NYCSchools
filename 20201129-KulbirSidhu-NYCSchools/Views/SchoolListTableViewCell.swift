//
//  SchoolListTableViewCell.swift
//  20201129-KulbirSidhu-NYCSchools
//
//  Created by Ramandeep Singh on 11/30/20.
//  Copyright © 2020 Kulbir. All rights reserved.
//

import UIKit

final class SchoolListTableViewCell: UITableViewCell {
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var stateCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var cellViewModel: SchoolListTableViewCellConfigurables! {
        didSet {
            if let name = cellViewModel.schoolName, let city = cellViewModel.city, let state = cellViewModel.state_code, let zip = cellViewModel.zip {
                self.schoolNameLabel.text = name
                self.cityLabel.text = city
                self.stateCodeLabel.text = state
                self.zipLabel.text = zip
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    ///Return the class name in String format
    class func reUseID() -> String {
        return String(describing: self)
    }
}
