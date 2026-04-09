//
//  ContentView.swift
//  Good News Gospel
//
//  Created by Jesse Johnson on 9/4/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isBookmarked = false

    private let momentText = "Abide in me, and I in you. As the branch cannot bear fruit by itself unless it remains in the vine, so neither can you unless you remain in me. I am the vine. You are the branches."
    private let accentBlue = Color(red: 0.45, green: 0.63, blue: 0.86)
    private let accentBlueDeep = Color(red: 0.33, green: 0.49, blue: 0.72)
    private let backgroundTop = Color(red: 0.98, green: 0.99, blue: 1.00)
    private let backgroundBottom = Color(red: 0.92, green: 0.96, blue: 1.00)
    private let textPrimary = Color(red: 0.18, green: 0.23, blue: 0.32)
    private let textSecondary = Color(red: 0.44, green: 0.52, blue: 0.62)

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                background

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        Spacer(minLength: 36)
                        gospelHeader
                        Spacer(minLength: 52)
                        readingBody
                        Spacer(minLength: 68)
                        actionButtons
                        Spacer(minLength: 28)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: geometry.size.height, alignment: .top)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                }
            }
        }
        .preferredColorScheme(.light)
    }

    private var background: some View {
        LinearGradient(
            colors: [backgroundTop, backgroundBottom],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .overlay(alignment: .topTrailing) {
            Circle()
                .fill(accentBlue.opacity(0.10))
                .frame(width: 280, height: 280)
                .blur(radius: 24)
                .offset(x: 84, y: -72)
        }
        .overlay(alignment: .bottomLeading) {
            Circle()
                .fill(Color.white.opacity(0.78))
                .frame(width: 250, height: 250)
                .blur(radius: 34)
                .offset(x: -72, y: 88)
        }
        .ignoresSafeArea()
    }

    private var gospelHeader: some View {
        HStack(spacing: 10) {
            Color.clear
                .frame(width: 18, height: 18)

            Text("John")
                .font(.system(size: 18, weight: .medium))
                .tracking(0.5)
                .foregroundStyle(textSecondary)
                .accessibilityIdentifier("gospelNameLabel")
                .accessibilityAddTraits(.isHeader)

            Color.clear
                .frame(width: 18, height: 18)
        }
        .frame(maxWidth: .infinity)
    }

    private var readingBody: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Spacer()
                bookmarkButton
            }

            Text(momentText)
                .font(.system(size: 30, weight: .regular))
                .lineSpacing(12)
                .foregroundStyle(textPrimary)
                .multilineTextAlignment(.leading)
                .accessibilityIdentifier("gospelMomentText")

            Text("John 15:4–5")
                .font(.system(size: 17, weight: .medium))
                .tracking(0.2)
                .foregroundStyle(textSecondary)
                .accessibilityIdentifier("scriptureReferenceLabel")
        }
        .frame(maxWidth: 480, alignment: .leading)
        .frame(maxWidth: .infinity)
    }

    private var bookmarkButton: some View {
        Button {
            isBookmarked.toggle()
        } label: {
            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(isBookmarked ? accentBlueDeep : textSecondary)
                .frame(width: 44, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.white.opacity(0.55))
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(accentBlue.opacity(0.14), lineWidth: 1)
                }
        }
        .buttonStyle(.plain)
        .shadow(color: accentBlue.opacity(0.08), radius: 18, x: 0, y: 10)
        .accessibilityIdentifier("bookmarkButton")
        .accessibilityLabel("Save moment")
        .accessibilityValue(isBookmarked ? "Saved" : "Not saved")
    }

    private var actionButtons: some View {
        VStack(spacing: 14) {
            Button("Keep Reading") {
            }
            .buttonStyle(
                MomentActionButtonStyle(
                    fill: accentBlue,
                    border: accentBlue.opacity(0.12),
                    foreground: .white
                )
            )
            .accessibilityIdentifier("keepReadingButton")

            Button("Done for Now") {
            }
            .buttonStyle(
                MomentActionButtonStyle(
                    fill: Color.white.opacity(0.68),
                    border: accentBlue.opacity(0.16),
                    foreground: accentBlueDeep
                )
            )
            .accessibilityIdentifier("doneForNowButton")
        }
        .frame(maxWidth: 480)
    }
}

private struct MomentActionButtonStyle: ButtonStyle {
    let fill: Color
    let border: Color
    let foreground: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 17, weight: .semibold))
            .foregroundStyle(foreground)
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(fill)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .stroke(border, lineWidth: 1)
            }
            .shadow(color: Color.black.opacity(0.04), radius: 16, x: 0, y: 8)
            .opacity(configuration.isPressed ? 0.92 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
            .animation(.easeOut(duration: 0.16), value: configuration.isPressed)
    }
}

#Preview {
    ContentView()
}
