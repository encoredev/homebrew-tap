class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.17.1"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.17.1-darwin_amd64.tar.gz"
    sha256 "eaca3536568124da08bc6b64abab71e01dca808f0c33943674e6ea4ba9b337f2"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.17.1-darwin_arm64.tar.gz"
    sha256 "dd972ff9b712cbad6bad8ffb6f0c4521dfef9b0e7f5d3b40859945e94408339e"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
