class EncoreBeta < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  # Keep the bundled libraries' @rpath IDs.  Everything in the archive loads
  # them by relative paths, and some (ICU's) have no header room for the
  # absolute IDs Homebrew would write instead.
  preserve_rpath

  release_version = "2.0.0-beta.13"
  checksums = {
    "aarch64-apple-darwin" => "dc4ec5a62d0981b1ac54f34522426903feb02cca774cfc7a5f16b38d36abbacf",
    "x86_64-apple-darwin" => "9acb554179fd04ebef373c62ab2ed99e64b08f0b6a0513200a5fca6add9a8f17",
    "aarch64-unknown-linux-gnu" => "d461b6370c94fb2c134b47581b6fa6c71b0371ee323db1afa655217df71ae51b",
    "x86_64-unknown-linux-gnu" => "dfe176ba713064aba0820908421b9cdd62e642428bee46bb97f6960d05825bfd",
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

  def caveats
    <<~EOS
      Encore downloads its optional parts, such as the Postgres local databases
      run on and each language's runtime, when an app first needs them, and
      keeps them apart from this formula. To fetch what an app needs now, run
      in the app:
        encore-beta component add
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/encore-beta --version")
  end
end
