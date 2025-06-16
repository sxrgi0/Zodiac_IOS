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
    
    var horoscope: Horoscope!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = horoscope.name
        
        HoroscopeNameLabel.text = horoscope.name
        HoroscopeDatesLabel.text = horoscope.dates
        HoroscopeImageView.image = horoscope.getImage()
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
