//
//  CustomTableViewCell.swift
//  CourseworkIOS
//
//  Created by Sasitha Dilshan on 2/24/20.
//  Copyright © 2020 Sasitha Dilshan. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    

    @IBOutlet weak var More: UIButton!
    //    @IBOutlet weak var captiontext: UILabel!
    @IBOutlet weak var captiontext: UILabel!
    @IBOutlet weak var imagePOST: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profPic: UIImageView!
    
    var post: Post!
    
    weak var delegate : CustomTableViewCellDeligate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profPic.layer.cornerRadius = profPic.frame.size.width/2
        profPic.clipsToBounds = true
        profPic.layer.borderColor = UIColor.blue.cgColor
        profPic.layer.borderWidth = 5
        
//         self.More.addTarget(self, action: #selector(moreButton(_:)), for: .touchUpInside)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector())
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    @IBAction func MOreDetails(_ sender: Any) {
    }
    @IBAction func moreButton(_ sender: UIButton) {
//        if let user = User,
//            let delegate = delegate {
//            self.delegate?.moreDetailsTableViewCell(self, moreButtonFor: user)
    }
}
//}
protocol CustomTableViewCellDeligate: AnyObject {
    func moreDetailsTableViewCell(_ CustomTableViewCell: CustomTableViewCell, moreButtonFor user: String)

}
