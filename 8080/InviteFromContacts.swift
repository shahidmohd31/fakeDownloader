//
//  InviteFrdsController.swift

import UIKit
import Contacts
//import AlamofireImage
import MessageUI

class InviteFrdsController: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate,UIScrollViewDelegate
 {
    @IBOutlet weak var tableView: UITableView!
     var results: [CNContact] = []
     var tempArr:[CNContact]=[]
    var isDataLoading:Bool=false
    var pageNo:Int=1
    var limit:Int=20
    var offset:Int=0
    var connectionCount:Int=0
    var activityIndicator=UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tableView.tableFooterView=activityIndicator
        tableView.delegate=self
        // Do any additional setup after loading the view.
    }

    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return tempArr.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inviteFrdsCell=tableView.dequeueReusableCell(withIdentifier: "inviteFrdCell", for: indexPath) as! InviteFrdsViewCell
        
        let item = results[indexPath.row]
        
        inviteFrdsCell.inviteBtn.tag=indexPath.row
        inviteFrdsCell.inviteBtn.addTarget(self, action: #selector(inviteFriends(_ :)), for: UIControlEvents.touchUpInside)
        if item.isKeyAvailable(CNContactGivenNameKey){
            inviteFrdsCell.nameLable.text=item.givenName
        }else{
            inviteFrdsCell.nameLable.text="No name"
        }
        
        if item.isKeyAvailable(CNContactImageDataKey){
            if item.imageData != nil{
          inviteFrdsCell.userProfile.image=UIImage(data: item.imageData!)?.af_imageRoundedIntoCircle()
          
            }else{
                inviteFrdsCell.userProfile.image=UIImage(named:"img_profile")
            }
        }else{
            inviteFrdsCell.userProfile.image=UIImage(named:"img_profile")
        }
        if item.isKeyAvailable(CNContactPhoneNumbersKey){
            let phoneNOs=item.phoneNumbers
            if phoneNOs.count > 0{
            let phNo=phoneNOs[0].value.stringValue
            inviteFrdsCell.phoneNoLable.text=phNo
            }
        }else{
            inviteFrdsCell.phoneNoLable.text="0000000000"
 
        }
        
        return inviteFrdsCell
    }
    
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        default:
            break;
        }
    }
    
    func inviteFriends(_ sender:UIButton){
      print("Invite Frds no \(results[sender.tag].phoneNumbers[0].value.stringValue)")
        
        let PhNo = results[sender.tag].phoneNumbers[0].value.stringValue
       if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "HI,I joined UnifieApp you can also join the same"
            controller.recipients = [PhNo]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
      }else{
            print("Not Avilable \(MFMessageComposeViewController.canSendText())")
      }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global().async {
            
        
        AppDelegate.AppDel.requestAccess { success in
        if success{
            let keys = [CNContactGivenNameKey ,CNContactImageDataKey,CNContactPhoneNumbersKey]
            var message: String!
            //let request=CNContactFetchRequest(keysToFetch: keys)
            let contactsStore = AppDelegate.AppDel.contactStore
            // Get all the containers
            var allContainers: [CNContainer] = []
            do {
                allContainers = try contactsStore.containers(matching: nil)
            } catch {
                print("Error fetching containers")
            }
            
            
            
            // Iterate all containers and append their contacts to our results array
            for container in allContainers {
                let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
                
                do {
                    let containerResults = try contactsStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keys as [CNKeyDescriptor])
                    DispatchQueue.main.async {
                        let array=Array(Set(containerResults))
                        
                        self.results.append(contentsOf: array)
                        if self.results.count > 20 {
                        for i in 0..<20{
                            self.tempArr.append(self.results[i])
                        }
                        }else{
                            for i in 0..<self.results.count{
                                self.tempArr.append(self.results[i])
                            }
                            
                        }
                        
                        self.tableView.reloadData()
                    }
                    
                    //message="\(self.results.count)"
                } catch {
                    print("Error fetching results for container")
                }
            }
            
            if message != nil {
                DispatchQueue.main.async {
                    AppDelegate.AppDel.showMsg(message: message)
                }
                
            
            
        }else{
            
        }
        
        
    }
        }
    }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        print("scrollViewWillBeginDragging")
        //  isDataLoading = false
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDecelerating")
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("scrollViewDidEndScrollingAnimation")
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("scrollViewDidEndDragging")
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
        {
            if !isDataLoading{
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                }
                //isDataLoading = true
                if results.count > 20 {
                self.offset=tempArr.count
                self.limit=self.offset+20
                
            
                addContactsList(offset: self.offset, limit: self.limit)
                   
                }
                
            }
            
            
        }
        
        
    }
    
    func addContactsList(offset:Int,limit:Int){
        if self.results.count > limit{
        
        for i in offset..<limit{
            tempArr.append(results[i])
        }
            self.tableView.reloadData()
        }else{
            for i in offset..<self.results.count{
                tempArr.append(results[i])
            }
            self.tableView.reloadData()
            self.tableView.tableFooterView?.isHidden=true
            self.isDataLoading = true

        }
        
    }
    
}
