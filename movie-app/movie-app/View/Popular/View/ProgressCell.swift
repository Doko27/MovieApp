//
//  ProgressCell.swift
//  movie-app
//
//  Created by IRFAN TRIHANDOKO on 04/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit

protocol ProgressDelegate {
    func loadMore()
}

class ProgressCell: UITableViewCell {
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var moreBtn: UIButton!
    var delegate: ProgressDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setLoadMore() {
        loadingView.isHidden = true
        moreBtn.setTitle("Load More", for: .normal)
    }
    
    @IBAction func moreAction(_ sender: UIButton) {
        loadingView.isHidden = false
        moreBtn.setTitle("", for: .normal)
        delegate?.loadMore()
    }
    

}
