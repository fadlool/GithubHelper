//
//  ReposViewController.swift
//  Github
//
//  Created by Mohamed Fadl on 2/11/16.
//  Copyright © 2016 microapps. All rights reserved.
//

import Foundation

class ReposTableViewController: UITableViewController,UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isFiltered:Bool = false
    var mapEventsList:NSMutableArray = []
    var filteredTableData:NSMutableArray = []
    
    var mwTopRefreshControl:UIRefreshControl?
    var mwBottomRefreshControl:UIRefreshControl?
    var moreResultsAvail:Bool = false
    var offset:Int = 0
    
    var editMode:Bool = false
    var refreshBar:UIRefreshControl?
    
    var mainViewController:MainViewController?
    
    var numOfSelectedItems:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshBar = UIRefreshControl()
        self.refreshBar!.tintColor = UIColor.darkTextColor()
        
        self.refreshBar?.addTarget(self, action: "refreshView:", forControlEvents: UIControlEvents.ValueChanged)
        
        
        self.tableView.addSubview(self.refreshBar!)
        
        self.mwTopRefreshControl =  self.refreshBar;
        
        
        self.searchBar.delegate = self
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:RepoViewCell = tableView.dequeueReusableCellWithIdentifier("repoViewCell") as! RepoViewCell
        
        NSLog(String(indexPath.row))
        if(indexPath.row < self.mapEventsList.count){
            
            let contentItem:Repository
            if(self.isFiltered){
                contentItem = self.filteredTableData.objectAtIndex(indexPath.row) as! Repository
                
            }
            else{
                contentItem = self.mapEventsList.objectAtIndex(indexPath.row) as! Repository
                
            }
            
            // Configure the cell...
            cell.configureAvatarImageView(contentItem.owner.avatar_url, selected: false)
            cell.avatarImageView!.tag = indexPath.row;
        
//            cell.eventNameLabel.text = contentItem.desc
//            cell.eventTimeLabel.text = contentItem.onTrackerTime
//            cell.trackerNameLabel.text = contentItem.name
//            
//            self.addTapGesturetoBtn(cell.chkBtn!, selector: "btnChkTapped:")
//            
//            cell.chkBtn.setBackgroundImage(UIImage(named: "UncheckIcon"), forState: UIControlState.Normal)
//            
//            cell.chkBtn.setBackgroundImage(UIImage(named: "CheckIcon"), forState: UIControlState.Selected)
//            cell.chkBtn.setBackgroundImage(UIImage(named: "CheckIcon"), forState: UIControlState.Highlighted)
//            
//            cell.chkBtn.selected = contentItem.selected
//            
//            cell.chkBtn.adjustsImageWhenHighlighted = true
//            cell.chkBtn.tag = indexPath.row;
//            cell.eventIcon.tag = indexPath.row;
            
        }
        
        
        cell.tag = indexPath.row;
        
        if (indexPath.row == self.mapEventsList.count - 1)
        {
            self.loadMapObjects()
        }
        
        return cell
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.characters.count == 0)
        {
            self.isFiltered = false
        }
        else
        {
            self.isFiltered = true;
            self.filteredTableData = []
            
            for mapEvent in self.mapEventsList
            {
                let nameString:NSString = mapEvent.name!
                
                let nameRange:NSRange = nameString.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                
                if(nameRange.location !=  NSNotFound)
                {
                    self.filteredTableData.addObject(mapEvent)
                }
            }
        }
        self.tableView!.reloadData()
        
    }
    
    func showDetailsForIndexPath(indexPath:NSIndexPath)
    {
        self.searchBar.resignFirstResponder()
        
        let item:Repository
        
        if(isFiltered)
        {
            item = self.filteredTableData.objectAtIndex(indexPath.row) as! Repository
        }
        else
        {
            item = self.mapEventsList.objectAtIndex(indexPath.row) as! Repository
            
        }
        
        //        self.mapViewController?.selectedUnits.addObject(item)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func blinkAndFlipButtonAnimationWithText(button:UIButton){
        
        UIView.transitionWithView(button, duration: 0.2, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            }) { (finished) -> Void in
                
        }
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func refreshView(refresh:UIRefreshControl ) {
        // custom refresh logic would be placed here...
        self.offset = 0;
        self.mapEventsList.removeAllObjects()
        self.tableView!.reloadData()
        
        self.loadMapObjects()
    }
    
    func startRefreshControl(){
        self.mwTopRefreshControl?.beginRefreshing()
        self.tableView.setContentOffset(CGPointMake(0, -self.mwTopRefreshControl!.frame.size.height), animated:true)
        self.refreshView(self.mwTopRefreshControl!)
    }
    
    func stopRefreshControl(){
        self.mwTopRefreshControl?.endRefreshing()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount:Int
        if(self.isFiltered){
            rowCount = self.filteredTableData.count;
        }else{
            rowCount = self.mapEventsList.count;
        }
        
        return rowCount;
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.showDetailsForIndexPath(indexPath)
    }
    
    //    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    //        let more = UITableViewRowAction(style: .Normal, title: "more".localized) { action, index in
    //            NSLog("more button tapped")
    //        }
    //        more.backgroundColor = UIColor.greenColor()
    //
    //        let follow = UITableViewRowAction(style: .Normal, title: "follow".localized) { action, index in
    //            NSLog("follow button tapped")
    //        }
    //        follow.backgroundColor = UIColor.lightGrayColor()
    //
    //        let history = UITableViewRowAction(style: .Normal, title: "history".localized) { action, index in
    //            NSLog("history button tapped")
    //        }
    //        history.backgroundColor = UIColor(red: 0.14, green: 0.61, blue: 0.87, alpha: 1.0)
    //
    //        return [history, follow, more]
    //    }
    
    
    func addTapGesturetoBtn(btn:UIView, selector:Selector)
    {
        btn.userInteractionEnabled = true
        let tapGestureRecognizer:UITapGestureRecognizer  = UITapGestureRecognizer(target: self, action:selector)
        tapGestureRecognizer.numberOfTapsRequired = 1;
        btn.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func loadMapObjects(){
        let services:Services = Services()
        
        services.getRepos(mainViewController!.progLanguage!, getReposSuccess: { (reposArr) -> () in
            MBProgressHUD.hideHUDForView(self.view!, animated: true)
            if(reposArr!.count > 0){
                self.mapEventsList.addObjectsFromArray(reposArr as! [AnyObject])
                self.tableView!.reloadData()
                self.stopRefreshControl()
                
//                self.offset = self.offset + Common.LIMIT;
            }
            }, getReposFailure: { (error, msg) -> () in
                MBProgressHUD.hideHUDForView(self.view!, animated: true)
                
        })
        
    }
    
}
