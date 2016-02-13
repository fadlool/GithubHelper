//
//  DetailsTableViewController.swift
//  Github
//
//  Created by Mohamed Fadl Allah on 2/13/16.
//  Copyright © 2016 microapps. All rights reserved.
//

import Foundation
import UIKit

class DetailsTableViewController: UITableViewController{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var issueThreeLabel: UILabel!
    @IBOutlet weak var issueTwoLabel: UILabel!
    @IBOutlet weak var committerThreeLabel: UILabel!
    
    @IBOutlet weak var committerTwoLabel: UILabel!
    var repoName:String?
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var issueOneLabel: UILabel!
    @IBOutlet weak var committerOneLabel: UILabel!
    
    var reposTabeViewController:ReposTableViewController?
    
    override func viewDidLoad() {
//        self.repoImageView.image = reposTabeViewController!.
        
        self.titleLabel.text = self.reposTabeViewController?.selectedRepo?.name
        
        self.descriptionLabel.text = self.reposTabeViewController?.selectedRepo?.url
        if(reposTabeViewController!.topIssuesArr.count > 0){
            self.issueOneLabel.text = reposTabeViewController!.topIssuesArr[0].title
        }
        if(reposTabeViewController!.topIssuesArr.count > 1){
            self.issueTwoLabel.text = reposTabeViewController!.topIssuesArr[1].title
        }
        if(reposTabeViewController!.topIssuesArr.count > 2){
            self.issueThreeLabel.text = reposTabeViewController!.topIssuesArr[2].title
        }
        
        if(reposTabeViewController!.topCommittersArr.count > 0){
            let commit:Contributer = (reposTabeViewController!.topCommittersArr[0] as? Contributer)!
            
            self.committerOneLabel.text = commit.login
            
        }
        if(reposTabeViewController!.topCommittersArr.count > 1){
            let commit:Contributer = (reposTabeViewController!.topCommittersArr[1] as? Contributer)!
            
            self.committerTwoLabel.text = commit.login
        }
        if(reposTabeViewController!.topCommittersArr.count > 2){
            let commit:Contributer = (reposTabeViewController!.topCommittersArr[2] as? Contributer)!
            
            self.committerThreeLabel.text = commit.login
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    


}
