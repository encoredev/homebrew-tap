class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.9.6"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.6-darwin_amd64.tar.gz"
    sha256 "f344a647da845405ad4c21e356d28482d3ad1f5ca843c6bb18362953233f5b3c"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.9.6-darwin_arm64.tar.gz"
    sha256 "007607a912c112910d8dfac1ed6fb82800984522dd65be1c9060d2d60f49dfed"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
