import UIKit

class IndexingTableViewController: UIViewController {
    
    @IBOutlet var tblView : UITableView?
    /* type to represent table items
    `section` stores a `UITableView` section */
    class User: NSObject {
        let name: String
        var section: Int?
        
        init(name: String) {
            self.name = name
        }
    }
    override func viewDidLoad() {
        tblView?.registerClass(CustomCell.self, forCellReuseIdentifier: "UITableViewCell")

    }
    // custom type to represent table sections
    class Section {
        var users: [User] = []
        
        func addUser(user: User) {
            self.users.append(user)
        }
    }
    
    // raw user data
    let names = [
        "Clementine",
        "Bessie",
        "Yolande",
        "Tynisha",
        "Ellyn",
        "Trudy",
        "Fredrick",
        "Letisha",
        "Ariel",
        "Bong",
        "Jacinto",
        "Dorinda","Nahim","Nayan","Nirav","Nikunj","Naushad",
        "Aiko",
        "Loma",
        "Augustina",
        "Margarita",
        "Jesenia",
        "Kellee",
        "Annis",
        "Charlena"
    ]
    // `UIKit` convenience class for sectioning a table
    let collation = UILocalizedIndexedCollation.currentCollation()
        as UILocalizedIndexedCollation
    
    // table sections
    var sections: [Section] {
        // return if already initialized
        if self._sections != nil {
            return self._sections!
        }
        
        // create users from the name list
        let users: [User] = names.map { name in
            let user = User(name: name)
            user.section = self.collation.sectionForObject(user, collationStringSelector: "name")
            return user
        }
        
        // create empty sections
        var sections = [Section]()
        print(self.collation.sectionIndexTitles)
        for _ in 0..<self.collation.sectionIndexTitles.count {
            sections.append(Section())
        }
        
        // put each user in a section
        for user in users {
            sections[user.section!].addUser(user)
        }
        
        // sort each section
        for section in sections {
            section.users = self.collation.sortedArrayFromArray(section.users, collationStringSelector: "name") as! [User]
        }
        self._sections = sections
        return self._sections!
        
    }
    var _sections: [Section]?
    
    // table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView)
        -> Int {
            return self.sections.count
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int {
            return self.sections[section].users.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let user = self.sections[indexPath.section].users[indexPath.row]

            let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel!.text = user.name
            return cell
    }
    
    /* section headers
    appear above each `UITableView` section */
    func tableView(tableView: UITableView,
        titleForHeaderInSection section: Int)
        -> String {
            // do not display empty `Section`s
            if !self.sections[section].users.isEmpty {
                return self.collation.sectionTitles[section] as String
            }
            return ""
    }
    
    /* section index titles
    displayed to the right of the `UITableView` */
    func sectionIndexTitlesForTableView(tableView: UITableView)
        -> [AnyObject] {
            print(self.collation.sectionIndexTitles)
            return self.collation.sectionIndexTitles
    }
    
//    func tableView(tableView: UITableView,
//        sectionForSectionIndexTitle title: String,
//        atIndex index: Int)
//        -> Int {
//            print(self.collation.sectionForSectionIndexTitleAtIndex(index))
//            return self.collation.sectionForSectionIndexTitleAtIndex(index)
//    }
}
