class EncoreAlpha < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  release_version = "2.0.0-alpha.7"
  checksums = {
    "aarch64-apple-darwin" => "0b35da324b6cc98dbae9dee3e384cd7632189d0e8e388e93b426c9f65068346e",
    "x86_64-apple-darwin" => "67d4aa45c51a31c17ee8fff6329e2da8eb842bf2722a2dc7843ef1d70565afa4",
    "aarch64-unknown-linux-gnu" => "4b8688c745adfab878524fb9352b8fd4785193a00bb08ffa6811a84fdb951391",
    "x86_64-unknown-linux-gnu" => "486f2655f0c6d32d672c7537c478656985bdfd40208778a3ebd124bfc50d1f27",
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
