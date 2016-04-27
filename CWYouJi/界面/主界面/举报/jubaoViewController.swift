//
//  jubaoViewController.swift
//  CWYouJi
//
//  Created by MC on 15/11/14.
//  Copyright © 2015年 MC. All rights reserved.
//

import UIKit

class jubaoViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource {
    var _tableView
    :UITableView?
    var  _ShareView :
    jubao_View!
    var _titleArray:
    NSArray?
    var _index : NSInteger!
    
    var _youjiId:String!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = true

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "举报"
        _index = 5;
        _titleArray = NSArray()
        _titleArray = ["色情低俗","广告骚扰","政治敏感","侵权举报（诽谤、抄袭、冒用）"]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发送", style: UIBarButtonItemStyle.Plain, target: self, action: ("fasongBtn"))
        self.prepreUI()
              // Do any additional setup after loading the view.
    }
    
    func fasongBtn(){
        
        if _index > 4 {
            self.showAllTextDialog("请选择你举报的内容")
            return
            
        }
        let dic = NSMutableDictionary()
        dic.setObject(_youjiId, forKey: "targetId")
        dic.setObject(_titleArray![_index], forKey: "content")
        self.showLoading(true, andText: nil)
        requestManager.requestWebWithParaWithURL("api/global/report.json", parameter: dic as [NSObject : AnyObject], isLogin: true, finish: { (resultDic) -> Void in
            self.stopshowLoading()

            self._ShareView = jubao_View.createViewFromNib()
            self._ShareView.titleLbl?.textColor = AppTextCOLOR
            self._ShareView.showInWindow()
            self._ShareView.queBtn?.addTarget(self, action: ("queBtn"), forControlEvents: UIControlEvents.TouchUpInside)
            self._ShareView.quxiaoBtn?.addTarget(self, action: ("quxiaonBtn"), forControlEvents: UIControlEvents.TouchUpInside)
            
            
            
            }) { (operation:AFHTTPRequestOperation?, NSError:NSError?, String:String?) -> Void in
                self.stopshowLoading()
                self.showAllTextDialog(String)
            
        }
        
        
        
    }
    
    func queBtn(){
        _ShareView.hideView()
        self.navigationController?.popViewControllerAnimated(true)

        
    }
    func quxiaonBtn(){
        _ShareView.hideView()
        self.navigationController?.popViewControllerAnimated(true)

        
    }
    func prepreUI(){
        
        _tableView = UITableView.init(frame: CGRectMake(0, 64,screenWidth , screenHeight - 64), style: UITableViewStyle.Grouped)
        _tableView?.delegate = self
        _tableView?.dataSource = self
        self.view.addSubview(_tableView!)
        
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ceelid = "jubaoCell"
        var cell:jubaoCell?
         cell = tableView.dequeueReusableCellWithIdentifier(ceelid) as? jubaoCell
        
        if (cell == nil){
    cell = (NSBundle.mainBundle().loadNibNamed("jubaoCell", owner: self, options: nil)).last as?jubaoCell
            
        }
        cell?.contentView.backgroundColor = UIColor.whiteColor()
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        cell?.titleLbl.textColor  = AppTextCOLOR
        cell?.titleLbl.text = _titleArray![indexPath.row] as? String
        
        
        
       return cell!
        
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRectMake(0, 0, screenWidth, 30))
        view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        let lbl = UILabel.init(frame: CGRectMake(10, 0, 200, 30))
        lbl.text = "请选择举报原因"
        lbl.textColor = UIColor.grayColor()
        lbl.font = UIFont.systemFontOfSize(14)
       view.addSubview(lbl)
        return view
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      //  tableView.deselectRowAtIndexPath(indexPath, animated: true)
        _index = indexPath.row;
        let cell : jubaoCell = (tableView.cellForRowAtIndexPath(indexPath) as? jubaoCell)!
        
        cell.titleLbl.textColor  = UIColor.orangeColor()
        cell.xuanZeBtn.hidden = false
        
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell : jubaoCell = (tableView.cellForRowAtIndexPath(indexPath) as? jubaoCell)!
        
        cell.titleLbl.textColor  = AppTextCOLOR
        cell.xuanZeBtn.hidden = true
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
