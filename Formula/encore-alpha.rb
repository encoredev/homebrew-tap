class EncoreAlpha < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  # Keep the bundled libraries' @rpath IDs.  Everything in the archive loads
  # them by relative paths, and some (ICU's) have no header room for the
  # absolute IDs Homebrew would write instead.
  preserve_rpath

  release_version = "2.0.0-alpha.17"
  checksums = {
    "aarch64-apple-darwin" => "aa3aa338b403aad672f41e0007b5230cea2ea131600d7fbcb0d41e57ba8fef62",
    "x86_64-apple-darwin" => "d6f93cd358edcebcddaaac0f129586c475a2e26624bd5c84283690f93a371ef6",
    "aarch64-unknown-linux-gnu" => "ec5b105d55c0d582d4539519b754d0d9904047bd05be26410b3a93ab6e13fa81",
    "x86_64-unknown-linux-gnu" => "de552d8358795417f2d3be7bbd2ad165f620408abef97b27c37c0081ef23e509",
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
