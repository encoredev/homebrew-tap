class EncoreBeta < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  # Keep the bundled libraries' @rpath IDs.  Everything in the archive loads
  # them by relative paths, and some (ICU's) have no header room for the
  # absolute IDs Homebrew would write instead.
  preserve_rpath

  release_version = "2.0.0-beta.5"
  checksums = {
    "aarch64-apple-darwin" => "efed0f2cc793f26c2938839c040a576bc7fc3bc6657bb96d6ed4c0f67d200177",
    "x86_64-apple-darwin" => "acd07dee38613a40d2a59c6c72a119ad9a4abb60c9e0531a18c969474a029adc",
    "aarch64-unknown-linux-gnu" => "e26bcb6aa40433c83af3c0746ba707536541e5b0223e66f5041559a1cbecc785",
    "x86_64-unknown-linux-gnu" => "6d4bcc36c0d8f657c7a7a9f1fab66c4c3ef6986e191a9c34ff25a6c080e8bc0a",
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
