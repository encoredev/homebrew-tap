class EncoreAlpha < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  release_version = "2.0.0-alpha.15"
  checksums = {
    "aarch64-apple-darwin" => "888008caa5278a66845bcd015ba30253650921d416b0e069408cb47d41f7796c",
    "x86_64-apple-darwin" => "8ce444e45c88262fbfa79e53669106d1c022fdde537134805d0fce3ba333ef8c",
    "aarch64-unknown-linux-gnu" => "0d867d88607ee2f31ab8fd5e68fc06d5edde5458157c290dec33ed8e80b1c4ca",
    "x86_64-unknown-linux-gnu" => "696d983258c19396cbb0220cc57741cd48b4effcfb80eab91aa8c192d9335def",
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
