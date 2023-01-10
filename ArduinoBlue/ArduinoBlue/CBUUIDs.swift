//
//  CBUUIDs.swift
//  ArduinoBlue
//
//  Created by Burak Altunoluk on 09/01/2023.
//
import Foundation
import CoreBluetooth

struct CBUUIDs{

    static let kBLEService_UUID = "57061D6E-548C-66ED-2AFC-A7F67E9A90BE"
    static let kBLE_Characteristic_uuid_Tx = "57061D6E-548C-66ED-2AFC-A7F67E9A90BE"
    static let kBLE_Characteristic_uuid_Rx = "57061D6E-548C-66ED-2AFC-A7F67E9A90BE"

    static let BLEService_UUID = CBUUID(string: kBLEService_UUID)
    static let BLE_Characteristic_uuid_Tx = CBUUID(string: kBLE_Characteristic_uuid_Tx)//(Property = Write without response)
    static let BLE_Characteristic_uuid_Rx = CBUUID(string: kBLE_Characteristic_uuid_Rx)// (Property = Read/Notify)

}
