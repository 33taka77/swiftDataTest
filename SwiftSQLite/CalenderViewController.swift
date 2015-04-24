//
//  CalenderViewController.swift
//  SwiftSQLite
//
//  Created by 相澤 隆志 on 2015/04/23.
//  Copyright (c) 2015年 Aizawa Takashi. All rights reserved.
//

import UIKit

class CalenderViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    let margin:CGFloat = 2.0
    
    @IBOutlet weak var navBar: UINavigationItem!
    var currentDay:NSDate = NSDate()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func pushPrevButton(sender: AnyObject) {
        let addVal:NSInteger = -1
        let calender:NSCalendar = NSCalendar.currentCalendar()
        let dateComponents = NSDateComponents()
        dateComponents.month = addVal
        let newDate:NSDate = calender.dateByAddingComponents(dateComponents, toDate: self.currentDay, options: nil)!
        self.currentDay = newDate
        self.collectionView.reloadData()
    }
    
    @IBAction func pushNextButton(sender: AnyObject) {
        let addVal:NSInteger = 1
        let calender:NSCalendar = NSCalendar.currentCalendar()
        let dateComponents = NSDateComponents()
        dateComponents.month = addVal
        let newDate:NSDate = calender.dateByAddingComponents(dateComponents, toDate: self.currentDay, options: nil)!
        self.currentDay = newDate
        self.collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(true)
        let barHeight:CGFloat = 44
        self.collectionView.frame = CGRectMake(0,barHeight,self.view.frame.width, self.view.frame.height-barHeight)
    }

    override func viewDidLayoutSubviews() {
        let obj:AnyObject = NSDate()
        self.pushNextButton(obj)
        self.pushPrevButton(obj)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func firstDayOfMonth()->NSDate {
        let companents:NSDateComponents = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitYear|NSCalendarUnit.CalendarUnitMonth|NSCalendarUnit.CalendarUnitDay, fromDate: self.currentDay)
        companents.day = 1
        let firstDateMonth:NSDate = NSCalendar.currentCalendar().dateFromComponents(companents)!
        return firstDateMonth
    }
    func dateForIndexPath(index:NSIndexPath)->String {
        let date:NSDate = self.firstDayOfMonth()
        let firstDay:NSInteger  = NSCalendar.currentCalendar().ordinalityOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitWeekOfMonth, forDate: date)
        let dateComponents:NSDateComponents = NSDateComponents()
        dateComponents.day = index.item - (firstDay - 1)
        let tatgetDate:NSDate = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: date, options: nil)!
        
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "d"
        let str:String = formatter.stringFromDate(tatgetDate)
        
        return str
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rangeOfWeek:NSRange = NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.CalendarUnitWeekOfMonth, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: currentDay)
        let count = rangeOfWeek.length * 7
        
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "YYYY/MM"
        let str:String = formatter.stringFromDate(currentDay)
        navBar.title = str
        
        return count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CalenderCollectionViewCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("CalenderCell", forIndexPath: indexPath) as! CalenderCollectionViewCell
        cell.dayLabel.text = self.dateForIndexPath(indexPath)
        return cell as UICollectionViewCell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let w:CGFloat = self.collectionView.frame.width
        let width:CGFloat = (w - margin*8)/7
        let height:CGFloat = width*1.5
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(margin,margin,margin,margin)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return margin
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return margin
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
