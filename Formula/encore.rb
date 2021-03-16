class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.9.9"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.10.0-darwin_amd64.tar.gz"
    sha256 "276dcfba63bd53239de83f6e3ee614cf70887e5a7304bb891e11f2a30dde49a3"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.10.0-darwin_arm64.tar.gz"
    sha256 "b03474b0007437af4ac4d5d4ebe69774966c7e4f8092635d8bc8e18c2a261dca"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
