//
//  DetailViewController.swift
//  20201129-KulbirSidhu-NYCSchools
//
//  Created by Ramandeep Singh on 11/29/20.
//  Copyright © 2020 Kulbir. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var totalTestTakerlabel: UILabel!
    @IBOutlet weak var mathAvgScoreLabel: UILabel!
    @IBOutlet weak var writingAvgScroeLabel: UILabel!
    @IBOutlet weak var satCriticalReadingAvgScoreLabel: UILabel!
    
    var viewModel: DetailViewControllerConfigurables?
    
    override func viewWillAppear(_ animated: Bool) {
        setUpLabelValues()
    }
    
    ///Setting up the UI should be controller specific so used the fileprivate
    fileprivate func setUpUI() {
        self.title = InAppNavigationBarTitle.detailViewControllerNavBarTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    fileprivate func setUpLabelValues() {
        if let name = viewModel?.schoolSetData?.school_name, let totalTest = viewModel?.schoolSetData?.num_of_sat_test_takers, let mathAvg = viewModel?.schoolSetData?.sat_math_avg_score, let writingAvg = viewModel?.schoolSetData?.sat_writing_avg_score, let criticalReadingAvg = viewModel?.schoolSetData?.sat_critical_reading_avg_score {
          //  NSLog("name>>>", name)
            self.schoolNameLabel.text = name
            self.totalTestTakerlabel.text = totalTest
            self.mathAvgScoreLabel.text = mathAvg
            self.writingAvgScroeLabel.text = writingAvg
            self.satCriticalReadingAvgScoreLabel.text = criticalReadingAvg
        }
        
    }
}

