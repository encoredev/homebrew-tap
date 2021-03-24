class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.10.3"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.10.3-darwin_amd64.tar.gz"
    sha256 "10d7bb3fce64fb963b81b36f694414d26dd5ff9e5f794e21f97f9b26c3450688"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.10.3-darwin_arm64.tar.gz"
    sha256 "ef125efe3151803d6db6503e3bd4634c894840323ce05d7a043e7d362814497c"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
