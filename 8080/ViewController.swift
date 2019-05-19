//
//  ViewController.swift
//  8080
//
//  Created by shahid mohd on 19/05/19.
//  Copyright © 2019 shahidmohd. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataTableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        let cellContent = self.dataArray[indexPath.row]
        print(cellContent.toDictionary())
        cell.fileName.text = cellContent.movieTitle
        cell.filePeer.text = "\(cellContent.totalNumberPeers!)"
        cell.fileSeed.text = "\(cellContent.totalNumberSeeds!)"
        cell.fileSize.text = "\(cellContent.downloadedSize!) GB"
        cell.fileSpeedDownload.text = "\(cellContent.downloadSpeed!)"
        cell.fileSpeedUpload.text = "\(cellContent.uploadSpeed!)"
        cell.fileAdded.text = "\(cellContent.addedDateTime!)"
        cell.fileUploaded.text = "\(cellContent.uploadedSize!)"
        switch cellContent.status {
        case 0:
            cell.fileStatus.text = "Downloading"
            cell.imageIcon.image = UIImage(named: "download")
        case 1:
            cell.fileStatus.text = "uploading"
            cell.imageIcon.image = UIImage(named: "upload")

        default:
            cell.fileStatus.text = "pause"
            cell.imageIcon.image = UIImage(named: "pauseYellow")

        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    var dataArray:[dataResponse] = []
    
    var tempArr:[dataResponse]=[]
    var isDataLoading:Bool=false
    var pageNo:Int=1
    var limit:Int=10
    var offset:Int=0
    var connectionCount:Int=0
    var activityIndicator=UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    @IBOutlet weak var dataTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataTableView.tableFooterView=activityIndicator

         getData()
        // Do any additional setup after loading the view.
    }

    func getData() {
                SVProgressHUD.show()
        
        let url = "https://fakedownloader.getsandbox.com/getdownloadstatus"
     
        
        api_manager.GETApi(url, param: nil, header: nil) { (response, error, statusCode) in
            
            print(response?.result.value)
            if response == nil{
                showAlert(msg: "Some problem occurs", title: "Alert", sender: self)
                //                SVProgressHUD.dismiss()
                return
            }
            self.dataArray = []
            for obj in response?.result.value as! [NSDictionary]{
                print(obj)
                self.dataArray.append(dataResponse(fromDictionary: obj as! [String : Any]))
            }
            
            if self.dataArray.count > self.limit {
                for i in 0..<self.limit{
                    self.tempArr.append(self.dataArray[i])
                }
            }else{
                for i in 0..<self.dataArray.count{
                    self.tempArr.append(self.dataArray[i])
                }
                
            }
            SVProgressHUD.dismiss()
            
            self.dataTableView.reloadData()
            print("Data fetched")
           
        }
        
    }
    
   
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("scrollViewDidEndDragging")
        if ((dataTableView.contentOffset.y + dataTableView.frame.size.height) >= dataTableView.contentSize.height)
        {
            if !isDataLoading{
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                }
                //isDataLoading = true
                if dataArray.count > limit {
                    self.offset=tempArr.count
                    self.limit=self.offset+limit
                    
                    
                    addContactsList(offset: self.offset, limit: self.limit)
                    
                }
                
            }
            
            
        }
        
        
    }
    
    func addContactsList(offset:Int,limit:Int){
        if self.dataArray.count > limit{
            
            for i in offset..<limit{
                tempArr.append(dataArray[i])
            }
            self.dataTableView.reloadData()
        }else{
            for i in offset..<self.dataArray.count{
                tempArr.append(dataArray[i])
            }
            self.dataTableView.reloadData()
            self.dataTableView.tableFooterView?.isHidden=true
            self.isDataLoading = true
            
        }
        
    }
}

