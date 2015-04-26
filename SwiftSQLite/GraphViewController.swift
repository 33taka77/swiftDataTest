//
//  GraphViewController.swift
//  SwiftSQLite
//
//  Created by 相澤 隆志 on 2015/04/26.
//  Copyright (c) 2015年 Aizawa Takashi. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    var morningData:[CGFloat] = []
    var eveningData:[CGFloat] = []
    var labels:[String] = ["4/1","4/8","4/15","4/22","4/27",""]

    @IBOutlet weak var graphView: SmartGraph!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for var i=0; i<30; i++ {
            let rdm1 = arc4random_uniform(20) + 60
            morningData.append(CGFloat(rdm1))
            let rdm2 = arc4random_uniform(20) + 60
            eveningData.append(CGFloat(rdm2))
        }
        
        graphView.setAxisLabel(SmartGraph.graphScale.month, labels: labels)
        graphView.setPlot1(morningData)
        graphView.setPlot2(eveningData)
        graphView.setNeedsDisplay()
        graphView.targetWeight = 50.5

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
