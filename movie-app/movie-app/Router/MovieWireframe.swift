//
//  MovieWireframe.swift
//  movie-app
//
//  Created by IRFAN TRIHANDOKO on 16/06/29.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import Foundation
import UIKit

public struct MovieWireframe {
    
    // Popular Page
    public static func performToPopular(caller: UIViewController) {
        let storyboard = UIStoryboard(name: "Popular", bundle: nil)
        let nav = storyboard.instantiateInitialViewController() as! UINavigationController
        caller.present(nav, animated: true, completion: nil)
    }
    
    // Movie Details Page
    public static func performToDetails(caller: UIViewController, id: Int) {
        let storyboard = UIStoryboard(name: "MovieDetails", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! MovieDetailsVC
        vc.id = id
        caller.navigationController?.pushViewController(vc, animated: true)
    }
    
}

