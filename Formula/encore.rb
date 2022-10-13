class Encore < Formula
  desc "The static analysis-powered Go framework for building backend applications"
  homepage "https://encore.dev"
  version "1.8.9"
  license "Mozilla Public License, version 2.0"
  head "https://github.com/encoredev/encore.git", branch: "main"

  if OS.mac? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.8.0-darwin_amd64.tar.gz"
    sha256 "1037f9319e6ea3c5103e459418edec19813a35499930fcf17ab5f7e215ddd5a9"
  end
  if OS.mac? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.8.0-darwin_arm64.tar.gz"
    sha256 "ece1fe38ee1e9c1e5ac10b76c4335c88eb49d4f3fc42014adfb0cf0f2887978a"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.8.0-linux_amd64.tar.gz"
    sha256 "c112b06f9304261cce4fc5940a414bbb6396e840d9fdfb6191cb1bd54ae0fd3f"
  end
  if OS.linux? && Hardware::CPU.arm?
    url "https://d2f391esomvqpi.cloudfront.net/encore-1.8.0-linux_arm64.tar.gz"
    sha256 "4e4bf2899b52ac3afdcde57c06089499d1c49eccc1d76ae132a38464118385b3"
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
