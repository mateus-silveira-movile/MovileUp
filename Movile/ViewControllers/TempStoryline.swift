//
//  TempStoryline.swift
//  Movile
//
//  Created by iOS on 7/27/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import FloatRatingView
import TagListView
import BorderedView

class TempStoryline: UIViewController {
    
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var showPoster: UIImageView!
    @IBOutlet weak var storyline: UITextView!
    @IBOutlet weak var genres: TagListView!
    @IBOutlet weak var showRatingStars: FloatRatingView!
    @IBOutlet weak var showRatingNumber: UILabel!
    @IBOutlet weak var tagListView: TagListView!
    let formatter = NSNumberFormatter()
    let fav = FavoritesManager()
    
    var show: Show!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let placeholder = UIImage(named: "bg")
        
        //VERIFICAR IMAGEM!!
        if let url = show.fanart?.fullImageURL {
            showPoster.kf_setImageWithURL(url, placeholderImage: placeholder)
        } else {
            showPoster.image = placeholder
        }
        
        if fav.favoritesIdentifiers.contains(show.identifiers.trakt) {
            favButton.selected = true
        }
        
        storyline.text = show.overview
        
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        
        showRatingNumber.text = formatter.stringFromNumber(show.rating!)
        showRatingStars.rating = (show.rating!)
        
        for item in show.genres! {
            tagListView.addTag(item)
        }
        
        navTitle.title = show.title
        
    }
    
    @IBAction func favoriteClicked(sender: UIButton) {
        if sender.selected == false {
            fav.addIdentifier(show.identifiers.trakt)
            sender.selected = true
        } else {
            fav.removeIdentifier(show.identifiers.trakt)
            sender.selected = false
        }
    }
    
}
