//
//  NowPlayingCell.swift
//  movie-app
//
//  Created by IRFAN TRIHANDOKO on 03/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

class PopularCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupData(data: PopularItemModel?) {
        posterImg.sd_setImage(with: URL(string: "\(BaseURL.GetImageUrl())\(data?.backdropPath ?? "")")) { (img, err, cache, url) in
            self.posterImg.setLoad(isLoad: false, style: .medium)
            if err == nil {
                self.posterImg.image = img
            } else {
                self.posterImg.image = nil
                self.posterImg.backgroundColor = UIColor.lightGray
            }
        }
        titleLbl.text = data?.title ?? ""
        overviewLbl.text = data?.overview ?? ""
        ratingView.settings.fillMode = .precise
        ratingView.rating = Double(data?.averageRating ?? 0.0)/2.0
    }
}
