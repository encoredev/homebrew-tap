class EncoreAlpha < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  release_version = "2.0.0-alpha.12"
  checksums = {
    "aarch64-apple-darwin" => "2a49b7c94ae3d5a2f7cc8ee8d3a8eef9bf8548c3a48d5fbdc0c5fa44a4f41637",
    "x86_64-apple-darwin" => "6a84033d928c1fb33f0a35021790fca4a1230683abeddf468efc08b379663407",
    "aarch64-unknown-linux-gnu" => "d74f75a0103d8abcf4f9188230a5b37e1f5d66616bd46e8de309225d0ca6f5e0",
    "x86_64-unknown-linux-gnu" => "a2ca0770e27fb82760170376dcfe6ca6434afade44ac211d3dbff2896acf505a",
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
