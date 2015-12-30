//
//  DetailViewController.swift
//  SwiftDemo
//
//  Created by ossc on 07/11/15.
//  Copyright © 2015 ossc. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI
class ContactsViewController: UIViewController {

    let addressBookRef: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
    func fetchContacts (){
        let authorizationStatus = ABAddressBookGetAuthorizationStatus()
        
        switch authorizationStatus {
        case .Denied, .Restricted:
            //1
            print("Denied")
            break;
        case .Authorized:
            //2
            print("Authorized")
            break;
        case .NotDetermined:
            //3
            var err: Unmanaged<CFError>? = nil
            ABAddressBookRequestAccessWithCompletion(addressBookRef) {
                (granted: Bool, error: CFError!) in
                dispatch_async(dispatch_get_main_queue()) {
                    if !granted {
                        // 1
                        print("Just denied")
                    } else {
                        // 2
                        print("Just authorized")
                    }
                }
            }
            print("Not Determined")
            break;
            
        }
        if(authorizationStatus == .Authorized){
            let allContacts = ABAddressBookCopyArrayOfAllPeople(addressBookRef).takeRetainedValue() as Array
            for record:ABRecordRef in allContacts {
                var objContact = Contact.init() as Contact
                let contactPerson: ABRecordRef = record
                let contactName: NSString = ABRecordCopyCompositeName(contactPerson).takeRetainedValue() as NSString
                objContact.strFirstName=contactName
                
                
                
                
                let strPrefix:ABMultiValueRef = extractABEmailRef(ABRecordCopyValue(record, kABPersonPrefixProperty))!
                objContact.strPrefix=strPrefix as! NSString

                
                
                let emailArray:ABMultiValueRef = extractABEmailRef(ABRecordCopyValue(record, kABPersonEmailProperty))!
                for (var j = 0; j < ABMultiValueGetCount(emailArray); ++j) {
                    var emailAdd = ABMultiValueCopyValueAtIndex(emailArray, j)
                    var myString = extractABEmailAddress(emailAdd)
                    NSLog("email: \(myString!)")
                    objContact.arrEmailAddress .addObject(myString!)
                }
                
                
                let numbers:ABMultiValue = ABRecordCopyValue(
                    record, kABPersonPhoneProperty).takeRetainedValue()
                for ix in 0 ..< ABMultiValueGetCount(numbers) {
                    let label = ABMultiValueCopyLabelAtIndex(numbers,ix).takeRetainedValue() as String
                    let value = ABMultiValueCopyValueAtIndex(numbers,ix).takeRetainedValue() as! String
                    print("Phonenumber \(label) is \(value)")
                }
                
                
                let img = ABPersonCopyImageDataWithFormat(record, kABPersonImageFormatThumbnail).takeRetainedValue()
                objContact.imgProfile=UIImage(data: img as! NSData)
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchContacts()
        
    }
    func extractABEmailAddress (abEmailAddress: Unmanaged<AnyObject>!) -> String? {
        if let ab = abEmailAddress {
            return Unmanaged.fromOpaque(abEmailAddress.toOpaque()).takeUnretainedValue() as CFStringRef as String
        }
        return nil
    }
    func extractABEmailRef (abEmailRef: Unmanaged<ABMultiValueRef>!) -> ABMultiValueRef? {
        if let ab = abEmailRef {
            return Unmanaged<NSObject>.fromOpaque(ab.toOpaque()).takeUnretainedValue()
        }
        return nil
    }

    //TableView Delegate Event

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

