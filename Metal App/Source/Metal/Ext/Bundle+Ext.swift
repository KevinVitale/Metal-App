import Foundation
import ModelIO

// 'Bundle' Ext.
//------------------------------------------------------------------------------
extension Bundle {
    final func modelAsset(forName name: String, withExtension extension: String) -> MDLAsset? {
        guard let url = url(forResource: name, withExtension: `extension`) else {
            return nil
        }
        return MDLAsset(url: url)
    }
}
