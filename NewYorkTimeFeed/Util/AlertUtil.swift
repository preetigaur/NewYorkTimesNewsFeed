//
//  AlertUtil.swift
//  NewYorkTimeFeed
//
//  Created by Preeti Gaur on 10/06/22.
//

import UIKit

class AlertUtil {
  static func showAlertMessage(
    _ targetVC: UIViewController, withTitle title: String?, andMessage message: String?) {
      
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      targetVC.present(alert, animated: true, completion: nil)
    }
}
