class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.14.5"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.14.5-darwin_amd64.tar.gz"
    sha256 "4f4591e9f2f00a091287186c509b7d335a3569fc7e982fbe6c944d2d44a6ded5"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.14.5-darwin_arm64.tar.gz"
    sha256 "d4a43ef83f9852cdba7c2ad0dce35960a1257e69913e16b50438a9f5a14fa4ae"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
