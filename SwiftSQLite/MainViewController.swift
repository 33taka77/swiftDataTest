//
//  MainViewController.swift
//  SwiftSQLite
//
//  Created by Aizawa Takashi on 2015/04/23.
//  Copyright (c) 2015年 Aizawa Takashi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource, UIScrollViewDelegate{

    var dataSourceArray:[String] = []
    var currentOffsetOfCollectionView:CGFloat = 0.0
    var pageIndex:CGFloat = 0.0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for var i = 0; i < 5; i++ {
            let str:String = String(format:"%d",i)
            dataSourceArray.append(str)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidLayoutSubviews() {
        let index:NSIndexPath! = NSIndexPath(forItem: 4, inSection: 0)
        self.collectionView.scrollToItemAtIndexPath(index, atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func numberOfSectionsInCollectionView(collectionView:UICollectionView)->NSInteger{
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:MainCollectionViewCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("MainCollectionCell", forIndexPath: indexPath) as! MainCollectionViewCell
        cell.setupCell( dataSourceArray[indexPath.row])
        println("cellForTtemAtIndex: \(indexPath.row)")
        return cell as UICollectionViewCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width:CGFloat = self.collectionView.bounds.width - 0.0
        let height:CGFloat = self.collectionView.bounds.height
        return CGSizeMake(width, height)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        var flag:Bool = false
        if page > pageIndex {
            if( page == CGFloat(dataSourceArray.count-2) ) {
                let str:String = String(format:"%d",dataSourceArray.count)
                dataSourceArray.append(str)
            }
        }else{
            if( page < 4) {
                let str:String = String(format:"%d",dataSourceArray.count)
                dataSourceArray.insert(str, atIndex: 0)
                flag = true
            }
        }
        pageIndex = page
        self.collectionView.reloadData()
        
        if flag {
            let index:NSIndexPath! = NSIndexPath(forItem: Int(pageIndex+1), inSection: 0)
            self.collectionView.scrollToItemAtIndexPath(index, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
        }
        
    }

}
