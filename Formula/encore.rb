class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "0.17.0"
  license ""
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.17.0-darwin_amd64.tar.gz"
    sha256 "36b53d688341b333491ff0f487a2b4b4baed677633398ac15320b647843bec77"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-0.17.0-darwin_arm64.tar.gz"
    sha256 "78b8a198ddb2a636cde8b93a73026fceca969630f47644e1a3400b9bb421e387"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    system "#{bin}/encore", "check"
  end
end
