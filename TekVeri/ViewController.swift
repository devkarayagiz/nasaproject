//
//  ViewController.swift
//  TekVeri
//
//  Created by krygz on 17.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    var model : [Model] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
    }
    
    func fetchData()
    {
        var request = URLRequest(url: URL(string: "https://api.nasa.gov/planetary/apod?api_key=E4uzZsdE07QgBda8DE7fNswRnWmSn7Z7RroiflI6")!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil
            {
                return
            }
            
            else
            {
                if let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                    
                    // title
                    let title = json["title"] as? String ?? "N/A"
                    //print("title : \(title)")
                    
                    // copyright
                    let copyright = json["copyright"] as? String ?? "N/A"
                    //print("copyright: \(copyright)")
                    
                    // date
                    let date = json["date"] as? String ?? "N/A"
                    //print("date : \(date)")
                    
                    // explanation
                    let explanation = json["explanation"] as? String ?? "N/A"
                    //print("explanation : \(explanation)")
                    
                    // hdurl
                    let hdurl = json["hdurl"] as? String ?? "N/A"
                    //print("hdurl : \(hdurl)")
                    
                    //self.model.append(Model(title: "\(["title"])", copyright: "\(["copyright"])", explanation: "\(["explanation"])", date: "\(["date"])" ,hdurl: "\(["hdurl"])"))
                    
                    DispatchQueue.main.sync {
                        self.titleLabel.text = title
                        self.copyrightLabel.text = copyright
                        self.dateLabel.text = date
                        self.textView.text = explanation
                        do
                        {
                            self.imageView.image = UIImage(data: try Data(contentsOf: URL(string: hdurl)!))
                        }
                        catch
                        {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }.resume()
    }


}

