//
//  HCaptchaURLOpener.swift
//  HCaptcha
//
//  Copyright © 2022 HCaptcha. All rights reserved.
//

#if canImport(UIKit)
  import UIKit
#elseif canImport(AppKit)
  import AppKit
#endif

/// The protocol for a contractor which can handle/open URLs in an external viewer/browser
internal protocol HCaptchaURLOpener {
  /**
     Return true if url can be handled
     - parameter url: The URL to be checked
     */
  func canOpenURL(_ url: URL) -> Bool

  /**
     Handle passed url
     - parameter url: The URL to be checked
     */
  func openURL(_ url: URL)
}

/// UIApplication based implementation
internal class HCaptchaAppURLOpener: HCaptchaURLOpener {
  func canOpenURL(_ url: URL) -> Bool {
    #if os(iOS)
      return UIApplication.shared.canOpenURL(url)
    #elseif os(macOS)
      return NSWorkspace.shared.urlForApplication(toOpen: url) != nil
    #else
      return false
    #endif
  }

  func openURL(_ url: URL) {
    #if os(iOS)
      if #available(iOS 10.0, *) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
      } else {
        UIApplication.shared.openURL(url)
      }
    #elseif os(macOS)
      NSWorkspace.shared.open(url)
    #endif
  }
}
