//
//  DemoViewController.swift
//  AutoLayout1
//
//  Created by Asif on 27/09/23.
//

import UIKit

class DemoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let screenWidth = UIScreen.main.bounds.size.width
            let screenHeight = UIScreen.main.bounds.size.height

            // Set the desired width and height for the image view (e.g., 50% of the screen width and height)
            let desiredWidth = screenWidth * 0.5
            let desiredHeight = screenHeight * 0.5

            // Update the image view's frame with the calculated width and height
            imageView.frame = CGRect(x: 0, y: 0, width: desiredWidth, height: desiredHeight)

            // You can also set content mode if needed (e.g., .scaleAspectFit or .scaleAspectFill)
            imageView.contentMode = .scaleAspectFit
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
