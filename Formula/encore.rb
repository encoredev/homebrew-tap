class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.13.1"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.13.1-darwin_amd64.tar.gz"
    sha256 "fbb39919af07c82ee581b17fe7c36bbe029a4a58721912b90b065a51d17f6d11"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.13.1-darwin_arm64.tar.gz"
    sha256 "7a5fd3e4d5b760c0d28069b3151ae72b21a2d7c3ae422b5194fa989a919a0700"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
