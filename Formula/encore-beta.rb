class EncoreBeta < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  # Keep the bundled libraries' @rpath IDs.  Everything in the archive loads
  # them by relative paths, and some (ICU's) have no header room for the
  # absolute IDs Homebrew would write instead.
  preserve_rpath

  release_version = "2.0.0-beta.15"
  checksums = {
    "aarch64-apple-darwin" => "c1f82860586d53f7778ed4cb95c5a5ea6f8ba2c4a76fe679a900890760fe1035",
    "x86_64-apple-darwin" => "4c30479ae730423d8ac9a0a35de8779db95fc50b52e851e8218ef7ca199ff61b",
    "aarch64-unknown-linux-gnu" => "6028b7b6d9fa1f3a1810c090ee57da9c480f86729fffa354a47ebbb41d3379d3",
    "x86_64-unknown-linux-gnu" => "b8af9fbf7ae3781364be362779c79b693f442e4d5e8e19aaee50b948388ebf57",
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

    # `git push` to an encore:// remote runs git-remote-encore, which git
    # finds on PATH by that exact name, so only one formula can link it.
    # Another Encore formula's (v1's, or another channel's) pushes the same
    # way, so it is left in place; this formula's own, from the version being
    # upgraded, is replaced.
    linked = HOMEBREW_PREFIX/"bin/git-remote-encore"
    other_formula = linked.exist? && !linked.realpath.to_s.start_with?("#{HOMEBREW_CELLAR}/#{name}/")
    bin.install_symlink libexec/"bin/git-remote-encore" unless other_formula
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
