class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "1.8.1"
  license "Mozilla Public License, version 2.0"
  head "https://github.com/encoredev/encore.git", branch: "main"

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.8.1-darwin_amd64.tar.gz"
    sha256 "2895f61bfb69f41c17a0b69e3c665fd97170f64cbc39aa9037a4e100422818e2"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.8.1-darwin_arm64.tar.gz"
    sha256 "9881e0fb223611bb33e3f70abd4e5de79779a4f5e6ee82cf21ea3e1b7eebe3be"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.8.1-linux_amd64.tar.gz"
    sha256 "54d4130fd4a401400f8cbe6efa09e57607a98972e15694980366b2dee38a823a"
  end
  if OS.linux? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.8.1-linux_arm64.tar.gz"
    sha256 "848a7fc9dce60a3d9d8219f334d8e4eb37a4a30fc599643ab016ab2a9e1bc52e"
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
