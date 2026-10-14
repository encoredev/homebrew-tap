class EncoreAlpha < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  release_version = "2.0.0-alpha.5"
  checksums = {
    "aarch64-apple-darwin" => "2234cff0377e160dea0588d367a1dd16f6aff71865f349e3a421869c4ffd3869",
    "x86_64-apple-darwin" => "7737114329ed5abe686b9ea03ab1ac8ff54409cea0b369466f4db4d2d6d989dc",
    "aarch64-unknown-linux-gnu" => "1531f5e6d72dfea52357010dfcbcff921d9009ecdb53eb0a967e9deece01e1ea",
    "x86_64-unknown-linux-gnu" => "80ec9acd503cf7883f633507bd9a8dc7c32ffe52986bbd740cf2eade02419c44",
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
