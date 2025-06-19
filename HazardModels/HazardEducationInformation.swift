import SwiftUI

extension HazardType {
    var description: String {
        switch self {
        case .earthquake:
            return "Earthquakes are sudden shaking movements of the ground. During an earthquake, seek cover under sturdy furniture like tables, protect your head, and stay away from heavy objects that may fall."
        case .fire:
            return "Fires can spread quickly. Stay low to avoid smoke, exit through safe routes, and avoid using elevators. Be cautious around fire-prone areas like stoves and fireplaces."
        case .flood:
            return "Floods can occur with little warning. Move to higher ground, avoid electrical hazards, and seal doors and windows to block water. Monitor water levels and stay prepared."
        case .tornado:
            return "Tornados are powerful and destructive. Seek shelter in a basement or an interior room without windows. Secure doors and windows, and stay away from openings."
        }
    }
    
    var thingsToAvoid: [String] {
        switch self {
        case .earthquake:
            return [
                "Standing under doorways.",
                "Running outside during shaking.",
                "Ignoring aftershocks.",
                "Not securing heavy furniture."
            ]
        case .fire:
            return [
                "Using elevators during a fire.",
                "Ignoring smoke alarms.",
                "Opening hot doors.",
                "Not staying low to avoid smoke."
            ]
        case .flood:
            return [
                "Driving through floodwaters.",
                "Ignoring evacuation orders.",
                "Underestimating water depth.",
                "Not sealing doors and windows."
            ]
        case .tornado:
            return [
                "Opening windows.",
                "Staying in mobile homes.",
                "Ignoring tornado warnings.",
                "Not securing doors and windows."
            ]
        }
    }
    
    var thingsThatAreGood: [String] {
        switch self {
        case .earthquake:
            return [
                "Taking cover under sturdy tables.",
                "Protecting your head and neck.",
                "Staying away from windows.",
                "Securing heavy furniture."
            ]
        case .fire:
            return [
                "Staying low to avoid smoke.",
                "Exiting through safe routes.",
                "Checking doors for heat before opening.",
                "Using fire extinguishers if safe."
            ]
        case .flood:
            return [
                "Moving to higher ground.",
                "Avoiding electrical hazards.",
                "Sealing doors and windows.",
                "Monitoring water levels."
            ]
        case .tornado:
            return [
                "Seeking shelter in a basement.",
                "Staying in interior rooms without windows.",
                "Securing doors and windows.",
                "Preparing a tornado kit."
            ]
        }
    }
}

