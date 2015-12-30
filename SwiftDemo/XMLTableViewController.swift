//
//  MasterViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit

class XMLTableViewController : UIViewController , NSXMLParserDelegate {
    
    var arrDetail : NSMutableArray = []
    var strXMLData : NSString = ""
    var currentElement : NSString?
    var parser = NSXMLParser()
    var dictionary = Dictionary<String, String>()
    @IBOutlet var tblView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parser = NSXMLParser()
        tblView?.registerClass(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        tblView?.registerNib(UINib(nibName: "CustomCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CustomCell")
        
        self.automaticallyAdjustsScrollViewInsets=false;
        self.navigationItem.title="XML Parsing"
        self.navigationController?.navigationBarHidden=false
        
        
        let url:String="http://api.androidhive.info/pizza/?format=xml"
        let urlToSend: NSURL = NSURL(string: url)!
        // Parse the XML
        parser = NSXMLParser(contentsOfURL: urlToSend)!
        parser.delegate = self
        
        let success:Bool = parser.parse()
        if success {
            print("parse success!")
            print(arrDetail)
        } else {
            print("parse failure!")
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
        if(elementName == "menu"){
            
        }else if(elementName == "item"){
        }
        else{
        }
        
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        
        if(elementName == "menu"){
            print(arrDetail)
        }else if(elementName == "item"){
            strXMLData=""
            print(elementName)
            arrDetail.addObject(dictionary)
        }else{
            dictionary[elementName] = strXMLData as String;
            print(dictionary)
        }
    }
    func parser(parser: NSXMLParser, var foundCharacters string: String){
        string =  string.stringByReplacingOccurrencesOfString(" ", withString: "")
        string =  string.stringByReplacingOccurrencesOfString("\n", withString: "")
        if(strXMLData.length==0){
            strXMLData = string
        }else{
            strXMLData = strXMLData.stringByAppendingString(string)
        }
        print(strXMLData)
        
    }
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        NSLog("failure error: %@", parseError)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //TableView Delegate Event -
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDetail.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cellIdentifier = "CustomCell"
        var cell :  CustomCell?
            cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? CustomCell
        let dict = arrDetail.objectAtIndex(indexPath.row) as! Dictionary<String, String>
        var str = "" as NSString
        
        for (myKey,myValue) in dict {
            if(str.length==0){
                str = myKey
                str = str.stringByAppendingString("\t\t")

                str = str.stringByAppendingString(myValue)
            }
            else{
                str = str.stringByAppendingString("\n")

                str =  str.stringByAppendingString(myKey)
                str = str.stringByAppendingString("\t\t")
                str = str.stringByAppendingString(myValue)
            }
        }
        cell?.lblText?.frame=CGRectMake(cell!.lblText!.frame.origin.x, cell!.lblText!.frame.origin.y, cell!.lblText!.frame.size.width, 100)
        cell?.lblText?.backgroundColor=UIColor.redColor()
        cell?.lblText?.numberOfLines=0
        cell!.lblText!.text=str as String
        cell!.lblText?.font=UIFont(name: "Arial", size: 12)
        cell!.lblDetailText!.text=""
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 100
    }
}

