import SwiftUI

class ThemeManager: ObservableObject {
  static let shared = ThemeManager()

  // Derived from SharedData.themeColors - single source of truth
  static var availableColors: [(name: String, color: Color)] {
    SharedData.themeColors.map { (name: $0.name, color: Color(hex: $0.hex)) }
  }

  private static let defaultColorName = "Ocean Blue"
  private static let fallbackColor = Color(hex: "#007aff")  // Ocean Blue

  @AppStorage(
    "foqosThemeColorName", store: UserDefaults(suiteName: "group.dev.ambitionsoftware.foqos"))
  private var themeColorName: String = defaultColorName

  var selectedColorName: String {
    get { themeColorName }
    set {
      themeColorName = newValue
      objectWillChange.send()
    }
  }

  var themeColor: Color {
    Self.availableColors.first(where: { $0.name == themeColorName })?.color
      ?? Self.availableColors.first?.color
      ?? Self.fallbackColor
  }

  func setTheme(named name: String) {
    selectedColorName = name
  }
}

// Note: Color(hex:) and toHex() extensions are defined in Shared.swift
// to avoid duplication and ensure widget compatibility
