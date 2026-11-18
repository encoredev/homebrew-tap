class EncoreBeta < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  # Keep the bundled libraries' @rpath IDs.  Everything in the archive loads
  # them by relative paths, and some (ICU's) have no header room for the
  # absolute IDs Homebrew would write instead.
  preserve_rpath

  release_version = "2.0.0-beta.10"
  checksums = {
    "aarch64-apple-darwin" => "6ad8397d85dcd067f3f3355c4c1a54f726522a10aedaef1eadc3e59b9dbefc4b",
    "x86_64-apple-darwin" => "93f9132b3b0946ce047c0d85bd0a97ecdbf77d3c55362f04e9f0bf0515d5453d",
    "aarch64-unknown-linux-gnu" => "179d97b04bfb69c8373e1606a83f1c04cba0c121c5e7480e569bf1fbd3357970",
    "x86_64-unknown-linux-gnu" => "8004cd09a2c4729377e6d450eefd35051ba8e138da37a12e5fe7c062d638bd76",
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
