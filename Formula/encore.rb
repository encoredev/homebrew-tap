class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.11.0"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.11.0-darwin_amd64.tar.gz"
    sha256 "b65d16fd28adabed6cb470b4c7f516382712ad52bfebcc4c0a93d89462014e56"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.11.0-darwin_arm64.tar.gz"
    sha256 "88b1087d0598d6246ebb941436f61ac1185d8f695aa40736ef712f83484e9d27"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
