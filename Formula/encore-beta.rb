class EncoreBeta < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  # Keep the bundled libraries' @rpath IDs.  Everything in the archive loads
  # them by relative paths, and some (ICU's) have no header room for the
  # absolute IDs Homebrew would write instead.
  preserve_rpath

  release_version = "2.0.0-beta.4"
  checksums = {
    "aarch64-apple-darwin" => "c621c34783ae65c9e7e87d2f517761774bb74b5daa5dd72302f8721f818bd734",
    "x86_64-apple-darwin" => "1085703e0ecd21b9324204e73b532a050d2e2d058a111ee31e40ad592257a05c",
    "aarch64-unknown-linux-gnu" => "2d89ba913af12dbc6341676627a1c4ddbcc1e009c3d27b9851598492b903906f",
    "x86_64-unknown-linux-gnu" => "eedb752f5b583cd01ff507f778546af06015ed16a170114f960c5c9326dd8675",
  }

  arch = "aarch64"
  platform = "apple-darwin"
  on_intel do
    arch = "x86_64"
  end
  on_linux do
    platform = "unknown-linux-gnu"
  end
  target = "#{arch}-#{platform}"

  url "https://d2f391esomvqpi.cloudfront.net/v2/v#{release_version}/encore-#{target}.tar.gz"
  version release_version
  sha256 checksums.fetch(target)

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/encore" => "encore-beta"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/encore-beta --version")
  end
end
