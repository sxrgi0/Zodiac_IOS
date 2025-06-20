//
//  DetailViewController.swift
//  Zodiac_IOS
//
//  Created by Tardes on 16/6/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var HoroscopeImageView: UIImageView!
    @IBOutlet weak var HoroscopeNameLabel: UILabel!
    @IBOutlet weak var HoroscopeDatesLabel: UILabel!
    
    @IBOutlet weak var favoriteMenu: UIBarButtonItem!
    @IBOutlet weak var shareMenu: UIBarButtonItem!
    
    @IBOutlet weak var horoscopeLuckTextView: UITextView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var horoscope: Horoscope!
    var isFavorite: Bool = false
    
    var horoscopeLuck: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = horoscope.name
        
        HoroscopeNameLabel.text = horoscope.name
        HoroscopeDatesLabel.text = horoscope.dates
        HoroscopeImageView.image = horoscope.getImage()
        
        isFavorite = SessionManager.isFavoriteHoroscope(id: horoscope.id)
        
        setFavoriteIcon()
        
        getHoroscopeLuck(period: "daily")
    }
    
    func setFavoriteIcon(){
        // Si isFavorite es true heart.fill, else heart
        favoriteMenu.image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
    
    @IBAction func setFavorite(_ sender: Any) {
        isFavorite = !isFavorite
        
        if(isFavorite){
            SessionManager.setFavoriteHoroscope(id: horoscope.id)
        } else {
            SessionManager.setFavoriteHoroscope(id: "")
        }
        setFavoriteIcon()
    }
    
    @IBAction func shared(_ sender: Any) {
        if let text = horoscopeLuck {
            let textToShare = [text]

            let activityVIewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityVIewController.popoverPresentationController?.sourceView = self.view
            
            self.present(activityVIewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func didChangePeriod(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: getHoroscopeLuck(period: "daily")
        case 1: getHoroscopeLuck(period: "weekly")
        default: getHoroscopeLuck(period: "monthly")
        }
    }
    
    func getHoroscopeLuck(period: String) {
        loadingView.isHidden = false
        guard let url = URL(string: "https://horoscope-app-api.vercel.app/api/v1/get-horoscope/\(period)?sign=\(horoscope.id)&day=TODAY") else {
            loadingView.isHidden = true
            
            return
        }
        Task {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                /*if let str = String(data: data, encoding: .utf8) {
                 print("Succesfully decoded: \(str)")
                 }*/
                
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    DispatchQueue.main.async {
                        self.loadingView.isHidden = true
                    }
                    return // ERROR
                }
                
                let jsonData = json["data"] as? [String: String]
                
                horoscopeLuck = jsonData?["horoscope_data"] ?? ""
                
                DispatchQueue.main.async {
                    self.horoscopeLuckTextView.text = self.horoscopeLuck
                    self.loadingView.isHidden = true
                }
                
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.loadingView.isHidden = true
                }
            }
        }
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
