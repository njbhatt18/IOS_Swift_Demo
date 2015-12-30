//
//  DetailViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {

    @IBOutlet var pickerVw : UIPickerView?
    @IBOutlet var datePicker : UIDatePicker?
    @IBOutlet var txtPicker : UITextField?
    @IBOutlet var txtDatePicker : UITextField?
    @IBOutlet var toolBar : UIToolbar?
    var arrDetail : NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPicker?.inputAccessoryView=toolBar
        txtDatePicker?.inputAccessoryView=toolBar
        txtDatePicker?.inputView=datePicker;
        txtPicker?.inputView=pickerVw
        
        arrDetail .addObject("India")
        arrDetail .addObject("Australia")
        arrDetail .addObject("SA")
        arrDetail .addObject("Pakistan")
        arrDetail .addObject("SriLanka")
        arrDetail .addObject("Nepal")
        arrDetail .addObject("America")
        
        self.navigationItem.title="Picker"

    }
    @IBAction func btnToolBarDoneClick(sender : AnyObject)
    {
        txtDatePicker?.resignFirstResponder();
        txtPicker?.resignFirstResponder()
    }
    @IBAction func datePickerValueChanged(sender : AnyObject)
    {
        let df = NSDateFormatter()
        df.dateFormat="yyyy-MM-dd"
        txtDatePicker?.text=df.stringFromDate((datePicker?.date)!)
    }
    //PickerView Delegate Event
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return arrDetail.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return arrDetail.objectAtIndex(row) as? String
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        txtPicker?.text = arrDetail.objectAtIndex(row) as? String
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

