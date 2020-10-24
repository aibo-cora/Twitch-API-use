//
//  ViewController.swift
//  mayk
//
//  Created by Yura on 10/23/20.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVKit

class Streaming: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var streams = [Stream]()
    
    let cellID = "StreamCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        tableView.delegate = self
        tableView.dataSource = self
       
    }
    
    @IBAction func fetchStreams(_ sender: Any) {
        let clientID = "41l4s7i4hz20jj82vew5m5c6sr5t9t"
        let token = "q47vzaymcqk1sw1ox02oe54ehs7h5s"
        
        let apiURL = "https://api.twitch.tv/helix/streams"
        let headers: HTTPHeaders = [
                    "client-id": "\(clientID)",
                    "Authorization" : "Bearer \(token)",
                    "Content-Type": "application/json"]
        
        AF.request(apiURL, method: .get, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let jsonData = JSON(value)
                
                for pair in jsonData {
                    let (key, data) = pair
                    
                    if key == "data" {
                        for count in 0...19 {
                            let stream = Stream()
                            
                            stream.username = data[count]["user_name"].stringValue
                            stream.thumbnail = data[count]["thumbnail_url"].stringValue
                            
                            self.streams.append(stream)
                        }
                    }
                }
                self.tableView.reloadData()
                
            case .failure (let error):
                print("GET error: \(error.localizedDescription)")
            }
        }

    }
    
}

extension Streaming: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        streams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? CellView else {
            fatalError("No avaialble cells.")
        }
        
        let stream = streams[indexPath.row]
        
        if var imageLink = stream.thumbnail {
            imageLink = imageLink.replacingOccurrences(of: "{width}", with: "320")
            imageLink = imageLink.replacingOccurrences(of: "{height}", with: "240")
            
            
            let formattedURL = imageLink.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let imageURL = URL(string: formattedURL)
            
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    if let url = imageURL {
                        let imageData = try Data(contentsOf: url)
                        
                        DispatchQueue.main.async {
                            cell.photoView.image = UIImage(data: imageData)
                        }
                    }
                } catch {
                    
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stream = streams[indexPath.row]
        
        if let username = stream.username {
            let streamText = "https://www.twitch.tv/" + username
            guard let showStreamView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "BrowserID") as? Browser else {return}
            let navigation = UINavigationController(rootViewController: showStreamView)
            
            showStreamView.modalPresentationStyle = .fullScreen
            showStreamView.streamWebURL = URL(string: streamText)
            
            present(navigation, animated: true) {
                
            }
        }
    }
}

