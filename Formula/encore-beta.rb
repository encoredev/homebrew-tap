class EncoreBeta < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  # Keep the bundled libraries' @rpath IDs.  Everything in the archive loads
  # them by relative paths, and some (ICU's) have no header room for the
  # absolute IDs Homebrew would write instead.
  preserve_rpath

  release_version = "2.0.0-beta.9"
  checksums = {
    "aarch64-apple-darwin" => "2b2776d9db9561f9630eca86daff6ea767a8c72fa840caba8ce4ab8193321ef2",
    "x86_64-apple-darwin" => "1952101ba28aee9ecd522744e13b40c76c40b7e2e2fe2143683c30cf42499323",
    "aarch64-unknown-linux-gnu" => "976ae0305176dac8a8f937144e4684ea5f7a4392eaaf6067093f1cd9493482b2",
    "x86_64-unknown-linux-gnu" => "26368a228989154dab15d5aa40850a646bb6ba35b3560f688175c96e644f851c",
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
