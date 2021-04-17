class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.12.0"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.12.0-darwin_amd64.tar.gz"
    sha256 "e978a0f52126a5b35cd392cf61f2a888223da8c2392f8360b1ea92da959030f4"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.12.0-darwin_arm64.tar.gz"
    sha256 "2881e344576418e5a7ee81ca0587ca9a35ff649821f7c1fa6a37d090cb18617e"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
