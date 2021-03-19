class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.10.2"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.10.2-darwin_amd64.tar.gz"
    sha256 "c7fffd1b7178c6e5c40459a3ef576afa6ce6732416f736724b8b4e4c082b07a7"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.10.2-darwin_arm64.tar.gz"
    sha256 "227014a4f0f7e24330f4e1a1f97f24533a304523e34188c60dd7540d9aceff40"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
