class EncoreAlpha < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  release_version = "2.0.0-alpha.8"
  checksums = {
    "aarch64-apple-darwin" => "f9346e13f3f7a25af77432e08a4a9ab6752c21a71dbd36076ad259f0465d1eba",
    "x86_64-apple-darwin" => "42777a07cf616d4867e3879e5e0ebf929a82d23bdb1f25d9e0fc4cab192eabb2",
    "aarch64-unknown-linux-gnu" => "44caffc14b8391edb01489d480625540c7691ae1f357049fe48696f0f95018ad",
    "x86_64-unknown-linux-gnu" => "b7ea561ba5fdb798643d9a380962f2c37748b849797cda85b948bbfa8a19fa0e",
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
    bin.install_symlink libexec/"bin/encore" => "encore-alpha"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/encore-alpha --version")
  end
end
