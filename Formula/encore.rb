class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.16.0"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.16.0-darwin_amd64.tar.gz"
    sha256 "25177d5fbd2db3ad22ec52ecb180538afa4983ed24283c13d10e2477d29a20bb"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.16.0-darwin_arm64.tar.gz"
    sha256 "e21f559f026f7b1fd374d95477a26b1301584d46970e09611d73920e20efa653"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
