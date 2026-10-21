class EncoreAlpha < Formula
  desc "Encore v2 CLI for building backend applications"
  homepage "https://encore.dev"
  license "MPL-2.0"

  release_version = "2.0.0-alpha.14"
  checksums = {
    "aarch64-apple-darwin" => "cc586b91e1d0d6e445f5a8d429f9a024a26564e0fb63a7b6caa9d205d95eb85e",
    "x86_64-apple-darwin" => "8456bfff55853707962537f53dc06d7f473c7b15f46bf5a4223ac2a6ebf57418",
    "aarch64-unknown-linux-gnu" => "9e8f585cf464a57c3f48695d2cf32e543cdb9092eab1bc568760db630cddc07d",
    "x86_64-unknown-linux-gnu" => "27a9f1b5a935dfa565d03043a052ab79d9062fe1ebe92ae31f1943559b57b9a9",
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
