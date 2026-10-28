class EncoreBeta < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  # Keep the bundled libraries' @rpath IDs.  Everything in the archive loads
  # them by relative paths, and some (ICU's) have no header room for the
  # absolute IDs Homebrew would write instead.
  preserve_rpath

  release_version = "2.0.0-beta.6"
  checksums = {
    "aarch64-apple-darwin" => "43f198dfd6c82bb0caa0c99ba103feb7211b55ca7fe5f55c4b873fffe6578bd7",
    "x86_64-apple-darwin" => "b4e9d98ba797ac228e1a0c0b1b12050ef4befdef0085889af1ebe59fca786449",
    "aarch64-unknown-linux-gnu" => "23ba2a2319adc9cf81eda1eda76416bf200c1822e9744a85b305accd737796d2",
    "x86_64-unknown-linux-gnu" => "487ac71d621124d7d7dee1e98710574c884664380210a9e65ad316f7987eeae6",
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
