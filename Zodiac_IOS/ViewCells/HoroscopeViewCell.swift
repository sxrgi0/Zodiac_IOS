//
//  HoroscopeViewCell.swift
//  Zodiac_IOS
//
//  Created by Tardes on 13/6/25.
//

import UIKit

class HoroscopeViewCell: UITableViewCell {

    @IBOutlet weak var HoroscopeImageView: UIImageView!
    @IBOutlet weak var HoroscopeNameLabel: UILabel!
    @IBOutlet weak var HoroscopeDatesLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    func render(horoscope: Horoscope){
        HoroscopeNameLabel.text = horoscope.name
        HoroscopeDatesLabel.text = horoscope.dates
        HoroscopeImageView.image = horoscope.getImage()
        favoriteImageView.isHidden = !SessionManager.isFavoriteHoroscope(id: horoscope.id)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
