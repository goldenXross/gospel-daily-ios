//
//  ContentView.swift
//  Good News Gospel
//
//  Created by Jesse Johnson on 9/4/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isBookmarked = false

    private let moment = GospelMoment(
        gospel: "John",
        chapterVerse: "15:4–5",
        text: "Abide in me, and I in you. As the branch cannot bear fruit by itself unless it remains in the vine, so neither can you unless you remain in me. I am the vine. You are the branches."
    )
    private let accentBlue = Color(red: 0.55, green: 0.70, blue: 0.88)
    private let accentBlueDeep = Color(red: 0.36, green: 0.52, blue: 0.74)
    private let backgroundTop = Color(red: 0.98, green: 0.99, blue: 1.00)
    private let backgroundBottom = Color(red: 0.92, green: 0.96, blue: 1.00)
    private let textPrimary = Color(red: 0.18, green: 0.23, blue: 0.32)
    private let textSecondary = Color(red: 0.44, green: 0.52, blue: 0.62)
    private let textHeader = Color(red: 0.34, green: 0.42, blue: 0.52)

    private var gospelTitle: String {
        "Gospel of \(moment.gospel)"
    }

    private var scriptureReference: String {
        "\(moment.gospel) \(moment.chapterVerse)"
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                background

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        Spacer(minLength: 40)
                        gospelHeader
                        Spacer(minLength: 72)
                        readingBody
                        Spacer(minLength: 92)
                        actionButtons
                        Spacer(minLength: 32)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: geometry.size.height, alignment: .top)
                    .padding(.horizontal, 28)
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

            Text(gospelTitle)
                .font(.system(size: 16, weight: .semibold))
                .tracking(0.2)
                .foregroundStyle(textHeader)
                .accessibilityIdentifier("gospelNameLabel")
                .accessibilityAddTraits(.isHeader)

            Color.clear
                .frame(width: 18, height: 18)
        }
        .frame(maxWidth: .infinity)
    }

    private var readingBody: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(moment.text)
                .font(.system(size: 27, weight: .regular))
                .lineSpacing(15)
                .foregroundStyle(textPrimary)
                .multilineTextAlignment(.leading)
                .accessibilityIdentifier("gospelMomentText")

            HStack(alignment: .center, spacing: 12) {
                Text(scriptureReference)
                    .font(.system(size: 17, weight: .medium))
                    .tracking(0.2)
                    .foregroundStyle(textSecondary)
                    .accessibilityIdentifier("scriptureReferenceLabel")

                Spacer(minLength: 4)

                bookmarkButton
            }
            .padding(.top, 32)
        }
        .frame(maxWidth: 420, alignment: .leading)
        .frame(maxWidth: .infinity)
    }

    private var bookmarkButton: some View {
        Button {
            isBookmarked.toggle()
        } label: {
            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(isBookmarked ? accentBlueDeep : textSecondary)
                .frame(width: 40, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color.white.opacity(0.62))
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(accentBlue.opacity(0.16), lineWidth: 1)
                }
        }
        .buttonStyle(.plain)
        .shadow(color: accentBlue.opacity(0.04), radius: 8, x: 0, y: 3)
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
                    fill: accentBlue.opacity(0.88),
                    border: accentBlue.opacity(0.10),
                    foreground: .white
                )
            )
            .accessibilityIdentifier("keepReadingButton")

            Button("Done for Now") {
            }
            .buttonStyle(
                MomentActionButtonStyle(
                    fill: Color.white.opacity(0.74),
                    border: accentBlue.opacity(0.18),
                    foreground: accentBlueDeep
                )
            )
            .accessibilityIdentifier("doneForNowButton")
        }
        .frame(maxWidth: 448)
    }
}

private struct GospelMoment {
    let gospel: String
    let chapterVerse: String
    let text: String
}

private struct MomentActionButtonStyle: ButtonStyle {
    let fill: Color
    let border: Color
    let foreground: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(foreground)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(fill)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(border, lineWidth: 1)
            }
            .shadow(color: Color.black.opacity(0.03), radius: 12, x: 0, y: 6)
            .opacity(configuration.isPressed ? 0.92 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
            .animation(.easeOut(duration: 0.16), value: configuration.isPressed)
    }
}

#Preview {
    ContentView()
}
