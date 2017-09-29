//
//  YoutubePlayerViewController.swift
//  CodingExercise
//
//  Created by Suslov Babu on 28/09/17.
//  Copyright © 2017 Suslov Babu. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class YoutubePlayerViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet var videoPlayer: YTPlayerView!
    var videoID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Youtube Player"
        videoPlayer.delegate = self
        videoPlayer.load(withVideoId: videoID)
        self.navigationController?.isNavigationBarHidden = false

    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        if state == YTPlayerState.ended {
            self.navigationController?.popViewController(animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
