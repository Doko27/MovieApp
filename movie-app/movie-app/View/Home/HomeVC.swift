//
//  HomeVC.swift
//  movie-app
//
//  Created by IRFAN TRIHANDOKO on 03/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit
import iCarousel
import SDWebImage

class HomeVC: BaseViewController {
    
    @IBOutlet weak var carouselView: iCarousel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var popularBtn: UIButton!
    
    var data: PopularModel?
    var request: MovieRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configView()
        showLoading(state: true)
        request?.doGetMovies(type: "now_playing", page: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func popularAction(_ sender: UIButton) {
        MovieWireframe.performToPopular(caller: self)
    }
}

// MARK: - Configure View
extension HomeVC {
    
    func configView() {
        dateLbl.text = DateHelper.dateParseToStringUTC(Date(), newFormat: "EEEE dd MMMM yyyy").uppercased()
        carouselView.delegate = self
        carouselView.dataSource = self
        carouselView.type = .rotary
        carouselView.isPagingEnabled = true
        popularBtn.setupBorderButton()
    }
}


// MARK: - Configure Carousel View
extension HomeVC: iCarouselDataSource, iCarouselDelegate {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 10
    }

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIImageView
        itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: carousel.frame.width, height: carousel.frame.height))
        itemView.contentMode = .scaleAspectFill
        itemView.clipsToBounds = true
        itemView.layer.cornerRadius = 20
        itemView.sd_setImage(with: URL(string: "\(BaseURL.GetImageUrl())\(data?.list?[index].posterPath ?? "")")) { (img, err, cache, url) in
            itemView.setLoad(isLoad: false, style: .medium)
            if err == nil {
                itemView.image = img
            } else {
                itemView.image = nil
                itemView.backgroundColor = UIColor.lightGray
            }
        }
        itemView.contentMode = .center
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        if errorMessageLbl.text?.isEmpty == true {
            MovieWireframe.performToDetails(caller: self, id: data?.list?[index].id ?? 0)
        }
    }
}


// MARK: - API Integration
extension HomeVC: MovieResponse {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configHome(vc: self)
    }
    
    func configHome(vc: HomeVC) {
        var present = MoviePresenter()
        present.output = vc
        vc.request = present
    }
    
    func displayMovies(result: PopularModel) {
        showLoading(state: false)
        data = result
        carouselView.reloadData()
        showErrorMessage(label: errorMessageLbl, message: "")
    }
    
    func displayError(message: String, object: Any) {
        showLoading(state: false)
        showErrorMessage(label: errorMessageLbl, message: message)
    }
    
}
