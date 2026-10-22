class EncoreAlpha < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  release_version = "2.0.0-alpha.16"
  checksums = {
    "aarch64-apple-darwin" => "354e84a8686c7d3f70c0b6ccb2f59b5ba07eb6dc2c61af6d0b0d6cdefb3cbb26",
    "x86_64-apple-darwin" => "08358c9eaab6d0a3251ef3720b954da71cc9184bf7c89286c86a72603cb16af1",
    "aarch64-unknown-linux-gnu" => "aa25168305d48d0bb822b6eceb2dbb08aa24d92c74ba5612f6677796b591e1bd",
    "x86_64-unknown-linux-gnu" => "047c9d98cff4cd4663be3730315687b3f645704181feed6a3bbe342c7346b235",
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
