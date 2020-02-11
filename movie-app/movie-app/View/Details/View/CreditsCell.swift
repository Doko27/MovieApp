//
//  CreditsCell.swift
//  movie-app
//
//  Created by IRFAN TRIHANDOKO on 04/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit

class CreditsCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var roleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.setupBorderView()
        profileImg.layer.cornerRadius = profileImg.frame.height/2
    }
    
    func setupData(data: MovieCreditsModel?) {
        profileImg.sd_setImage(with: URL(string: "\(BaseURL.GetImageUrl())\(data?.imagePath ?? "")")) { (img, err, cache, url) in
            self.profileImg.setLoad(isLoad: false, style: .medium)
            if err == nil {
                self.profileImg.image = img
            } else {
                self.profileImg.image = nil
                self.profileImg.backgroundColor = UIColor.lightGray
            }
        }
        nameLbl.text = data?.name ?? ""
        roleLbl.text = "As \(data?.role ?? "")"
    }
}
