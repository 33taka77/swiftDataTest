//
//  ViewController.swift
//  SwiftSQLite
//
//  Created by Aizawa Takashi on 2015/04/21.
//  Copyright (c) 2015年 Aizawa Takashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func buttonPushed(sender: AnyObject) {
        let dataManager:DataMngr = DataMngr.sharedInstance
        let today:NSDate = NSDate()
        dataManager.add(today)
        let columnDatas:Dictionary<String,Any> = ["weightMorning":95.50, "bodyFatPercentageMorning":33.5]
        let result = dataManager.update(columnDatas, targetDate: today)
        
        let fetchDatas:[Dictionary<String,Any>] = dataManager.selectAll()
        for dict in fetchDatas {
            println("dict:"+dict.description)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

