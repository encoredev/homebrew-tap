class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.39.5"
    checksums = {
        "darwin_arm64" => "f517e4dc8c5fae5944afcffca5f43f9cc126741ac40fab5190b4d41615ecccb4",
        "darwin_amd64" => "0c48ca75522f8a2c2ca48d9f656c28695661711626f5ba4e66ef542f6041745e",
        "linux_arm64"  => "abaa53e00d545dae9561145efad68fe5f5294f90e199710c0df79e785ac197ab",
        "linux_amd64"  => "706dba6b49fe6a1bcea1a7cd75fc67bda790d4b2e15f7faaf83fcfd5e79c9d16",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

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
