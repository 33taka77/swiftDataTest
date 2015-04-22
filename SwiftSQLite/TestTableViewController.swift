//
//  TestTableViewController.swift
//  SwiftSQLite
//
//  Created by Aizawa Takashi on 2015/04/22.
//  Copyright (c) 2015年 Aizawa Takashi. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    var listOfPickerItem1:[String] = []
    var listOfPickerItem2:[String] = []
    
    @IBOutlet weak var dataPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        for var i:Int = 0; i < 140; i++ {
            let str:String = String(format:"%d",i)
            listOfPickerItem1.append(str)
        }
        for var j:Int = 0; j < 99;j++ {
            if j % 5 == 0 {
                let tmpStr:String = String(format:"%d",j)
                if j == 0 || j == 5 {
                    let str = ".0" + tmpStr
                    listOfPickerItem2.append(str)
                }else{
                    let str = "." + tmpStr
                    listOfPickerItem2.append(str)
                }
            }
        }
        self.dataPicker.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.isExpandCell(tableView, atIndexPath: indexPath) {
            let cell:UITableViewCell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
            if cell.tag == 0 {
                return 0
            }else{
                return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
            }
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let expandIndex:NSIndexPath = NSIndexPath(forRow: indexPath.row+1, inSection: indexPath.section)
        if self.isExpandCell(tableView, atIndexPath: expandIndex) {
            tableView.beginUpdates()
            self.togglePicker(tableView, atIndexPath: indexPath)
            tableView.endUpdates()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func isExpandCell(tableView: UITableView, atIndexPath index:NSIndexPath)->Bool {
        let cell:UITableViewCell = super.tableView(tableView, cellForRowAtIndexPath: index)
        let isExpand:Bool = cell.reuseIdentifier == "Expanded"
        return isExpand
    }
    func togglePicker(tableView: UITableView, atIndexPath index:NSIndexPath) {
        let cell:UITableViewCell = super.tableView(tableView, cellForRowAtIndexPath: index)
        cell.tag = ~cell.tag
        /*
        if cell.tag == 0 {
            cell.tag = 1
        }else{
            cell.tag = 0
        }
        */
        self.dataPicker.hidden = !self.dataPicker.hidden
        /*
        for view:UIView in cell.contentView.subviews {
            if self.dataPicker == view {
                self.dataPicker.hidden = !self.dataPicker.hidden
            }
        }
        */
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return listOfPickerItem1.count
        }else if component == 1 {
            return listOfPickerItem2.count
        }
        return 0
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        var titleStr:String?
        switch component {
        case 0:
            titleStr = listOfPickerItem1[row]
        case 1:
            titleStr = listOfPickerItem2[row]
        default:
            println("error")
            titleStr = nil
        }
        return title
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let label = UILabel(frame: CGRectMake(0, 0, pickerView.frame.width/2.0, 44))
        label.textAlignment = NSTextAlignment.Center
        var titleStr:String?
        switch component {
        case 0:
            titleStr = listOfPickerItem1[row]
        case 1:
            titleStr = listOfPickerItem2[row]
        default:
            println("error")
            titleStr = nil
        }
        label.text = titleStr
        return label
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectRowIndex = pickerView.selectedRowInComponent(component)
    }

}
