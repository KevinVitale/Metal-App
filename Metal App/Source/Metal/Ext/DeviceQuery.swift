import Metal

struct DeviceQuery
{
    public static var devices: LazyCollection<[MTLDevice]> {
        return MTLCopyAllDevices().lazy
    }
    
    public static var lowPowerDevices: [MTLDevice] {
        return devices.filter {
            $0.isLowPower
        }
    }
    
    public static var highPowerDevices: [MTLDevice] {
        return devices.filter {
            !$0.isLowPower
        }
    }
    
    public static var integratedDevice: MTLDevice? {
        return lowPowerDevices.first
    }
    
    public static var dedicatedDevice: MTLDevice? {
        return highPowerDevices.first
    }

    public static func device(after registryID: UInt64) -> MTLDevice? {
        if let index = devices.firstIndex(where: { registryID == $0.registryID })?.advanced(by: 1)
            , index != devices.endIndex {
            return devices[index]
        } else if let firstDevice = devices.first {
            return firstDevice
        } else {
            return MTLCreateSystemDefaultDevice()
        }
    }
}
