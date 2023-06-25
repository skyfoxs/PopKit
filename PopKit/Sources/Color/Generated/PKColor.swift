// This code was generated with PopKitGen
// DO NOT change manually
import UIKit

struct PKColor {
    let backgroundPrimary: UIColor
    let backgroundSecondary: UIColor

    func uiColor(for alias: PKColorAlias) -> UIColor {
        switch alias {
        case .backgroundPrimary: return backgroundPrimary
        case .backgroundSecondary: return backgroundSecondary
        }
    }
}

public enum PKColorAlias {
    case backgroundPrimary
    case backgroundSecondary
}