class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "1.4.0"
  license "Mozilla Public License, version 2.0"
  head "https://github.com/encoredev/encore.git", branch: "main"

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.4.0-darwin_amd64.tar.gz"
    sha256 "337d0521d1d815b6a37c85a9e85f9450af432864daa4ac5c04d592fb4985196a"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.4.0-darwin_arm64.tar.gz"
    sha256 "9834849b252ab623aed59d249becf1ede3f1d30bfc8eeb9e5848d01fece039d6"
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir[libexec/"bin/*"]

    # Install bash completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
    (bash_completion/"encore").write output

    # Install zsh completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
    (zsh_completion/"_encore").write output

    # Install fish completion
    output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
    (fish_completion/"encore.fish").write output
  end

  test do
    system "#{bin}/encore", "check"
  end
end
