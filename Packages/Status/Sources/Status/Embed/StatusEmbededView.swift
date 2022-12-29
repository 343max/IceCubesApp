import SwiftUI
import Models
import DesignSystem

@MainActor
public struct StatusEmbededView: View {
  @EnvironmentObject private var theme: Theme
  
  public let status: Status
  
  public init(status: Status) {
    self.status = status
  }
  
  public var body: some View {
    HStack {
      VStack(alignment: .leading) {
        makeAccountView(account: status.reblog?.account ?? status.account)
        StatusRowView(viewModel: .init(status: status, isEmbed: true))
      }
      Spacer()
    }
    .padding(8)
    .background(theme.secondaryBackgroundColor)
    .cornerRadius(4)
    .overlay(
      RoundedRectangle(cornerRadius: 4)
        .stroke(.gray.opacity(0.35), lineWidth: 1)
    )
    .padding(.top, 8)
  }
  
  private func makeAccountView(account: Account) -> some View {
    HStack(alignment: .center) {
      AvatarView(url: account.avatar, size: .embed)
      VStack(alignment: .leading, spacing: 0) {
        status.account.displayNameWithEmojis
          .font(.footnote)
          .fontWeight(.semibold)
        Group {
          Text("@\(account.acct)") +
          Text(" ⸱ ") +
          Text(status.reblog?.createdAt.formatted ?? status.createdAt.formatted)
        }
        .font(.caption)
        .foregroundColor(.gray)
      }
    }
  }
}
