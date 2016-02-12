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
    var repoList:NSMutableArray = []
    var filteredTableData:NSMutableArray = []
    
    var mwTopRefreshControl:UIRefreshControl?
    var mwBottomRefreshControl:UIRefreshControl?
    var moreResultsAvail:Bool = false
    var loading:Bool = false
    var currentPage:Int = 1

    var refreshBar:UIRefreshControl?
    
    var mainViewController:MainViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshBar = UIRefreshControl()
        self.refreshBar!.tintColor = UIColor.darkTextColor()
        
        self.refreshBar?.addTarget(self, action: "refreshView:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableView.addSubview(self.refreshBar!)
        self.mwTopRefreshControl =  self.refreshBar;
        self.searchBar.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.startRefreshControl()
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:RepoViewCell = tableView.dequeueReusableCellWithIdentifier("repoViewCell") as! RepoViewCell
        
        NSLog(String(indexPath.row))
        if(indexPath.row < self.repoList.count){
            
            let contentItem:Repository
            if(self.isFiltered){
                contentItem = self.filteredTableData.objectAtIndex(indexPath.row) as! Repository
                
            }
            else{
                contentItem = self.repoList.objectAtIndex(indexPath.row) as! Repository
                
            }
            
            // Configure the cell...
            cell.configureAvatarImageView(contentItem.owner.avatar_url, selected: false)
            cell.avatarImageView!.tag = indexPath.row;
        
            cell.repoNameLabel!.text = contentItem.full_name
            cell.descLabel!.text = contentItem.owner.login
            cell.lastUpdateDate!.text = Helper.userVisibleDateTimeStringForRFC3339DateTimeString(contentItem.updated_at)
            cell.starsLabel!.text = String(contentItem.stargazers_count)
            cell.forksLabel!.text = String(contentItem.forks_count)
        }
        
        
        cell.tag = indexPath.row;
        
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
            
            for repo in self.repoList
            {
                let nameString:NSString = repo.full_name!
                
                let nameRange:NSRange = nameString.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
                
                if(nameRange.location !=  NSNotFound)
                {
                    self.filteredTableData.addObject(repo)
                }
            }
        }
        self.tableView!.reloadData()
        
    }
    
    func showDetailsForIndexPath(indexPath:NSIndexPath)
    {
        self.searchBar.resignFirstResponder()
        
        var item:Repository
        
        if(isFiltered)
        {
            item = self.filteredTableData.objectAtIndex(indexPath.row) as! Repository
        }
        else
        {
            item = self.repoList.objectAtIndex(indexPath.row) as! Repository
            
        }
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
   
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func refreshView(refresh:UIRefreshControl ) {
        // custom refresh logic would be placed here...
        self.repoList.removeAllObjects()
        self.tableView!.reloadData()
        self.currentPage = 1
        self.loadReposList()
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
            rowCount = self.repoList.count;
        }
        
        return rowCount;
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.showDetailsForIndexPath(indexPath)
    }
    
    func loadReposList(){
        let services:Services = Services()
        self.loading = true
        services.getRepos(mainViewController!.progLanguage!,pageNo: self.currentPage, getReposSuccess: { (reposArr) -> () in
            
            self.loading = false;
            self.stopRefreshControl()
            if(reposArr!.count > 0){
                self.repoList.addObjectsFromArray(reposArr as! [AnyObject])
                self.tableView!.reloadData()
                
            }
            }, getReposFailure: { (error, msg) -> () in
                self.loading = false
                self.stopRefreshControl()
                
        })
        
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        self.searchBar.resignFirstResponder()
    }
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        
        if (!self.loading) {
            let endScrolling:CGFloat = scrollView.contentOffset.y + scrollView.frame.size.height;
            if ( endScrolling >= scrollView.contentSize.height)
            {
                self.currentPage = self.currentPage + 1
                self.loadReposList()
            }
        }

    }
    
    
}
