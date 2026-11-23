class EncoreBeta < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  # Keep the bundled libraries' @rpath IDs.  Everything in the archive loads
  # them by relative paths, and some (ICU's) have no header room for the
  # absolute IDs Homebrew would write instead.
  preserve_rpath

  release_version = "2.0.0-beta.11"
  checksums = {
    "aarch64-apple-darwin" => "8753199ee6002eff9130e45e6da27b2e00e2b7e028273c0d02d84686e3ece66a",
    "x86_64-apple-darwin" => "37fa4f21375f9cb84f62a7c75ca459994133b3637bb03d491542de55b09c6209",
    "aarch64-unknown-linux-gnu" => "c3326f236a183449b48c77128ac114cb16bb571bdca9ff05017a65ea149a3a68",
    "x86_64-unknown-linux-gnu" => "d0ceaa2b1b68aed1dbdb309a0894f715a7a5146749160e7ec21cf3e3fb28372c",
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
