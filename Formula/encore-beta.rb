class EncoreBeta < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  # Keep the bundled libraries' @rpath IDs.  Everything in the archive loads
  # them by relative paths, and some (ICU's) have no header room for the
  # absolute IDs Homebrew would write instead.
  preserve_rpath

  release_version = "2.0.0-beta.14"
  checksums = {
    "aarch64-apple-darwin" => "16ca24b948cc0a46097f14b5ab9983d82161c51caf0635807be52f98aa979856",
    "x86_64-apple-darwin" => "d98134cd6b4f014fc85f6c03a34ac02dd969580188de57b4b645fc5f5ea7db02",
    "aarch64-unknown-linux-gnu" => "c02e1263fdf93d48d8ffee55b98867899a2dbd020ee3b1bd16ee43868658eaed",
    "x86_64-unknown-linux-gnu" => "308b76f3a8ea8e786ec5a5634808f038f47205459134617254066e51888bbb2b",
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
