class EncoreBeta < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  # Keep the bundled libraries' @rpath IDs.  Everything in the archive loads
  # them by relative paths, and some (ICU's) have no header room for the
  # absolute IDs Homebrew would write instead.
  preserve_rpath

  release_version = "2.0.0-beta.7"
  checksums = {
    "aarch64-apple-darwin" => "b2cc045f04d4d8d3c8df9a3960c9367cc73f9d8df0158c028502171bf8bb3fb4",
    "x86_64-apple-darwin" => "0a07eb23eee01cb0e8e5e093c4a19e1486cbb9e53a9e30557ccc1da529ac64d0",
    "aarch64-unknown-linux-gnu" => "055eb160b9b6f28ac967662ac4c438710357a066bf358752d92e4c87d0b26706",
    "x86_64-unknown-linux-gnu" => "9e6e22636696a51f90baf7b8f5d2083103b51fd909c43eca42a911c0e523d73c",
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
